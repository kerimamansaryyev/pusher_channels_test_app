import 'package:pusher_channels_test_app/core/domain/failure.dart';
import 'package:pusher_channels_test_app/core/utils/either/either.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/entities/pusher_channels_connection_result.dart';
import 'package:pusher_channels_test_app/features/pusher_channels_connection/domain/entities/pusher_channels_event_entity.dart';

abstract interface class PusherChannelsConnectionRepository {
  Stream<PusherChannelsConnectionResult> onConnectionChanged();
  Stream<PusherChannelsEventEntity> onPresenceChannelEvent({
    required String channelName,
    String? eventNameToBind,
  });
  Either<Failure, PusherChannelsUserMessageEventEntity>
      triggerClientEventOnPresenceChannel({
    required String message,
    required String channelName,
    required String eventName,
  });
  void resetPresenceChannelState({
    required String channelName,
  });
  void resetToDefaults();
  void connect();
}
