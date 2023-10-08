import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:injectable/injectable.dart';

typedef PusherChannelsClientErrorHandlerDelegate = void Function(
  dynamic,
  StackTrace,
  void Function(),
);

abstract interface class PusherChannelsClientFactory {
  PusherChannelsClient createClient({
    required PusherChannelsOptions options,
    required PusherChannelsClientErrorHandlerDelegate connectionErrorHandler,
  });
}

@Injectable(
  as: PusherChannelsClientFactory,
)
final class PusherChannelsClientFactoryImpl
    implements PusherChannelsClientFactory {
  @override
  PusherChannelsClient createClient({
    required PusherChannelsOptions options,
    required PusherChannelsClientErrorHandlerDelegate connectionErrorHandler,
  }) =>
      PusherChannelsClient.websocket(
        options: options,
        connectionErrorHandler: connectionErrorHandler,
      );
}
