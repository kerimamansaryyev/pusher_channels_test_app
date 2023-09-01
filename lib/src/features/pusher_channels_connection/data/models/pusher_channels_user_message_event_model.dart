part of pusher_channels_event_entity;

final class PusherChannelsUserMessageEventModel
    extends PusherChannelsEventEntity {
  final String? userId;
  final String messageContent;
  final bool isMyMessage;

  PusherChannelsUserMessageEventModel({
    required super.name,
    required super.dataAsMap,
    required super.data,
    required super.channelName,
    required this.isMyMessage,
    required this.userId,
    required this.messageContent,
  });
}
