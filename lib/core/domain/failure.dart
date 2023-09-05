abstract interface class Failure<E extends Exception> {
  abstract final E? exception;
  abstract final StackTrace? stackTrace;
}

final class UnknownFailure<E extends Exception> implements Failure<E> {
  @override
  final E? exception;

  @override
  final StackTrace? stackTrace;

  const UnknownFailure({
    this.exception,
    this.stackTrace,
  });
}
