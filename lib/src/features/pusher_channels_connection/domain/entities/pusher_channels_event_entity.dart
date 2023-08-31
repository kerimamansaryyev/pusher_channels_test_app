import 'package:dart_pusher_channels/dart_pusher_channels.dart';

abstract interface class PusherChannelsEventEntity {
  abstract final String name;
  abstract final String? channelName;
  abstract final String? userId;
  abstract final Map<String, dynamic>? dataAsMap;
  abstract final dynamic data;
  abstract final bool isMyMessage;
}
