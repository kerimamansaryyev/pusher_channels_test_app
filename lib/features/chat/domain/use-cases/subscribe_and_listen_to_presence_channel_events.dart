import 'package:injectable/injectable.dart';
import 'package:pusher_channels_test_app/features/chat/data/chat_constants.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/entities/pusher_channels_event_entity.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/repositories/pusher_channels_connection_repository.dart';

@injectable
class SubscribeAndListenToPresenceChannelEvents {
  final PusherChannelsConnectionRepository _pusherChannelsConnectionRepository;

  SubscribeAndListenToPresenceChannelEvents(
    this._pusherChannelsConnectionRepository,
  );

  Stream<PusherChannelsEventEntity> call({
    String? eventNameToBind,
  }) =>
      _pusherChannelsConnectionRepository.onPresenceChannelEvent(
        channelName: ChatConstants.channelName,
        eventNameToBind: eventNameToBind,
      );
}
