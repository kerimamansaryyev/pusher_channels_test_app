import 'package:pusher_channels_test_app/src/features/pusher_channels_connection/domain/entities/pusher_channels_connection_result.dart';
import 'package:pusher_channels_test_app/src/features/pusher_channels_connection/domain/entities/pusher_channels_event_entity.dart';

abstract interface class PusherChannelsConnectionRepository {
  Stream<PusherChannelsConnectionResult> onConnectionChanged();
  Stream<PusherChannelsEventEntity> onPresenceChannelEvent({
    required String channelName,
    String? eventNameToBind,
  });
  void resetToDefaults();
  void connect();
}
