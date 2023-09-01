part of pusher_channels_event_entity;

final class PusherChannelsUserLeftEventModel extends PusherChannelsEventEntity {
  final String? userId;

  PusherChannelsUserLeftEventModel({
    required super.name,
    required super.dataAsMap,
    required super.data,
    required super.channelName,
    required this.userId,
  });
}
