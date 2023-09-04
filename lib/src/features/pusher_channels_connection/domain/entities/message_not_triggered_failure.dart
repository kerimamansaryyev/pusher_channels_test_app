import 'package:pusher_channels_test_app/src/core/domain/failure.dart';

final class MessageNotTriggeredFailure implements Failure {
  @override
  final Exception? exception = null;

  @override
  final StackTrace? stackTrace = null;

  const MessageNotTriggeredFailure();
}
