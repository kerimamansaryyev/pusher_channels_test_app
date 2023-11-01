import 'package:injectable/injectable.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/repositories/pusher_channels_connection_repository.dart';

@injectable
class ResetPusherChannelsClient {
  final PusherChannelsConnectionRepository _pusherChannelsConnectionRepository;

  ResetPusherChannelsClient(
    this._pusherChannelsConnectionRepository,
  );

  void call() => _pusherChannelsConnectionRepository.resetToDefaults();
}
