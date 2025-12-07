import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../constants/storage_keys.dart';
import '../utils/logger.dart';

class DependencyInjection {
  static Future<void> init() async {
    try {
      AppLogger.info('Initializing dependencies...');

      // Initialize Hive
      await Hive.initFlutter();
      AppLogger.info('Hive initialized');

      // Register Hive adapters (will be added as models are created)
      // TODO: Register adapters after creating models
      // Hive.registerAdapter(DiverModelAdapter());
      // Hive.registerAdapter(DiveLogModelAdapter());
      // Hive.registerAdapter(EmergencyContactModelAdapter());

      // Open Hive boxes
      await Hive.openBox(StorageKeys.diversBox);
      await Hive.openBox(StorageKeys.diveLogsBox);
      await Hive.openBox(StorageKeys.emergencyContactsBox);
      await Hive.openBox(StorageKeys.settingsBox);
      await Hive.openBox(StorageKeys.syncQueueBox);
      AppLogger.info('Hive boxes opened');

      // Initialize secure storage (no init needed for FlutterSecureStorage)
      AppLogger.info('Secure storage ready');

      AppLogger.info('Dependencies initialized successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to initialize dependencies', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  static Future<void> reset() async {
    // Clear all local storage
    await Hive.deleteFromDisk();
    const secureStorage = FlutterSecureStorage();
    await secureStorage.deleteAll();
    AppLogger.info('All local storage cleared');
  }
}
