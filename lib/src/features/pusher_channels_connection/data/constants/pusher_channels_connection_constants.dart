import 'package:dart_pusher_channels/dart_pusher_channels.dart';

abstract final class PusherChannelsConnectionConstants {
  static const pusherChannelsOptions = PusherChannelsOptions.fromCluster(
    scheme: 'wss',
    cluster: 'mt1',
    key: 'a0173cd5499b34d93109',
    port: 443,
  );
}
