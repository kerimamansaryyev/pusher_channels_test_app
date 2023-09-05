import 'package:injectable/injectable.dart';
import 'package:pusher_channels_test_app/core/domain/failure.dart';
import 'package:pusher_channels_test_app/core/utils/either/either.dart';
import 'package:pusher_channels_test_app/features/chat/data/chat_constants.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/entities/pusher_channels_event_entity.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/repositories/pusher_channels_connection_repository.dart';

@injectable
class TriggerClientEventOnPresenceChannel {
  final PusherChannelsConnectionRepository _pusherChannelsConnectionRepository;

  const TriggerClientEventOnPresenceChannel(
    this._pusherChannelsConnectionRepository,
  );

  Either<Failure, PusherChannelsUserMessageEventEntity> call({
    required String message,
  }) =>
      _pusherChannelsConnectionRepository.triggerClientEventOnPresenceChannel(
        message: message,
        channelName: ChatConstants.channelName,
        eventName: ChatConstants.triggeredEventName,
      );
}
