import 'package:pusher_channels_test_app/src/core/utils/either/either.dart';
import 'package:pusher_channels_test_app/src/features/pusher_channels_connection/domain/entities/message_not_triggered_failure.dart';
import 'package:pusher_channels_test_app/src/features/pusher_channels_connection/domain/entities/pusher_channels_connection_result.dart';
import 'package:pusher_channels_test_app/src/features/pusher_channels_connection/domain/entities/pusher_channels_event_entity.dart';

abstract interface class PusherChannelsConnectionRepository {
  Stream<PusherChannelsConnectionResult> onConnectionChanged();
  Stream<PusherChannelsEventEntity> onPresenceChannelEvent({
    required String channelName,
    String? eventNameToBind,
  });
  Either<MessageNotTriggeredFailure, PusherChannelsUserMessageEventEntity>
      triggerClientEventOnPresenceChannel({
    required String message,
    required String channelName,
    required String eventName,
  });
  void resetToDefaults();
  void connect();
}
