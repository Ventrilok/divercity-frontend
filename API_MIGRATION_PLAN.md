# DiverCity API Migration Plan
**From Mockup to Real API Integration**

---

## Overview

This plan migrates DiverCity from mockup data to real API integration following Clean Architecture principles. Each phase is designed to be independently committable with working, testable code.

**Current State:**
- ✅ Dio client configured with interceptors
- ✅ Mock data for dive logs, emergency contacts, divers
- ✅ Riverpod providers with SharedPreferences persistence
- ✅ Basic UI screens functional
- ❌ No repository pattern
- ❌ Models not using Freezed
- ❌ No proper error handling
- ❌ No offline-first sync

**Focus:** Integrate existing Swagger API endpoints for dive logs, emergency contacts, and diver profiles

---

## Phase 1: Foundation & Architecture Setup

**Goal:** Establish Clean Architecture foundation without breaking existing functionality

### Task 1.1: Set Up Folder Structure
**Subtasks:**
1. Create core error handling directories:
   - `lib/core/error/` for failures and exceptions

2. Create feature-based folder structure:
   - `lib/features/diver_profile/data/` (datasources, models, repositories)
   - `lib/features/diver_profile/domain/` (entities, repositories, usecases)
   - `lib/features/diver_profile/presentation/` (move existing provider/screens here)
   - `lib/features/dive_logs/data/`
   - `lib/features/dive_logs/domain/`
   - `lib/features/dive_logs/presentation/`
   - `lib/features/emergency_contacts/data/`
   - `lib/features/emergency_contacts/domain/`
   - `lib/features/emergency_contacts/presentation/`

3. Move existing files into new structure:
   - Move `lib/models/diver.dart` → `lib/features/diver_profile/data/models/` (temporarily)
   - Move `lib/models/dive_log.dart` → `lib/features/dive_logs/data/models/` (temporarily)
   - Move `lib/models/emergency_contact.dart` → `lib/features/emergency_contacts/data/models/` (temporarily)
   - Move providers to respective feature presentation folders

**Testing:**
- Run `flutter analyze` - should pass
- Run app - should work exactly as before
- No functionality changes

**Commit:** ✅ `refactor: reorganize code into clean architecture folder structure`

---

### Task 1.2: Implement Error Handling Infrastructure
**Subtasks:**
1. Create `lib/core/error/failures.dart`:
```dart
abstract class Failure {
  final String message;
  const Failure(this.message);

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}
```

2. Create `lib/core/error/exceptions.dart`:
```dart
class ServerException implements Exception {
  final String message;
  final int? statusCode;
  ServerException(this.message, [this.statusCode]);
}

class CacheException implements Exception {
  final String message;
  CacheException(this.message);
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}
```

3. Create `lib/core/utils/typedef.dart`:
```dart
import 'package:dartz/dartz.dart';
import '../error/failures.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultVoid = Future<Either<Failure, void>>;
typedef DataMap = Map<String, dynamic>;
```

**Testing:**
- Files compile without errors
- App still runs

**Commit:** ✅ `feat: add error handling infrastructure with Either types`

---

### Task 1.3: Create Network Utilities
**Subtasks:**
1. Create `lib/core/network/network_info.dart`:
```dart
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<bool> get onConnectivityChanged;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity;

  NetworkInfoImpl(this._connectivity);

  @override
  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  @override
  Stream<bool> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged
        .map((result) => result != ConnectivityResult.none);
  }
}
```

2. Create `lib/core/network/api_error_handler.dart`:
```dart
import 'package:dio/dio.dart';
import '../error/failures.dart';
import '../error/exceptions.dart';

class ApiErrorHandler {
  static Failure handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkFailure('Connection timeout. Please check your internet.');

      case DioExceptionType.connectionError:
        return NetworkFailure('No internet connection. Please check your network.');

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data['message'] ?? 'Server error occurred';

        if (statusCode == 404) {
          return ServerFailure('Resource not found');
        } else if (statusCode == 500) {
          return ServerFailure('Internal server error');
        }
        return ServerFailure(message);

      default:
        return ServerFailure('Something went wrong');
    }
  }

  static ServerException handleDioException(DioException error) {
    final statusCode = error.response?.statusCode;
    final message = error.response?.data['message'] ?? error.message ?? 'Unknown error';
    return ServerException(message, statusCode);
  }
}
```

**Testing:**
- Error handler catches different Dio error types correctly
- App runs without issues

**Commit:** ✅ `feat: add network utilities and API error handling`

---

### Task 1.4: Set Up Dependency Injection
**Subtasks:**
1. Update `lib/core/di/injection.dart`:
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../network/dio_client.dart';
import '../network/network_info.dart';

// Core providers
final connectivityProvider = Provider<Connectivity>((ref) => Connectivity());

final networkInfoProvider = Provider<NetworkInfo>(
  (ref) => NetworkInfoImpl(ref.read(connectivityProvider)),
);

final dioClientProvider = Provider<DioClient>(
  (ref) => DioClient(),
);
```

2. Update `lib/main.dart` to ensure ProviderScope wraps app

**Testing:**
- App initializes correctly
- No DI errors

**Commit:** ✅ `feat: set up dependency injection with Riverpod providers`

---

## Phase 2: Diver Profile API Integration

**Goal:** Replace mock diver data with real API calls (skip auth for now, use mock user ID)

### Task 2.1: Migrate Diver Model to Freezed
**Subtasks:**
1. Create `lib/features/diver_profile/domain/entities/diver.dart`:
```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'diver.freezed.dart';

@freezed
class Diver with _$Diver {
  const factory Diver({
    required String id,
    required String firstname,
    required String lastname,
    required String email,
    String? phone,
    String? bloodType,
    DateTime? birthdate,
    String? addressStreet,
    String? addressCity,
    String? addressState,
    String? addressPostcode,
    String? addressCountry,
    @Default(0) int diveCount,
  }) = _Diver;
}
```

2. Create `lib/features/diver_profile/data/models/diver_model.dart`:
```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/diver.dart';

part 'diver_model.freezed.dart';
part 'diver_model.g.dart';

@freezed
class DiverModel with _$DiverModel {
  const DiverModel._();

  const factory DiverModel({
    required String id,
    required String firstname,
    required String lastname,
    required String email,
    String? phone,
    @JsonKey(name: 'blood_type') String? bloodType,
    DateTime? birthdate,
    @JsonKey(name: 'address_street') String? addressStreet,
    @JsonKey(name: 'address_city') String? addressCity,
    @JsonKey(name: 'address_state') String? addressState,
    @JsonKey(name: 'address_postcode') String? addressPostcode,
    @JsonKey(name: 'address_country') String? addressCountry,
    @JsonKey(name: 'dive_count') @Default(0) int diveCount,
  }) = _DiverModel;

  factory DiverModel.fromJson(Map<String, dynamic> json) =>
      _$DiverModelFromJson(json);

  // Convert to domain entity
  Diver toEntity() => Diver(
    id: id,
    firstname: firstname,
    lastname: lastname,
    email: email,
    phone: phone,
    bloodType: bloodType,
    birthdate: birthdate,
    addressStreet: addressStreet,
    addressCity: addressCity,
    addressState: addressState,
    addressPostcode: addressPostcode,
    addressCountry: addressCountry,
    diveCount: diveCount,
  );

  // Create from domain entity
  factory DiverModel.fromEntity(Diver diver) => DiverModel(
    id: diver.id,
    firstname: diver.firstname,
    lastname: diver.lastname,
    email: diver.email,
    phone: diver.phone,
    bloodType: diver.bloodType,
    birthdate: diver.birthdate,
    addressStreet: diver.addressStreet,
    addressCity: diver.addressCity,
    addressState: diver.addressState,
    addressPostcode: diver.addressPostcode,
    addressCountry: diver.addressCountry,
    diveCount: diver.diveCount,
  );
}
```

3. Run code generation:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. Delete old `lib/data/mock/mock_divers.dart`

**Testing:**
- Code generation successful
- No compilation errors
- App runs (will break diver provider, that's expected)

**Commit:** ✅ `refactor: migrate Diver model to Freezed with domain/data separation`

---

### Task 2.2: Create Diver Repository Layer
**Subtasks:**
1. Create `lib/features/diver_profile/domain/repositories/diver_repository.dart`:
```dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/diver.dart';

abstract class DiverRepository {
  Future<Either<Failure, Diver>> getDiverProfile(String diverId);
  Future<Either<Failure, Diver>> updateDiverProfile(Diver diver);
}
```

2. Create `lib/features/diver_profile/data/datasources/diver_remote_datasource.dart`:
```dart
import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_error_handler.dart';
import '../models/diver_model.dart';

abstract class DiverRemoteDataSource {
  Future<DiverModel> getDiverProfile(String diverId);
  Future<DiverModel> updateDiverProfile(DiverModel diver);
}

class DiverRemoteDataSourceImpl implements DiverRemoteDataSource {
  final Dio dio;

  DiverRemoteDataSourceImpl(this.dio);

  @override
  Future<DiverModel> getDiverProfile(String diverId) async {
    try {
      final response = await dio.get(ApiConstants.diverById(diverId));
      return DiverModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiErrorHandler.handleDioException(e);
    }
  }

  @override
  Future<DiverModel> updateDiverProfile(DiverModel diver) async {
    try {
      final response = await dio.put(
        ApiConstants.diverById(diver.id),
        data: diver.toJson(),
      );
      return DiverModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiErrorHandler.handleDioException(e);
    }
  }
}
```

3. Create `lib/features/diver_profile/data/datasources/diver_local_datasource.dart`:
```dart
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/error/exceptions.dart';
import '../models/diver_model.dart';

abstract class DiverLocalDataSource {
  Future<DiverModel?> getCachedDiver();
  Future<void> cacheDiver(DiverModel diver);
}

class DiverLocalDataSourceImpl implements DiverLocalDataSource {
  static const String _boxName = 'diver_cache';
  static const String _diverKey = 'current_diver';

  @override
  Future<DiverModel?> getCachedDiver() async {
    try {
      final box = await Hive.openBox<Map>(_boxName);
      final data = box.get(_diverKey);
      if (data == null) return null;
      return DiverModel.fromJson(Map<String, dynamic>.from(data));
    } catch (e) {
      throw CacheException('Failed to get cached diver: $e');
    }
  }

  @override
  Future<void> cacheDiver(DiverModel diver) async {
    try {
      final box = await Hive.openBox<Map>(_boxName);
      await box.put(_diverKey, diver.toJson());
    } catch (e) {
      throw CacheException('Failed to cache diver: $e');
    }
  }
}
```

4. Create `lib/features/diver_profile/data/repositories/diver_repository_impl.dart`:
```dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/diver.dart';
import '../../domain/repositories/diver_repository.dart';
import '../datasources/diver_local_datasource.dart';
import '../datasources/diver_remote_datasource.dart';
import '../models/diver_model.dart';

class DiverRepositoryImpl implements DiverRepository {
  final DiverRemoteDataSource remoteDataSource;
  final DiverLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  DiverRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Diver>> getDiverProfile(String diverId) async {
    final isConnected = await networkInfo.isConnected;

    if (isConnected) {
      try {
        final remoteDiver = await remoteDataSource.getDiverProfile(diverId);
        await localDataSource.cacheDiver(remoteDiver);
        return Right(remoteDiver.toEntity());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      try {
        final cachedDiver = await localDataSource.getCachedDiver();
        if (cachedDiver != null) {
          return Right(cachedDiver.toEntity());
        }
        return Left(CacheFailure('No cached data available'));
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, Diver>> updateDiverProfile(Diver diver) async {
    final isConnected = await networkInfo.isConnected;

    if (!isConnected) {
      return Left(NetworkFailure('Cannot update profile while offline'));
    }

    try {
      final diverModel = DiverModel.fromEntity(diver);
      final updatedDiver = await remoteDataSource.updateDiverProfile(diverModel);
      await localDataSource.cacheDiver(updatedDiver);
      return Right(updatedDiver.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
```

5. Register providers in `lib/core/di/injection.dart`:
```dart
// Add these imports and providers

import '../features/diver_profile/data/datasources/diver_local_datasource.dart';
import '../features/diver_profile/data/datasources/diver_remote_datasource.dart';
import '../features/diver_profile/data/repositories/diver_repository_impl.dart';
import '../features/diver_profile/domain/repositories/diver_repository.dart';

// Diver datasources
final diverRemoteDataSourceProvider = Provider<DiverRemoteDataSource>(
  (ref) => DiverRemoteDataSourceImpl(ref.read(dioClientProvider).dio),
);

final diverLocalDataSourceProvider = Provider<DiverLocalDataSource>(
  (ref) => DiverLocalDataSourceImpl(),
);

// Diver repository
final diverRepositoryProvider = Provider<DiverRepository>(
  (ref) => DiverRepositoryImpl(
    remoteDataSource: ref.read(diverRemoteDataSourceProvider),
    localDataSource: ref.read(diverLocalDataSourceProvider),
    networkInfo: ref.read(networkInfoProvider),
  ),
);
```

**Testing:**
- Repository compiles
- Providers registered
- App runs (still broken, that's ok)

**Commit:** ✅ `feat: implement diver repository with offline-first caching`

---

### Task 2.3: Create Diver Use Cases
**Subtasks:**
1. Create `lib/features/diver_profile/domain/usecases/get_diver_profile.dart`:
```dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/diver.dart';
import '../repositories/diver_repository.dart';

class GetDiverProfile {
  final DiverRepository repository;

  GetDiverProfile(this.repository);

  Future<Either<Failure, Diver>> call(String diverId) {
    return repository.getDiverProfile(diverId);
  }
}
```

2. Create `lib/features/diver_profile/domain/usecases/update_diver_profile.dart`:
```dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/diver.dart';
import '../repositories/diver_repository.dart';

class UpdateDiverProfile {
  final DiverRepository repository;

  UpdateDiverProfile(this.repository);

  Future<Either<Failure, Diver>> call(Diver diver) {
    return repository.updateDiverProfile(diver);
  }
}
```

3. Register in DI:
```dart
// Add to lib/core/di/injection.dart

final getDiverProfileUseCaseProvider = Provider<GetDiverProfile>(
  (ref) => GetDiverProfile(ref.read(diverRepositoryProvider)),
);

final updateDiverProfileUseCaseProvider = Provider<UpdateDiverProfile>(
  (ref) => UpdateDiverProfile(ref.read(diverRepositoryProvider)),
);
```

**Testing:**
- Use cases compile
- Providers work

**Commit:** ✅ `feat: add diver profile use cases`

---

### Task 2.4: Update Diver Provider
**Subtasks:**
1. Move `lib/providers/diver_provider.dart` → `lib/features/diver_profile/presentation/providers/diver_provider.dart`

2. Rewrite provider to use repository:
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/diver.dart';

// Use a mock diver ID for now (until auth is implemented)
const String _mockDiverId = 'mock-diver-001';

// State for diver profile
class DiverState {
  final Diver? diver;
  final bool isLoading;
  final String? error;

  DiverState({this.diver, this.isLoading = false, this.error});

  DiverState copyWith({Diver? diver, bool? isLoading, String? error}) {
    return DiverState(
      diver: diver ?? this.diver,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class DiverNotifier extends Notifier<DiverState> {
  @override
  DiverState build() {
    loadDiver();
    return DiverState(isLoading: true);
  }

  Future<void> loadDiver() async {
    state = state.copyWith(isLoading: true, error: null);

    final useCase = ref.read(getDiverProfileUseCaseProvider);
    final result = await useCase(_mockDiverId);

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (diver) => state = state.copyWith(
        diver: diver,
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<void> updateDiver(Diver updatedDiver) async {
    state = state.copyWith(isLoading: true, error: null);

    final useCase = ref.read(updateDiverProfileUseCaseProvider);
    final result = await useCase(updatedDiver);

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (diver) => state = state.copyWith(
        diver: diver,
        isLoading: false,
        error: null,
      ),
    );
  }
}

final diverProvider = NotifierProvider<DiverNotifier, DiverState>(
  DiverNotifier.new,
);
```

3. Update UI files that use diver provider:
   - Update `lib/screens/profile_screen.dart` to handle loading/error states
   - Update `lib/screens/home_screen.dart` if it uses diver data
   - Handle null diver case

**Testing:**
- Start backend API: Ensure `http://localhost:3000` is running
- Check Swagger docs at `http://localhost:3000/api-docs/` for correct endpoints
- Create a mock diver in backend with ID `mock-diver-001`
- Run app - should load diver from API
- Turn off backend - should load from cache
- Update profile - should save to API

**Commit:** ✅ `feat: integrate diver profile with API and update UI`

---

## Phase 3: Dive Logs API Integration

**Goal:** Replace mock dive logs with real API calls

### Task 3.1: Migrate DiveLog Model to Freezed
**Subtasks:**
1. Create `lib/features/dive_logs/domain/entities/dive_log.dart`:
```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dive_log.freezed.dart';

@freezed
class DiveLog with _$DiveLog {
  const factory DiveLog({
    required String id,
    required String diverId,
    required String diveSite,
    required String location,
    required DateTime diveDate,
    required double maxDepth,
    required int duration,
    double? waterTemperature,
    double? airTemperature,
    double? entryPressure,
    double? exitPressure,
    String? gasMix,
    String? notes,
    @Default(false) bool isFavorite,
  }) = _DiveLog;
}
```

2. Create `lib/features/dive_logs/data/models/dive_log_model.dart`:
```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/dive_log.dart';

part 'dive_log_model.freezed.dart';
part 'dive_log_model.g.dart';

@freezed
class DiveLogModel with _$DiveLogModel {
  const DiveLogModel._();

  const factory DiveLogModel({
    required String id,
    @JsonKey(name: 'diver_id') required String diverId,
    @JsonKey(name: 'dive_site') required String diveSite,
    required String location,
    @JsonKey(name: 'dive_date') required DateTime diveDate,
    @JsonKey(name: 'max_depth') required double maxDepth,
    required int duration,
    @JsonKey(name: 'water_temperature') double? waterTemperature,
    @JsonKey(name: 'air_temperature') double? airTemperature,
    @JsonKey(name: 'entry_pressure') double? entryPressure,
    @JsonKey(name: 'exit_pressure') double? exitPressure,
    @JsonKey(name: 'gas_mix') String? gasMix,
    String? notes,
    @JsonKey(name: 'is_favorite') @Default(false) bool isFavorite,
  }) = _DiveLogModel;

  factory DiveLogModel.fromJson(Map<String, dynamic> json) =>
      _$DiveLogModelFromJson(json);

  DiveLog toEntity() => DiveLog(
    id: id,
    diverId: diverId,
    diveSite: diveSite,
    location: location,
    diveDate: diveDate,
    maxDepth: maxDepth,
    duration: duration,
    waterTemperature: waterTemperature,
    airTemperature: airTemperature,
    entryPressure: entryPressure,
    exitPressure: exitPressure,
    gasMix: gasMix,
    notes: notes,
    isFavorite: isFavorite,
  );

  factory DiveLogModel.fromEntity(DiveLog diveLog) => DiveLogModel(
    id: diveLog.id,
    diverId: diveLog.diverId,
    diveSite: diveLog.diveSite,
    location: diveLog.location,
    diveDate: diveLog.diveDate,
    maxDepth: diveLog.maxDepth,
    duration: diveLog.duration,
    waterTemperature: diveLog.waterTemperature,
    airTemperature: diveLog.airTemperature,
    entryPressure: diveLog.entryPressure,
    exitPressure: diveLog.exitPressure,
    gasMix: diveLog.gasMix,
    notes: diveLog.notes,
    isFavorite: diveLog.isFavorite,
  );
}
```

3. Run code generation
4. Delete `lib/data/mock/mock_dive_logs.dart`

**Testing:**
- Code generation successful
- App compiles

**Commit:** ✅ `refactor: migrate DiveLog model to Freezed with domain/data separation`

---

### Task 3.2: Create Dive Log Repository Layer
**Subtasks:**
1. Create repository interface
2. Create remote datasource (Dio)
3. Create local datasource (SQLite for complex queries)
4. Implement repository with offline-first logic

*(Similar structure to Task 2.2, but for dive logs)*

**API Endpoints:**
- `GET /dive-logs/diver/:diverId`
- `GET /dive-logs/:id`
- `POST /dive-logs`
- `PUT /dive-logs/:id`
- `DELETE /dive-logs/:id`

**Commit:** ✅ `feat: implement dive log repository with offline-first caching`

---

### Task 3.3: Create Dive Log Use Cases
**Subtasks:**
1. `GetAllDiveLogs`
2. `GetDiveLog`
3. `AddDiveLog`
4. `UpdateDiveLog`
5. `DeleteDiveLog`
6. `ToggleFavorite`
7. `GetDiveStats`

**Commit:** ✅ `feat: add dive log use cases`

---

### Task 3.4: Update Dive Log Provider
**Subtasks:**
1. Move provider to presentation folder
2. Rewrite to use repository
3. Update screens to handle loading/error states
4. Test CRUD operations

**Testing:**
- Load dive logs from API
- Add new dive log - saves to API
- Edit dive log - updates API
- Delete dive log - removes from API
- Toggle favorite - updates API
- Offline mode - shows cached data

**Commit:** ✅ `feat: integrate dive logs with API and update UI`

---

## Phase 4: Emergency Contacts API Integration

**Goal:** Replace mock emergency contacts with real API calls

### Task 4.1: Migrate EmergencyContact Model to Freezed
*(Similar to Phase 3, Task 3.1)*

**Commit:** ✅ `refactor: migrate EmergencyContact model to Freezed`

---

### Task 4.2: Create Emergency Contact Repository Layer
*(Similar structure to previous repositories)*

**API Endpoints:**
- `GET /emergency-contacts/diver/:diverId`
- `GET /emergency-contacts/:id`
- `POST /emergency-contacts`
- `PUT /emergency-contacts/:id`
- `DELETE /emergency-contacts/:id`

**Commit:** ✅ `feat: implement emergency contact repository with caching`

---

### Task 4.3: Create Emergency Contact Use Cases
**Subtasks:**
1. `GetAllContacts`
2. `GetContact`
3. `AddContact`
4. `UpdateContact`
5. `DeleteContact`
6. `ToggleFavoriteContact`

**Commit:** ✅ `feat: add emergency contact use cases`

---

### Task 4.4: Update Emergency Contact Provider
**Subtasks:**
1. Move provider to presentation folder
2. Rewrite to use repository
3. Update screens to handle states
4. Test CRUD operations

**Testing:**
- Load contacts from API
- CRUD operations work
- Reordering persists
- Offline mode functional

**Commit:** ✅ `feat: integrate emergency contacts with API and update UI`

---

## Phase 5: Offline-First & Synchronization

**Goal:** Implement robust offline support with automatic sync

### Task 5.1: Implement Sync Status Tracking
**Subtasks:**
1. Add `syncStatus` field to models (synced, pending, failed)
2. Track local changes in SQLite/Hive
3. Queue pending operations

**Commit:** ✅ `feat: add sync status tracking to models`

---

### Task 5.2: Implement Connectivity Monitoring
**Subtasks:**
1. Create connectivity service
2. Listen to connectivity changes
3. Trigger sync when online

**Commit:** ✅ `feat: add connectivity monitoring and auto-sync`

---

### Task 5.3: Update Repositories for Sync
**Subtasks:**
1. Implement sync logic in repositories
2. Handle conflict resolution
3. Add retry mechanism

**Commit:** ✅ `feat: implement repository sync with conflict resolution`

---

### Task 5.4: Add Sync UI Indicators
**Subtasks:**
1. Show sync status in lists
2. Add manual sync button
3. Display sync errors

**Commit:** ✅ `feat: add sync status UI indicators`

---

## Backend API Requirements

Ensure `http://localhost:3000` has these endpoints (check Swagger docs):

### Diver Profile
- `GET /divers/:id`
- `PUT /divers/:id`

### Dive Logs
- `GET /dive-logs/diver/:diverId`
- `GET /dive-logs/:id`
- `POST /dive-logs`
- `PUT /dive-logs/:id`
- `DELETE /dive-logs/:id`

### Emergency Contacts
- `GET /emergency-contacts/diver/:diverId`
- `GET /emergency-contacts/:id`
- `POST /emergency-contacts`
- `PUT /emergency-contacts/:id`
- `DELETE /emergency-contacts/:id`

---

## Testing Checklist

After each phase, test:
- [ ] App runs without errors
- [ ] API calls work (backend online)
- [ ] Offline mode works (cached data)
- [ ] UI shows loading states
- [ ] Errors display to user
- [ ] `flutter analyze` passes
- [ ] Code formatted with `dart format .`

---

## Quick Reference Commands

```bash
# Code generation
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (during development)
flutter pub run build_runner watch --delete-conflicting-outputs

# Analyze code
flutter analyze

# Format code
dart format .

# Run app
flutter run

# Clean and get dependencies
flutter clean && flutter pub get
```

---

## Success Metrics

✅ All mock data removed
✅ API integration complete for diver, dive logs, contacts
✅ Offline-first architecture working
✅ Loading/error states in UI
✅ Code follows Clean Architecture
✅ App functional online and offline
✅ Each phase committed independently
