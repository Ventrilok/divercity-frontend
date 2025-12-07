import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/storage_keys.dart';
import '../utils/logger.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage secureStorage;

  AuthInterceptor({required this.secureStorage});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Add auth token to headers
    final token = await secureStorage.read(key: StorageKeys.authToken);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
      AppLogger.info('Added auth token to request: ${options.path}');
    }

    handler.next(options);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      // Token expired - attempt refresh
      AppLogger.warning('401 Unauthorized - token may be expired');

      // TODO: Implement token refresh logic
      // final refreshToken = await secureStorage.read(key: StorageKeys.refreshToken);
      // if (refreshToken != null) {
      //   // Attempt to refresh token
      //   // If successful, retry original request
      //   // If failed, clear tokens and redirect to login
      // }
    }

    handler.next(err);
  }
}
