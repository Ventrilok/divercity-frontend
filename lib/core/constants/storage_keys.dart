class StorageKeys {
  // Secure storage keys (flutter_secure_storage)
  static const String authToken = 'auth_token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';
  static const String userEmail = 'user_email';

  // SharedPreferences keys
  static const String locale = 'locale';
  static const String themeMode = 'theme_mode';
  static const String onboardingCompleted = 'onboarding_completed';
  static const String lastSyncTimestamp = 'last_sync_timestamp';

  // Hive box names
  static const String diversBox = 'divers';
  static const String diveLogsBox = 'dive_logs';
  static const String emergencyContactsBox = 'emergency_contacts';
  static const String settingsBox = 'settings';
  static const String syncQueueBox = 'sync_queue';
}
