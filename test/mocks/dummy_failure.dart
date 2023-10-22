import 'package:pusher_channels_test_app/core/domain/failure.dart';

final class DummyFailure implements Failure {
  const DummyFailure();

  @override
  Exception? get exception => throw UnimplementedError();

  @override
  StackTrace? get stackTrace => throw UnimplementedError();
}
