part of pusher_channels_event_entity;

final class PusherChannelsUserJoinedEventModel
    extends PusherChannelsEventEntity {
  final String? userId;

  PusherChannelsUserJoinedEventModel({
    required super.name,
    required super.dataAsMap,
    required super.data,
    required super.channelName,
    required this.userId,
  });
}
