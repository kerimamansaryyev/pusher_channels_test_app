import 'dart:async';

import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:injectable/injectable.dart';
import 'package:pusher_channels_test_app/core/utils/either/either.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/data/constants/pusher_channels_connection_constants.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/data/factories/pusher_channels_client_factory.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/entities/message_not_triggered_failure.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/entities/pusher_channels_connection_result.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/entities/pusher_channels_event_entity.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/repositories/abstract_pusher_channels_connection_repository.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/repositories/pusher_channels_connection_repository.dart';

@LazySingleton(
  as: PusherChannelsConnectionRepository,
)
final class PusherChannelsConnectionRepositoryImpl
    extends AbstractPusherChannelsConnectionRepository {
  final PusherChannelsClientFactory _pusherChannelsClientFactory;
  StreamSubscription? _clientConnectionStreamSubs;
  PusherChannelsClient? _pusherChannelsClient;

  PusherChannelsConnectionRepositoryImpl(this._pusherChannelsClientFactory) {
    resetToDefaults();
  }

  @override
  Either<MessageNotTriggeredFailure, PusherChannelsUserMessageEventEntity>
      triggerClientEventOnPresenceChannel({
    required String message,
    required String channelName,
    required String eventName,
  }) {
    final dataToSend = {
      'data': message,
    };

    final presenceChannel = _createIfNotCreatedPresenceChannel(
      channelName,
    )?..trigger(
        eventName: eventName,
        data: dataToSend,
      );

    final myId = presenceChannel?.state?.members?.getMyId();

    if (presenceChannel == null || myId == null) {
      return const Left(MessageNotTriggeredFailure());
    }

    return Right(
      PusherChannelsUserMessageEventEntity(
        name: eventName,
        channelName: presenceChannel.name,
        data: dataToSend,
        dataAsMap: dataToSend,
        isMyMessage: true,
        userId: presenceChannel.state?.members?.getMyId(),
        messageContent: message,
      ),
    );
  }

  @override
  void resetPresenceChannelState({required String channelName}) {
    _pusherChannelsClient?.presenceChannel(
      channelName,
      authorizationDelegate:
          PusherChannelsConnectionConstants.createAuthorizationDelegate(),
      forceCreateNewInstance: true,
    );
  }

  @override
  void connect() {
    _pusherChannelsClient?.connect();
  }

  @override
  void resetToDefaults() {
    _clientConnectionStreamSubs?.cancel();
    _pusherChannelsClient?.dispose();
    _clientConnectionStreamSubs = null;
    _pusherChannelsClient = null;
    final client =
        _pusherChannelsClient = _pusherChannelsClientFactory.createClient(
      options: PusherChannelsConnectionConstants.pusherChannelsOptions,
      connectionErrorHandler: (exception, trace, _) =>
          _onConnectionError(exception, trace),
    );
    _clientConnectionStreamSubs =
        client.lifecycleStream.listen(_onClientConnectionStreamEvent);
  }

  @override
  Stream<PusherChannelsEventEntity> onPresenceChannelEvent({
    required String channelName,
    String? eventNameToBind,
  }) {
    final presenceChannel = _createIfNotCreatedPresenceChannel(channelName);
    final stream = eventNameToBind == null
        ? presenceChannel?.bindToAll()
        : presenceChannel?.bind(eventNameToBind);

    return stream?.transform<PusherChannelsEventEntity>(
          StreamTransformer.fromHandlers(
            handleData: (event, sink) {
              final myId = presenceChannel?.state?.members?.getMyId();
              switch (event.name) {
                case Channel.subscriptionSucceededEventName:
                  sink.add(
                    PusherChannelsChatBeganEventEntity(
                      channelName: event.channelName,
                      data: event.data,
                      dataAsMap: event.tryGetDataAsMap(),
                      myUserId: myId,
                      name: event.name,
                    ),
                  );
                  return;
                case Channel.memberAddedEventName:
                  sink.add(
                    PusherChannelsUserJoinedEventEntity(
                      channelName: event.channelName,
                      data: event.data,
                      dataAsMap: event.tryGetDataAsMap(),
                      userId: event
                          .tryGetDataAsMap()?[PusherChannelsEvent.userIdKey]
                          ?.toString(),
                      name: event.name,
                    ),
                  );
                  return;
                case Channel.memberRemovedEventName:
                  sink.add(
                    PusherChannelsUserLeftEventEntity(
                      channelName: event.channelName,
                      data: event.data,
                      dataAsMap: event.tryGetDataAsMap(),
                      userId: event
                          .tryGetDataAsMap()?[PusherChannelsEvent.userIdKey]
                          ?.toString(),
                      name: event.name,
                    ),
                  );
                  return;

                case 'client-event':
                  sink.add(
                    PusherChannelsUserMessageEventEntity(
                      messageContent:
                          event.tryGetDataAsMap()?['data']?.toString() ?? '',
                      isMyMessage: false,
                      channelName: event.channelName,
                      data: event.data,
                      dataAsMap: event.tryGetDataAsMap(),
                      userId: event.userId,
                      name: event.name,
                    ),
                  );
              }
            },
          ),
        ) ??
        const Stream.empty();
  }

  PresenceChannel? _createIfNotCreatedPresenceChannel(String channelName) {
    final presenceChannel = _pusherChannelsClient?.presenceChannel(
      channelName,
      authorizationDelegate:
          PusherChannelsConnectionConstants.createAuthorizationDelegate(),
    );
    if (presenceChannel?.state?.status != ChannelStatus.subscribed) {
      presenceChannel?.subscribeIfNotUnsubscribed();
    }
    return presenceChannel;
  }

  void _onClientConnectionStreamEvent(
    PusherChannelsClientLifeCycleState lifeCycleState,
  ) {
    switch (lifeCycleState) {
      case PusherChannelsClientLifeCycleState.pendingConnection:
        fireConnectionResultEvent(
          const PusherChannelsConnectionPending(),
        );
        return;
      case PusherChannelsClientLifeCycleState.establishedConnection:
        fireConnectionResultEvent(
          const PusherChannelsConnectionSucceeded(),
        );
      default:
        return;
    }
  }

  void _onConnectionError(
    dynamic exception,
    StackTrace trace,
  ) =>
      fireConnectionErrorEvent(exception, trace);
}
