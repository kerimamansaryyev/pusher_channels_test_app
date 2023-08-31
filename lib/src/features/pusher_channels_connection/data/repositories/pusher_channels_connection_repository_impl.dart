import 'dart:async';

import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:injectable/injectable.dart';
import 'package:pusher_channels_test_app/src/features/pusher_channels_connection/data/constants/pusher_channels_connection_constants.dart';
import 'package:pusher_channels_test_app/src/features/pusher_channels_connection/data/models/pusher_channels_event_model.dart';
import 'package:pusher_channels_test_app/src/features/pusher_channels_connection/domain/entities/pusher_channels_connection_result.dart';
import 'package:pusher_channels_test_app/src/features/pusher_channels_connection/domain/entities/pusher_channels_event_entity.dart';
import 'package:pusher_channels_test_app/src/features/pusher_channels_connection/domain/repositories/pusher_channels_connection_repository.dart';

@LazySingleton(
  as: PusherChannelsConnectionRepository,
)
final class PusherChannelsConnectionRepositoryImpl
    implements PusherChannelsConnectionRepository {
  StreamSubscription? _clientConnectionStreamSubs;
  PusherChannelsClient? _pusherChannelsClient;
  final StreamController<PusherChannelsConnectionResult>
      _connectionStreamController = StreamController.broadcast();

  PusherChannelsConnectionRepositoryImpl() {
    resetToDefaults();
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
    final client = _pusherChannelsClient = PusherChannelsClient.websocket(
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
    final presenceChannel = _createPresenceChannel(channelName);
    final stream = eventNameToBind == null
        ? presenceChannel?.bindToAll()
        : presenceChannel?.bind(eventNameToBind);

    return stream?.map<PusherChannelsEventModel>(
          (event) {
            final myId = presenceChannel?.state?.members?.getMyId();
            return PusherChannelsEventModel(
              channelName: channelName,
              data: event.data,
              isMyMessage: myId != null && myId == event.userId,
              dataAsMap: event.tryGetDataAsMap(),
              name: event.name,
              userId: event.userId,
            );
          },
        ) ??
        const Stream.empty();
  }

  @override
  Stream<PusherChannelsConnectionResult> onConnectionChanged() =>
      _connectionStreamController.stream;

  PresenceChannel? _createPresenceChannel(String channelName) {
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
        _connectionStreamController.add(
          const PusherChannelsConnectionPending(),
        );
        return;
      case PusherChannelsClientLifeCycleState.establishedConnection:
        _connectionStreamController.add(
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
      _safelyAddConnectionResultToController(
        PusherChannelsConnectionFailed(
          exception: exception,
          stackTrace: trace,
        ),
      );

  void _safelyAddConnectionResultToController(
    PusherChannelsConnectionResult event,
  ) {
    if (!_connectionStreamController.isClosed) {
      _connectionStreamController.add(
        event,
      );
    }
  }
}
