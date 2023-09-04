import 'package:injectable/injectable.dart';
import 'package:pusher_channels_test_app/src/features/chat/data/chat_constants.dart';
import 'package:pusher_channels_test_app/src/features/pusher_channels_connection/domain/repositories/pusher_channels_connection_repository.dart';

@injectable
class ResetPresenceChannelState {
  final PusherChannelsConnectionRepository _pusherChannelsConnectionRepository;

  ResetPresenceChannelState(
    this._pusherChannelsConnectionRepository,
  );

  void call() => _pusherChannelsConnectionRepository.resetPresenceChannelState(
        channelName: ChatConstants.channelName,
      );
}
