import 'package:flutter_test/flutter_test.dart';
import 'package:pusher_channels_test_app/core/utils/either/either.dart';

Either<String, int> success() {
  return const Right(1);
}

Either<String, int> failure() {
  return const Left('failure');
}

void main() {
  test(
    'Should return either "failure" or 1',
    () {
      final successfulResult = success();
      final failureResult = failure();

      expect(
        successfulResult.fold(
          left: (l) => l,
          right: (r) => r,
        ),
        1,
      );

      expect(
        failureResult.fold(
          left: (l) => l,
          right: (r) => r,
        ),
        'failure',
      );
    },
  );
  test(
    'Must give isLeft and isRight respectively',
    () {
      final successfulResult = success();
      final failureResult = failure();

      expect(
        successfulResult.isRight(),
        true,
      );
      expect(
        successfulResult.isLeft(),
        false,
      );

      expect(
        failureResult.isLeft(),
        true,
      );
      expect(
        failureResult.isRight(),
        false,
      );
    },
  );

  test(
    'Must give "success1" on success and "0failure" for failure',
    () {
      final successfulResult = success().mapRight<String>((r) => 'success$r');
      final failureResult = failure().mapLeft<String>((l) => '0$l');

      expect(
        successfulResult.fold(
          left: (l) => l,
          right: (r) => r,
        ),
        'success1',
      );

      expect(
        failureResult.fold(
          left: (l) => l,
          right: (r) => r,
        ),
        '0failure',
      );
    },
  );

  test(
    'Checking tryGet methods',
    () {
      final successfulResult = success().mapRight<String>((r) => 'success$r');
      final failureResult = failure().mapLeft<String>((l) => '0$l');

      expect(
        successfulResult.tryGetLeft(),
        null,
      );

      expect(
        successfulResult.tryGetRight(),
        'success1',
      );

      expect(
        failureResult.tryGetLeft(),
        '0failure',
      );

      expect(
        failureResult.tryGetRight(),
        null,
      );
    },
  );
}
