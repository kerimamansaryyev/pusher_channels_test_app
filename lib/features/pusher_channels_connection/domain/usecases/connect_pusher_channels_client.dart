import 'package:injectable/injectable.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/repositories/pusher_channels_connection_repository.dart';

@injectable
class ConnectPusherChannelsClient {
  final PusherChannelsConnectionRepository _pusherChannelsConnectionRepository;

  const ConnectPusherChannelsClient(
    this._pusherChannelsConnectionRepository,
  );

  void call() => _pusherChannelsConnectionRepository
    ..resetToDefaults()
    ..connect();
}
