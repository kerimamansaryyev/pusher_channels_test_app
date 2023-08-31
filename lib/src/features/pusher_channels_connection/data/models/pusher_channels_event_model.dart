import 'package:pusher_channels_test_app/src/features/pusher_channels_connection/domain/entities/pusher_channels_event_entity.dart';

final class PusherChannelsEventModel implements PusherChannelsEventEntity {
  @override
  final String? channelName;

  @override
  final dynamic data;

  @override
  final Map<String, dynamic>? dataAsMap;

  @override
  final String name;

  @override
  final String? userId;

  @override
  final bool isMyMessage;

  PusherChannelsEventModel({
    required this.channelName,
    required this.data,
    required this.dataAsMap,
    required this.name,
    required this.userId,
    required this.isMyMessage,
  });
}
