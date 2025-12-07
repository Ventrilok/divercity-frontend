class AppConstants {
  // App info
  static const String appName = 'DiverCity';
  static const String appVersion = '1.0.0';

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Cache duration
  static const Duration cacheValidDuration = Duration(hours: 1);
  static const Duration tokenRefreshThreshold = Duration(minutes: 5);

  // Sync settings
  static const Duration syncInterval = Duration(minutes: 15);
  static const int maxSyncRetries = 3;

  // Image settings
  static const int maxImageSizeBytes = 5 * 1024 * 1024; // 5MB
  static const double imageCompressionQuality = 0.8;

  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 128;
  static const int maxNotesLength = 2000;
}
