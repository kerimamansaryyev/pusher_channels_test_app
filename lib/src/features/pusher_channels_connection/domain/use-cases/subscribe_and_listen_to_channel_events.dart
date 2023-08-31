import 'package:injectable/injectable.dart';
import 'package:pusher_channels_test_app/src/features/pusher_channels_connection/domain/entities/pusher_channels_event_entity.dart';
import 'package:pusher_channels_test_app/src/features/pusher_channels_connection/domain/repositories/pusher_channels_connection_repository.dart';

@injectable
class SubscribeAndListenToChannelEvents {
  final PusherChannelsConnectionRepository _pusherChannelsConnectionRepository;

  SubscribeAndListenToChannelEvents(
    this._pusherChannelsConnectionRepository,
  );

  Stream<PusherChannelsEventEntity> call({
    String? eventNameToBind,
  }) =>
      _pusherChannelsConnectionRepository.onPresenceChannelEvent(
        channelName: 'presence-channel',
        eventNameToBind: eventNameToBind,
      );
}
