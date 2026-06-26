final class ConvertException implements Exception {
  const ConvertException(
    this.cause, {
    this.stackTrace,
  });

  final Object cause;
  final StackTrace? stackTrace;
}
