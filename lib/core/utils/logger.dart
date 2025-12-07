import 'dart:developer' as developer;

class AppLogger {
  static const String _name = 'DiverCity';

  static void log(
    String message, {
    String? name,
    Object? error,
    StackTrace? stackTrace,
  }) {
    developer.log(
      message,
      name: name ?? _name,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void info(String message) {
    log('ℹ️ INFO: $message');
  }

  static void warning(String message) {
    log('⚠️ WARNING: $message');
  }

  static void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    log(
      '❌ ERROR: $message',
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void debug(String message) {
    log('🐛 DEBUG: $message');
  }

  static void success(String message) {
    log('✅ SUCCESS: $message');
  }
}
