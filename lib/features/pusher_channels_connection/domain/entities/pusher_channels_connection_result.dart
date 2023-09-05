sealed class PusherChannelsConnectionResult {}

final class PusherChannelsConnectionSucceeded
    implements PusherChannelsConnectionResult {
  const PusherChannelsConnectionSucceeded();
}

final class PusherChannelsConnectionFailed
    implements PusherChannelsConnectionResult {
  final dynamic exception;
  final StackTrace stackTrace;

  const PusherChannelsConnectionFailed({
    required this.exception,
    required this.stackTrace,
  });
}

final class PusherChannelsConnectionPending
    implements PusherChannelsConnectionResult {
  const PusherChannelsConnectionPending();
}
