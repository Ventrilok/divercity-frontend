import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../constants/storage_keys.dart';
import '../network/dio_client.dart';
import '../network/network_info.dart';
import '../utils/logger.dart';
import '../../features/diver_profile/data/datasources/diver_local_datasource.dart';
import '../../features/diver_profile/data/datasources/diver_remote_datasource.dart';
import '../../features/diver_profile/data/repositories/diver_repository_impl.dart';
import '../../features/diver_profile/domain/repositories/diver_repository.dart';
import '../../features/diver_profile/domain/usecases/get_diver_profile.dart';
import '../../features/diver_profile/domain/usecases/update_diver_profile.dart';

// ============================================================================
// Core Providers
// ============================================================================

/// Connectivity provider - for checking network connectivity
final connectivityProvider = Provider<Connectivity>((ref) {
  return Connectivity();
});

/// Network info provider - for checking if device is connected
final networkInfoProvider = Provider<NetworkInfo>((ref) {
  return NetworkInfoImpl(ref.read(connectivityProvider));
});

/// Secure storage provider - for storing sensitive data (tokens, credentials)
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

/// Dio client provider - for making HTTP requests
final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient(secureStorage: ref.read(secureStorageProvider));
});

// ============================================================================
// Feature: Diver Profile
// ============================================================================

/// Diver remote datasource provider
final diverRemoteDataSourceProvider = Provider<DiverRemoteDataSource>((ref) {
  return DiverRemoteDataSourceImpl(ref.read(dioClientProvider).dio);
});

/// Diver local datasource provider
final diverLocalDataSourceProvider = Provider<DiverLocalDataSource>((ref) {
  return DiverLocalDataSourceImpl();
});

/// Diver repository provider
final diverRepositoryProvider = Provider<DiverRepository>((ref) {
  return DiverRepositoryImpl(
    remoteDataSource: ref.read(diverRemoteDataSourceProvider),
    localDataSource: ref.read(diverLocalDataSourceProvider),
    networkInfo: ref.read(networkInfoProvider),
  );
});

/// Get diver profile use case provider
final getDiverProfileProvider = Provider((ref) {
  return GetDiverProfile(ref.read(diverRepositoryProvider));
});

/// Update diver profile use case provider
final updateDiverProfileProvider = Provider((ref) {
  return UpdateDiverProfile(ref.read(diverRepositoryProvider));
});

// ============================================================================
// Initialization
// ============================================================================

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
