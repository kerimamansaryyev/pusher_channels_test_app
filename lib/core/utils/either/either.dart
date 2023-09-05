final class _EitherException implements Exception {}

extension EitherExtension<L, R> on Either<L, R> {
  T fold<T>({
    required T Function(L l) left,
    required T Function(R r) right,
  }) {
    return switch (this) {
      Left<L>(left: final l) => left(l),
      Right<R>(right: final r) => right(r),
      _ => throw _EitherException(),
    };
  }

  Either<T, R> mapLeft<T>(T Function(L l) left) {
    return fold(
      left: (l) => Left(left(l)),
      right: (r) => Right(r),
    );
  }

  Either<L, T> mapRight<T>(T Function(R r) right) {
    return fold(
      left: (l) => Left(l),
      right: (r) => Right(right(r)),
    );
  }

  L? tryGetLeft() => fold(
        left: (l) => l,
        right: (_) => null,
      );

  R? tryGetRight() => fold(
        left: (_) => null,
        right: (r) => r,
      );

  bool isLeft() => this is Left<L>;

  bool isRight() => this is Right<R>;
}

sealed class Either<L, R> {}

final class Left<T> implements Either<T, Never> {
  final T left;

  const Left(this.left);
}

final class Right<T> implements Either<Never, T> {
  final T right;

  const Right(this.right);
}
