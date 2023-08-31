import 'package:pusher_channels_test_app/src/features/pusher_channels_connection/domain/entities/pusher_channels_connection_result.dart';

abstract interface class PusherChannelsConnectionRepository {
  Stream<PusherChannelsConnectionResult> onConnectionChanged();
  void resetToDefaults();
  void connect();
}
