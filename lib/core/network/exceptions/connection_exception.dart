final class ConnectionException implements Exception {
  const ConnectionException([this.cause, this.stackTrace]);

  final Object? cause;
  final StackTrace? stackTrace;
}
