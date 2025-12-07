/// Base class for all failures in the application
/// Failures represent errors that occur during business logic execution
/// They are used with Either types to handle errors functionally
abstract class Failure {
  final String message;
  const Failure(this.message);

  @override
  String toString() => message;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Failure && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

/// Server-related failures (API errors, 500 errors, etc.)
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Cache-related failures (local storage errors)
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// Network-related failures (no connection, timeout, etc.)
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// Authentication-related failures
class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

/// Validation-related failures (invalid input, etc.)
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

/// Not found failures (resource doesn't exist)
class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}

/// Permission/Authorization failures
class PermissionFailure extends Failure {
  const PermissionFailure(super.message);
}

/// Unexpected/Unknown failures
class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message);
}
