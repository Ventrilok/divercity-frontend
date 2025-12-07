import 'package:dio/dio.dart';
import '../error/failures.dart';
import '../error/exceptions.dart';

/// Handles API errors and converts them to appropriate Failures or Exceptions
class ApiErrorHandler {
  /// Convert DioException to Failure (for use in repositories)
  static Failure handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure(
          'Connection timeout. Please check your internet connection.',
        );

      case DioExceptionType.connectionError:
        return const NetworkFailure(
          'No internet connection. Please check your network settings.',
        );

      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response);

      case DioExceptionType.cancel:
        return const UnexpectedFailure('Request was cancelled');

      case DioExceptionType.badCertificate:
        return const NetworkFailure('SSL certificate verification failed');

      case DioExceptionType.unknown:
        return UnexpectedFailure(
          error.message ?? 'An unexpected error occurred',
        );
    }
  }

  /// Convert DioException to Exception (for use in data sources)
  static AppException handleDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException('Request timeout');

      case DioExceptionType.connectionError:
        return const NetworkException('No internet connection');

      case DioExceptionType.badResponse:
        return _handleBadResponseException(error.response);

      case DioExceptionType.cancel:
        return const ServerException('Request was cancelled');

      case DioExceptionType.badCertificate:
        return const NetworkException('SSL certificate verification failed');

      case DioExceptionType.unknown:
        return ServerException(error.message ?? 'Unknown error');
    }
  }

  /// Handle bad response (4xx, 5xx errors) and convert to Failure
  static Failure _handleBadResponse(Response? response) {
    if (response == null) {
      return const ServerFailure('Server error occurred');
    }

    final statusCode = response.statusCode ?? 0;
    final message = _extractErrorMessage(response.data);

    // Authentication errors (401, 403)
    if (statusCode == 401) {
      return AuthFailure(message ?? 'Authentication required');
    }
    if (statusCode == 403) {
      return PermissionFailure(message ?? 'Access denied');
    }

    // Not found errors (404)
    if (statusCode == 404) {
      return NotFoundFailure(message ?? 'Resource not found');
    }

    // Validation errors (400, 422)
    if (statusCode == 400 || statusCode == 422) {
      return ValidationFailure(message ?? 'Invalid request data');
    }

    // Server errors (500+)
    if (statusCode >= 500) {
      return ServerFailure(message ?? 'Internal server error');
    }

    // Other client errors (4xx)
    if (statusCode >= 400 && statusCode < 500) {
      return ServerFailure(message ?? 'Request failed');
    }

    return ServerFailure(message ?? 'Server error occurred');
  }

  /// Handle bad response and convert to Exception
  static AppException _handleBadResponseException(Response? response) {
    if (response == null) {
      return const ServerException('Server error occurred');
    }

    final statusCode = response.statusCode ?? 0;
    final message = _extractErrorMessage(response.data);

    // Authentication errors (401, 403)
    if (statusCode == 401 || statusCode == 403) {
      return AuthException(message ?? 'Authentication failed', statusCode);
    }

    // Not found errors (404)
    if (statusCode == 404) {
      return NotFoundException(message ?? 'Resource not found', statusCode);
    }

    // Validation errors (400, 422)
    if (statusCode == 400 || statusCode == 422) {
      return ValidationException(message ?? 'Invalid request', statusCode);
    }

    // Server errors (500+)
    if (statusCode >= 500) {
      return ServerException(message ?? 'Internal server error', statusCode);
    }

    return ServerException(message ?? 'Request failed', statusCode);
  }

  /// Extract error message from response data
  /// Supports common API error response formats
  static String? _extractErrorMessage(dynamic data) {
    if (data == null) return null;

    // If data is a string, return it
    if (data is String) return data;

    // If data is a Map, try common error message keys
    if (data is Map<String, dynamic>) {
      // Try common error message keys
      final errorKeys = ['message', 'error', 'detail', 'msg', 'errorMessage'];
      for (final key in errorKeys) {
        if (data.containsKey(key) && data[key] != null) {
          return data[key].toString();
        }
      }

      // Try nested error object
      if (data.containsKey('error') && data['error'] is Map) {
        final errorObj = data['error'] as Map<String, dynamic>;
        for (final key in errorKeys) {
          if (errorObj.containsKey(key) && errorObj[key] != null) {
            return errorObj[key].toString();
          }
        }
      }

      // If errors array exists (common in validation errors)
      if (data.containsKey('errors') && data['errors'] is List) {
        final errors = data['errors'] as List;
        if (errors.isNotEmpty) {
          return errors.first.toString();
        }
      }
    }

    return null;
  }
}
