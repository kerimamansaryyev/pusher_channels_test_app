library pusher_channels_event_entity;

sealed class PusherChannelsEventEntity {
  final String name;
  final String? channelName;
  final Map<String, dynamic>? dataAsMap;
  final dynamic data;

  PusherChannelsEventEntity({
    required this.name,
    required this.dataAsMap,
    required this.data,
    required this.channelName,
  });
}

class PusherChannelsChatBeganEventEntity extends PusherChannelsEventEntity {
  final String? myUserId;

  PusherChannelsChatBeganEventEntity({
    required super.name,
    required super.dataAsMap,
    required super.data,
    required super.channelName,
    required this.myUserId,
  });
}

class PusherChannelsUserJoinedEventEntity extends PusherChannelsEventEntity {
  final String? userId;

  PusherChannelsUserJoinedEventEntity({
    required super.name,
    required super.dataAsMap,
    required super.data,
    required super.channelName,
    required this.userId,
  });
}

class PusherChannelsUserLeftEventEntity extends PusherChannelsEventEntity {
  final String? userId;

  PusherChannelsUserLeftEventEntity({
    required super.name,
    required super.dataAsMap,
    required super.data,
    required super.channelName,
    required this.userId,
  });
}

class PusherChannelsUserMessageEventEntity extends PusherChannelsEventEntity {
  final String? userId;
  final String messageContent;
  final bool isMyMessage;

  PusherChannelsUserMessageEventEntity({
    required super.name,
    required super.dataAsMap,
    required super.data,
    required super.channelName,
    required this.isMyMessage,
    required this.userId,
    required this.messageContent,
  });
}
