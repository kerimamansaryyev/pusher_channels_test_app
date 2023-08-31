import 'package:injectable/injectable.dart';
import 'package:pusher_channels_test_app/src/features/pusher_channels_connection/domain/entities/pusher_channels_connection_result.dart';
import 'package:pusher_channels_test_app/src/features/pusher_channels_connection/domain/repositories/pusher_channels_connection_repository.dart';

@injectable
class ListenForPusherChannelsClientConnection {
  final PusherChannelsConnectionRepository _pusherChannelsConnectionRepository;

  const ListenForPusherChannelsClientConnection(
    this._pusherChannelsConnectionRepository,
  );

  Stream<PusherChannelsConnectionResult> call() =>
      _pusherChannelsConnectionRepository.onConnectionChanged();
}
