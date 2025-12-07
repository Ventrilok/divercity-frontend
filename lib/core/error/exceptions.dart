/// Base exception for data layer errors
/// Exceptions are thrown in the data layer and converted to Failures in repositories
class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException(this.message, [this.statusCode]);

  @override
  String toString() => statusCode != null
      ? 'AppException: $message (Status: $statusCode)'
      : 'AppException: $message';
}

/// Server-related exceptions (API errors)
class ServerException extends AppException {
  const ServerException(super.message, [super.statusCode]);
}

/// Cache-related exceptions (local storage errors)
class CacheException extends AppException {
  const CacheException(super.message, [super.statusCode]);
}

/// Network-related exceptions (connection issues)
class NetworkException extends AppException {
  const NetworkException(super.message, [super.statusCode]);
}

/// Authentication-related exceptions
class AuthException extends AppException {
  const AuthException(super.message, [super.statusCode]);
}

/// Validation-related exceptions
class ValidationException extends AppException {
  const ValidationException(super.message, [super.statusCode]);
}

/// Not found exceptions
class NotFoundException extends AppException {
  const NotFoundException(super.message, [super.statusCode]);
}

/// Permission/Authorization exceptions
class PermissionException extends AppException {
  const PermissionException(super.message, [super.statusCode]);
}

/// Timeout exceptions
class TimeoutException extends AppException {
  const TimeoutException(super.message, [super.statusCode]);
}

/// Serialization/Deserialization exceptions
class SerializationException extends AppException {
  const SerializationException(super.message, [super.statusCode]);
}
