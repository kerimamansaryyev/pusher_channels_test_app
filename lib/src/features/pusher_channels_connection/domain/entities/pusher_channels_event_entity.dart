library pusher_channels_event_entity;

part '../../data/models/pusher_channels_chat_began_event_model.dart';
part '../../data/models/pusher_channels_user_joined_event_model.dart';
part '../../data/models/pusher_channels_user_left_event_model.dart';
part '../../data/models/pusher_channels_user_message_event_model.dart';

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
