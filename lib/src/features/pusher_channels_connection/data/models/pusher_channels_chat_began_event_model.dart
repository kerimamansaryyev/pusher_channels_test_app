part of pusher_channels_event_entity;

final class PusherChannelsChatBeganEventModel
    extends PusherChannelsEventEntity {
  final String? myUserId;

  PusherChannelsChatBeganEventModel({
    required super.name,
    required super.dataAsMap,
    required super.data,
    required super.channelName,
    required this.myUserId,
  });
}
