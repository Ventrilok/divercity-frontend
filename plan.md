# DiverCity Flutter App - Comprehensive Implementation Plan

## Overview
Transform the default Flutter counter app into a production-ready dive logbook application with clean architecture, offline-first capabilities, and distinctive ocean-inspired UI.

---

## Phase 1: Foundation Setup

### Task 1.1: Fix Asset Configuration Bug
**Priority**: Critical
**Time Estimate**: 2 minutes

**Issue**: pubspec.yaml references wrong asset filename

**Files to modify**:
- `pubspec.yaml` (line 56)

**Actions**:
- Change `- assets/appainter_theme.json` to `- assets/divercity_theme.json`

**Verification**:
- Run `flutter pub get` successfully

---

### Task 1.2: Add Core Dependencies
**Priority**: Critical
**Time Estimate**: 5 minutes

**Files to modify**:
- `pubspec.yaml`

**Dependencies to add**:

```yaml
dependencies:
  flutter:
    sdk: flutter
  json_theme: ^7.0.0+3
  cupertino_icons: ^1.0.8

  # HTTP & Networking (REQUIRED - Dio only, never http package)
  dio: ^5.4.0
  pretty_dio_logger: ^1.3.1

  # State Management
  flutter_riverpod: ^2.4.9
  riverpod_annotation: ^2.3.3

  # Data Storage
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  flutter_secure_storage: ^9.0.0
  sqflite: ^2.3.0
  path_provider: ^2.1.1
  shared_preferences: ^2.2.2

  # Internationalization (REQUIRED - type-safe LocaleKeys)
  easy_localization: ^3.0.3
  intl: ^0.18.1

  # Code Generation (REQUIRED - Freezed for all models)
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1

  # Supabase
  supabase_flutter: ^2.3.0

  # UI Components
  flutter_svg: ^2.0.9
  cached_network_image: ^3.3.0
  image_picker: ^1.0.5

  # Utilities
  uuid: ^4.2.2
  logger: ^2.0.2+1
  dartz: ^0.10.1
  equatable: ^2.0.5
  connectivity_plus: ^5.0.2
  go_router: ^13.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0

  # Code Generation
  build_runner: ^2.4.7
  freezed: ^2.4.6
  json_serializable: ^6.7.1
  riverpod_generator: ^2.3.9
  riverpod_lint: ^2.3.7
```

**Commands to run**:
```bash
flutter pub get
```

**Verification**:
- All dependencies resolve without conflicts
- No version conflicts

---

### Task 1.3: Create Clean Architecture Folder Structure
**Priority**: Critical
**Time Estimate**: 10 minutes

**Directories to create**:

```
lib/
├── core/
│   ├── config/
│   ├── constants/
│   ├── di/
│   ├── errors/
│   ├── extensions/
│   ├── network/
│   ├── routing/
│   ├── sync/
│   ├── theme/
│   ├── utils/
│   └── widgets/
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── pages/
│   │       ├── providers/
│   │       └── widgets/
│   ├── profile/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── pages/
│   │       ├── providers/
│   │       └── widgets/
│   ├── emergency_contacts/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── pages/
│   │       ├── providers/
│   │       └── widgets/
│   └── dive_log/
│       ├── data/
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/
│           ├── pages/
│           ├── providers/
│           └── widgets/
├── shared/
│   ├── utils/
│   └── widgets/
│       ├── animations/
│       ├── buttons/
│       ├── inputs/
│       └── layouts/
└── main.dart

assets/
├── divercity_theme.json (already exists)
├── fonts/ (to be added)
├── icons/ (to be added)
├── images/ (to be added)
└── translations/
    ├── en.json
    ├── es.json
    ├── fr.json
    └── ar.json
```

**Commands**:
```bash
mkdir -p lib/core/{config,constants,di,errors,extensions,network,routing,sync,theme,utils,widgets}
mkdir -p lib/features/auth/{data/{datasources,models,repositories},domain/{entities,repositories,usecases},presentation/{pages,providers,widgets}}
mkdir -p lib/features/profile/{data/{datasources,models,repositories},domain/{entities,repositories,usecases},presentation/{pages,providers,widgets}}
mkdir -p lib/features/emergency_contacts/{data/{datasources,models,repositories},domain/{entities,repositories,usecases},presentation/{pages,providers,widgets}}
mkdir -p lib/features/dive_log/{data/{datasources,models,repositories},domain/{entities,repositories,usecases},presentation/{pages,providers,widgets}}
mkdir -p lib/shared/{utils,widgets/{animations,buttons,inputs,layouts}}
mkdir -p assets/{fonts,icons,images,translations}
```

**Verification**:
- All directories created successfully
- Structure matches clean architecture pattern

---

### Task 1.4: Set Up Internationalization
**Priority**: High
**Time Estimate**: 15 minutes

**Subtask 1.4.1: Create Translation Files**

**Files to create**:
- `assets/translations/en.json`
- `assets/translations/es.json`
- `assets/translations/fr.json`
- `assets/translations/ar.json`

**en.json content**:
```json
{
  "app": {
    "name": "DiverCity",
    "tagline": "Your Dive Companion"
  },
  "auth": {
    "login": "Login",
    "logout": "Logout",
    "signup": "Sign Up",
    "email": "Email",
    "password": "Password",
    "confirm_password": "Confirm Password",
    "forgot_password": "Forgot Password?",
    "dont_have_account": "Don't have an account?",
    "already_have_account": "Already have an account?",
    "login_error": "Invalid email or password",
    "signup_success": "Account created successfully",
    "logout_confirm": "Are you sure you want to logout?"
  },
  "profile": {
    "title": "Profile",
    "edit": "Edit Profile",
    "first_name": "First Name",
    "last_name": "Last Name",
    "age": "Age",
    "birthdate": "Birthdate",
    "blood_type": "Blood Type",
    "phone": "Phone Number",
    "email": "Email",
    "address_street": "Street Address",
    "address_city": "City",
    "address_state": "State/Province",
    "address_postcode": "Postal Code",
    "address_country": "Country",
    "dive_count": "Total Dives",
    "joined_at": "Member Since",
    "emergency_contacts": "Emergency Contacts"
  },
  "dive_log": {
    "title": "Dive Logs",
    "add_dive": "Add Dive",
    "edit_dive": "Edit Dive",
    "dive_number": "Dive #{{number}}",
    "max_depth": "Max Depth",
    "duration": "Duration",
    "water_temp": "Water Temperature",
    "air_temp": "Air Temperature",
    "entry_pressure": "Entry Pressure",
    "exit_pressure": "Exit Pressure",
    "gas_mix": "Gas Mix",
    "dive_site": "Dive Site",
    "location": "Location",
    "dive_date": "Dive Date",
    "notes": "Notes",
    "no_dives": "No dive logs yet",
    "start_logging": "Start logging your dives!",
    "delete_confirm": "Are you sure you want to delete this dive log?"
  },
  "emergency_contacts": {
    "title": "Emergency Contacts",
    "add_contact": "Add Contact",
    "edit_contact": "Edit Contact",
    "name": "Name",
    "relationship": "Relationship",
    "phone": "Phone",
    "email": "Email",
    "address": "Address",
    "notes": "Notes",
    "no_contacts": "No emergency contacts",
    "add_for_safety": "Add contacts for safety",
    "delete_confirm": "Are you sure you want to delete this contact?"
  },
  "common": {
    "save": "Save",
    "cancel": "Cancel",
    "delete": "Delete",
    "edit": "Edit",
    "loading": "Loading...",
    "error": "Error",
    "success": "Success",
    "confirm": "Confirm",
    "yes": "Yes",
    "no": "No",
    "retry": "Retry",
    "search": "Search",
    "filter": "Filter",
    "sort": "Sort",
    "close": "Close",
    "required_field": "This field is required",
    "invalid_email": "Please enter a valid email",
    "password_too_short": "Password must be at least 8 characters",
    "offline": "You are offline",
    "sync_pending": "Changes will sync when you're online"
  }
}
```

**Subtask 1.4.2: Create other language files**
- Copy en.json to es.json, fr.json, ar.json
- Mark as TODO for translation

**Subtask 1.4.3: Update pubspec.yaml**
```yaml
flutter:
  assets:
    - assets/divercity_theme.json
    - assets/translations/
```

**Verification**:
- All translation files exist
- pubspec.yaml includes translations directory

---

### Task 1.5: Configure Theme System
**Priority**: High
**Time Estimate**: 20 minutes

**Subtask 1.5.1: Create Theme Loader**

**File to create**: `lib/core/theme/theme_loader.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';
import 'dart:convert';

class ThemeLoader {
  /// Load theme from assets/divercity_theme.json
  static Future<ThemeData> loadTheme() async {
    try {
      final themeStr = await rootBundle.loadString('assets/divercity_theme.json');
      final themeJson = jsonDecode(themeStr);
      final theme = ThemeDecoder.decodeThemeData(themeJson);

      if (theme == null) {
        throw Exception('Failed to decode theme from JSON');
      }

      return theme;
    } catch (e) {
      // Fallback to default Material 3 theme
      return ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF36618E)),
      );
    }
  }

  /// Customize the loaded theme with additional properties
  static ThemeData customizeTheme(ThemeData baseTheme) {
    return baseTheme.copyWith(
      // Add custom fonts here when selected
      // Add custom ocean-inspired animations/transitions
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  /// Create dark theme variant (TODO: Create dark version of divercity_theme.json)
  static ThemeData createDarkTheme(ThemeData lightTheme) {
    // For now, return a basic dark theme
    // TODO: Load from assets/divercity_theme_dark.json
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF36618E),
        brightness: Brightness.dark,
      ),
    );
  }
}
```

**Subtask 1.5.2: Create App Theme Constants**

**File to create**: `lib/core/theme/app_theme.dart`

```dart
import 'package:flutter/material.dart';

class AppTheme {
  // Ocean-inspired custom colors (from divercity_theme.json)
  static const Color primaryBlue = Color(0xFF36618E);
  static const Color secondaryBlueGray = Color(0xFF535F70);
  static const Color tertiaryPurple = Color(0xFF6B5778);
  static const Color surfaceLight = Color(0xFFF8F9FF);

  // Spacing constants
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;

  // Border radius
  static const double radiusS = 4.0;
  static const double radiusM = 8.0;
  static const double radiusL = 12.0;
  static const double radiusXL = 16.0;

  // Animation durations
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);
}
```

**Subtask 1.5.3: Create Custom Colors Extension**

**File to create**: `lib/core/theme/custom_colors.dart`

```dart
import 'package:flutter/material.dart';

/// Custom color extensions for ocean-inspired theme
class OceanColors {
  // Depth-based gradients
  static const Gradient shallowWater = LinearGradient(
    colors: [Color(0xFF4DB8E8), Color(0xFF3AA0D1)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient deepWater = LinearGradient(
    colors: [Color(0xFF1E4D7B), Color(0xFF0F2744)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient sunset = LinearGradient(
    colors: [Color(0xFFFF6B6B), Color(0xFFFFD93D), Color(0xFF6BCF7F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
```

**Verification**:
- Theme loads successfully from JSON
- Fallback works if JSON fails
- Custom colors are accessible

---

### Task 1.6: Set Up Dio HTTP Client
**Priority**: Critical
**Time Estimate**: 30 minutes

**Subtask 1.6.1: Create API Constants**

**File to create**: `lib/core/constants/api_constants.dart`

```dart
class ApiConstants {
  // Base URL
  static const String baseUrl = 'http://localhost:3000';
  static const String apiVersion = '';

  // Timeout
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Auth endpoints
  static const String login = '/auth/login';
  static const String signup = '/auth/signup';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';

  // Diver endpoints
  static const String divers = '/divers';
  static String diverById(String id) => '/divers/$id';

  // Emergency contacts endpoints
  static const String emergencyContacts = '/emergency-contacts';
  static String emergencyContactById(String id) => '/emergency-contacts/$id';
  static String emergencyContactsByDiverId(String diverId) =>
      '/emergency-contacts/diver/$diverId';

  // Dive logs endpoints
  static const String diveLogs = '/dive-logs';
  static String diveLogById(String id) => '/dive-logs/$id';
  static String diveLogsByDiverId(String diverId) => '/dive-logs/diver/$diverId';

  // Media endpoints (future)
  static const String media = '/media';
  static String mediaById(String id) => '/media/$id';
}
```

**Subtask 1.6.2: Create Auth Interceptor**

**File to create**: `lib/core/network/api_interceptor.dart`

```dart
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
```

**Subtask 1.6.3: Create Dio Client**

**File to create**: `lib/core/network/dio_client.dart`

```dart
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/api_constants.dart';
import 'api_interceptor.dart';

class DioClient {
  late final Dio dio;

  DioClient({FlutterSecureStorage? secureStorage}) {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors
    dio.interceptors.addAll([
      // Auth interceptor
      AuthInterceptor(
        secureStorage: secureStorage ?? const FlutterSecureStorage(),
      ),

      // Logging interceptor (only in debug mode)
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    ]);
  }

  // GET request
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  // POST request
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  // PUT request
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  // DELETE request
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
}
```

**Verification**:
- Dio client instantiates successfully
- Interceptors are added correctly
- Test with a simple API call

---

### Task 1.7: Set Up Local Storage
**Priority**: Critical
**Time Estimate**: 20 minutes

**Subtask 1.7.1: Create Storage Keys**

**File to create**: `lib/core/constants/storage_keys.dart`

```dart
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
```

**Subtask 1.7.2: Create Storage Keys for Constants**

**File to create**: `lib/core/constants/app_constants.dart`

```dart
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
```

**Subtask 1.7.3: Create Dependency Injection**

**File to create**: `lib/core/di/injection.dart`

```dart
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

      // Initialize secure storage (no init needed, just instantiate)
      const secureStorage = FlutterSecureStorage();
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
```

**Verification**:
- Hive initializes successfully
- All boxes open without errors
- Secure storage is accessible

---

### Task 1.8: Update main.dart with Foundation
**Priority**: Critical
**Time Estimate**: 25 minutes

**File to modify**: `lib/main.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'core/theme/theme_loader.dart';
import 'core/di/injection.dart';
import 'core/utils/logger.dart';
import 'features/auth/presentation/pages/splash_page.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  try {
    AppLogger.info('Starting DiverCity app...');

    // Initialize easy_localization
    await EasyLocalization.ensureInitialized();
    AppLogger.info('Localization initialized');

    // Initialize dependencies (Hive, secure storage, etc.)
    await DependencyInjection.init();

    // Load theme from JSON
    final theme = await ThemeLoader.loadTheme();
    final darkTheme = ThemeLoader.createDarkTheme(theme);
    AppLogger.info('Theme loaded');

    runApp(
      EasyLocalization(
        supportedLocales: const [
          Locale('en'),
          Locale('es'),
          Locale('fr'),
          Locale('ar'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: ProviderScope(
          child: MyApp(
            theme: theme,
            darkTheme: darkTheme,
          ),
        ),
      ),
    );
  } catch (e, stackTrace) {
    AppLogger.error('Failed to start app', error: e, stackTrace: stackTrace);

    // Show error screen
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                const Text(
                  'Failed to start DiverCity',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('Error: $e'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  final ThemeData theme;
  final ThemeData darkTheme;

  const MyApp({
    super.key,
    required this.theme,
    required this.darkTheme,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DiverCity',

      // Theme
      theme: ThemeLoader.customizeTheme(theme),
      darkTheme: ThemeLoader.customizeTheme(darkTheme),
      themeMode: ThemeMode.system,

      // Localization
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      // Routing (will be replaced with GoRouter in Phase 7)
      home: const SplashPage(),

      // Debug
      debugShowCheckedModeBanner: false,
    );
  }
}
```

**Verification**:
- App starts without errors
- Theme loads correctly
- Localization works
- Dependencies initialize successfully

---

## Phase 2: Data Models & Code Generation

### Task 2.1: Create Diver Model (Profile)
**Priority**: High
**Time Estimate**: 20 minutes

**File to create**: `lib/features/profile/data/models/diver_model.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'diver_model.freezed.dart';
part 'diver_model.g.dart';

@freezed
class DiverModel with _$DiverModel {
  const factory DiverModel({
    required String id,
    required String firstname,
    required String lastname,
    int? age,
    DateTime? birthdate,
    @JsonKey(name: 'address_street') String? addressStreet,
    @JsonKey(name: 'address_city') String? addressCity,
    @JsonKey(name: 'address_state') String? addressState,
    @JsonKey(name: 'address_postcode') String? addressPostcode,
    @JsonKey(name: 'address_country') String? addressCountry,
    String? phone,
    String? email,
    @JsonKey(name: 'blood_type') String? bloodType,
    @JsonKey(name: 'dive_log') String? diveLog,
    @JsonKey(name: 'dive_count') @Default(0) int diveCount,
    @JsonKey(name: 'joined_at') DateTime? joinedAt,
    @JsonKey(name: 'emergency_contacts') List<String>? emergencyContacts,
  }) = _DiverModel;

  factory DiverModel.fromJson(Map<String, dynamic> json) =>
      _$DiverModelFromJson(json);
}
```

**Commands**:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

**Verification**:
- `.freezed.dart` and `.g.dart` files generated
- No compilation errors

---

### Task 2.2: Create Emergency Contact Model
**Priority**: High
**Time Estimate**: 15 minutes

**File to create**: `lib/features/emergency_contacts/data/models/emergency_contact_model.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'emergency_contact_model.freezed.dart';
part 'emergency_contact_model.g.dart';

@freezed
class EmergencyContactModel with _$EmergencyContactModel {
  const factory EmergencyContactModel({
    required String id,
    required String name,
    String? relationship,
    required String phone,
    String? email,
    String? address,
    String? notes,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _EmergencyContactModel;

  factory EmergencyContactModel.fromJson(Map<String, dynamic> json) =>
      _$EmergencyContactModelFromJson(json);
}
```

**Commands**:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

### Task 2.3: Create Dive Log Model
**Priority**: High
**Time Estimate**: 20 minutes

**File to create**: `lib/features/dive_log/data/models/dive_log_model.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dive_log_model.freezed.dart';
part 'dive_log_model.g.dart';

@freezed
class DiveLogModel with _$DiveLogModel {
  const factory DiveLogModel({
    required String id,
    @JsonKey(name: 'log_name') String? logName,
    String? description,
    @JsonKey(name: 'created_at') DateTime? createdAt,

    // Extended fields for actual dive entries
    // NOTE: These may not exist in current backend schema
    @JsonKey(name: 'dive_date') DateTime? diveDate,
    @JsonKey(name: 'dive_site') String? diveSite,
    String? location,
    @JsonKey(name: 'max_depth') double? maxDepth, // meters
    int? duration, // minutes
    @JsonKey(name: 'water_temperature') double? waterTemperature, // celsius
    @JsonKey(name: 'air_temperature') double? airTemperature, // celsius
    @JsonKey(name: 'entry_pressure') double? entryPressure, // bar
    @JsonKey(name: 'exit_pressure') double? exitPressure, // bar
    @JsonKey(name: 'gas_mix') String? gasMix,
    String? notes,
  }) = _DiveLogModel;

  factory DiveLogModel.fromJson(Map<String, dynamic> json) =>
      _$DiveLogModelFromJson(json);
}
```

**NOTE**: Backend schema may need extension for detailed dive parameters

**Commands**:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

### Task 2.4: Create Auth Models
**Priority**: High
**Time Estimate**: 25 minutes

**Subtask 2.4.1: Auth User Model**

**File to create**: `lib/features/auth/data/models/auth_user_model.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user_model.freezed.dart';
part 'auth_user_model.g.dart';

@freezed
class AuthUserModel with _$AuthUserModel {
  const factory AuthUserModel({
    required String id,
    required String email,
    @JsonKey(name: 'access_token') String? accessToken,
    @JsonKey(name: 'refresh_token') String? refreshToken,
    @JsonKey(name: 'expires_at') DateTime? expiresAt,
  }) = _AuthUserModel;

  factory AuthUserModel.fromJson(Map<String, dynamic> json) =>
      _$AuthUserModelFromJson(json);
}
```

**Subtask 2.4.2: Login Request Model**

**File to create**: `lib/features/auth/data/models/login_request_model.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_request_model.freezed.dart';
part 'login_request_model.g.dart';

@freezed
class LoginRequestModel with _$LoginRequestModel {
  const factory LoginRequestModel({
    required String email,
    required String password,
  }) = _LoginRequestModel;

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestModelFromJson(json);
}
```

**Subtask 2.4.3: Signup Request Model**

**File to create**: `lib/features/auth/data/models/signup_request_model.dart`

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_request_model.freezed.dart';
part 'signup_request_model.g.dart';

@freezed
class SignupRequestModel with _$SignupRequestModel {
  const factory SignupRequestModel({
    required String email,
    required String password,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
  }) = _SignupRequestModel;

  factory SignupRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SignupRequestModelFromJson(json);
}
```

**Commands**:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

### Task 2.5: Create Domain Entities
**Priority**: High
**Time Estimate**: 30 minutes

**Subtask 2.5.1: Diver Entity**

**File to create**: `lib/features/profile/domain/entities/diver_entity.dart`

```dart
import 'package:equatable/equatable.dart';

class DiverEntity extends Equatable {
  final String id;
  final String firstname;
  final String lastname;
  final int? age;
  final DateTime? birthdate;
  final String? addressStreet;
  final String? addressCity;
  final String? addressState;
  final String? addressPostcode;
  final String? addressCountry;
  final String? phone;
  final String? email;
  final String? bloodType;
  final String? diveLog;
  final int diveCount;
  final DateTime? joinedAt;
  final List<String>? emergencyContacts;

  const DiverEntity({
    required this.id,
    required this.firstname,
    required this.lastname,
    this.age,
    this.birthdate,
    this.addressStreet,
    this.addressCity,
    this.addressState,
    this.addressPostcode,
    this.addressCountry,
    this.phone,
    this.email,
    this.bloodType,
    this.diveLog,
    this.diveCount = 0,
    this.joinedAt,
    this.emergencyContacts,
  });

  String get fullName => '$firstname $lastname';

  @override
  List<Object?> get props => [
        id,
        firstname,
        lastname,
        age,
        birthdate,
        addressStreet,
        addressCity,
        addressState,
        addressPostcode,
        addressCountry,
        phone,
        email,
        bloodType,
        diveLog,
        diveCount,
        joinedAt,
        emergencyContacts,
      ];
}
```

**Subtask 2.5.2: Emergency Contact Entity**

**File to create**: `lib/features/emergency_contacts/domain/entities/emergency_contact_entity.dart`

```dart
import 'package:equatable/equatable.dart';

class EmergencyContactEntity extends Equatable {
  final String id;
  final String name;
  final String? relationship;
  final String phone;
  final String? email;
  final String? address;
  final String? notes;
  final DateTime? createdAt;

  const EmergencyContactEntity({
    required this.id,
    required this.name,
    this.relationship,
    required this.phone,
    this.email,
    this.address,
    this.notes,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        relationship,
        phone,
        email,
        address,
        notes,
        createdAt,
      ];
}
```

**Subtask 2.5.3: Dive Log Entity**

**File to create**: `lib/features/dive_log/domain/entities/dive_log_entity.dart`

```dart
import 'package:equatable/equatable.dart';

class DiveLogEntity extends Equatable {
  final String id;
  final String? logName;
  final String? description;
  final DateTime? createdAt;
  final DateTime? diveDate;
  final String? diveSite;
  final String? location;
  final double? maxDepth;
  final int? duration;
  final double? waterTemperature;
  final double? airTemperature;
  final double? entryPressure;
  final double? exitPressure;
  final String? gasMix;
  final String? notes;

  const DiveLogEntity({
    required this.id,
    this.logName,
    this.description,
    this.createdAt,
    this.diveDate,
    this.diveSite,
    this.location,
    this.maxDepth,
    this.duration,
    this.waterTemperature,
    this.airTemperature,
    this.entryPressure,
    this.exitPressure,
    this.gasMix,
    this.notes,
  });

  @override
  List<Object?> get props => [
        id,
        logName,
        description,
        createdAt,
        diveDate,
        diveSite,
        location,
        maxDepth,
        duration,
        waterTemperature,
        airTemperature,
        entryPressure,
        exitPressure,
        gasMix,
        notes,
      ];
}
```

**Subtask 2.5.4: User Entity**

**File to create**: `lib/features/auth/domain/entities/user_entity.dart`

```dart
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;

  const UserEntity({
    required this.id,
    required this.email,
  });

  @override
  List<Object?> get props => [id, email];
}
```

**Verification**:
- All entities compile without errors
- Entities use equatable correctly

---

### Task 2.6: Register Hive Type Adapters
**Priority**: Medium
**Time Estimate**: 20 minutes

**Subtask 2.6.1: Create Diver Model Adapter**

**File to create**: `lib/features/profile/data/models/diver_model_adapter.dart`

```dart
import 'package:hive/hive.dart';
import 'diver_model.dart';

class DiverModelAdapter extends TypeAdapter<DiverModel> {
  @override
  final int typeId = 0;

  @override
  DiverModel read(BinaryReader reader) {
    final json = reader.readMap().cast<String, dynamic>();
    return DiverModel.fromJson(json);
  }

  @override
  void write(BinaryWriter writer, DiverModel obj) {
    writer.writeMap(obj.toJson());
  }
}
```

**Subtask 2.6.2: Create Emergency Contact Model Adapter**

**File to create**: `lib/features/emergency_contacts/data/models/emergency_contact_model_adapter.dart`

```dart
import 'package:hive/hive.dart';
import 'emergency_contact_model.dart';

class EmergencyContactModelAdapter extends TypeAdapter<EmergencyContactModel> {
  @override
  final int typeId = 1;

  @override
  EmergencyContactModel read(BinaryReader reader) {
    final json = reader.readMap().cast<String, dynamic>();
    return EmergencyContactModel.fromJson(json);
  }

  @override
  void write(BinaryWriter writer, EmergencyContactModel obj) {
    writer.writeMap(obj.toJson());
  }
}
```

**Subtask 2.6.3: Create Dive Log Model Adapter**

**File to create**: `lib/features/dive_log/data/models/dive_log_model_adapter.dart`

```dart
import 'package:hive/hive.dart';
import 'dive_log_model.dart';

class DiveLogModelAdapter extends TypeAdapter<DiveLogModel> {
  @override
  final int typeId = 2;

  @override
  DiveLogModel read(BinaryReader reader) {
    final json = reader.readMap().cast<String, dynamic>();
    return DiveLogModel.fromJson(json);
  }

  @override
  void write(BinaryWriter writer, DiveLogModel obj) {
    writer.writeMap(obj.toJson());
  }
}
```

**Subtask 2.6.4: Update Dependency Injection**

**File to modify**: `lib/core/di/injection.dart`

Add imports and register adapters:

```dart
import '../../features/profile/data/models/diver_model_adapter.dart';
import '../../features/emergency_contacts/data/models/emergency_contact_model_adapter.dart';
import '../../features/dive_log/data/models/dive_log_model_adapter.dart';

// In init() method, before opening boxes:
// Register Hive adapters
Hive.registerAdapter(DiverModelAdapter());
Hive.registerAdapter(EmergencyContactModelAdapter());
Hive.registerAdapter(DiveLogModelAdapter());
AppLogger.info('Hive adapters registered');
```

**Verification**:
- Adapters register without errors
- Boxes open successfully

---

## Phase 3: Data Layer

### Task 3.1: Create Error Handling Classes
**Priority**: High
**Time Estimate**: 15 minutes

**Subtask 3.1.1: Create Exceptions**

**File to create**: `lib/core/errors/exceptions.dart`

```dart
class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() => 'ServerException: $message (status: $statusCode)';
}

class CacheException implements Exception {
  final String message;

  CacheException({required this.message});

  @override
  String toString() => 'CacheException: $message';
}

class NetworkException implements Exception {
  final String message;

  NetworkException({required this.message});

  @override
  String toString() => 'NetworkException: $message';
}

class AuthException implements Exception {
  final String message;

  AuthException({required this.message});

  @override
  String toString() => 'AuthException: $message';
}

class ValidationException implements Exception {
  final Map<String, String> errors;

  ValidationException({required this.errors});

  @override
  String toString() => 'ValidationException: $errors';
}
```

**Subtask 3.1.2: Create Failures**

**File to create**: `lib/core/errors/failures.dart`

```dart
abstract class Failure {
  final String message;

  Failure({required this.message});

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  final int? statusCode;

  ServerFailure({
    required String message,
    this.statusCode,
  }) : super(message: message);
}

class CacheFailure extends Failure {
  CacheFailure({required String message}) : super(message: message);
}

class NetworkFailure extends Failure {
  NetworkFailure({required String message}) : super(message: message);
}

class AuthFailure extends Failure {
  AuthFailure({required String message}) : super(message: message);
}

class ValidationFailure extends Failure {
  final Map<String, String> errors;

  ValidationFailure({
    required String message,
    required this.errors,
  }) : super(message: message);
}
```

**Verification**:
- All exception and failure classes compile

---

### Task 3.2: Create Network Info Utility
**Priority**: Medium
**Time Estimate**: 10 minutes

**File to create**: `lib/core/network/network_info.dart`

```dart
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<bool> get connectivityStream;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl({required this.connectivity});

  @override
  Future<bool> get isConnected async {
    final result = await connectivity.checkConnectivity();
    return _isConnectedResult(result);
  }

  @override
  Stream<bool> get connectivityStream {
    return connectivity.onConnectivityChanged.map(_isConnectedResult);
  }

  bool _isConnectedResult(List<ConnectivityResult> result) {
    return result.any((r) => r != ConnectivityResult.none);
  }
}
```

**Verification**:
- Network connectivity can be checked

---

### Task 3.3: Create Logger Utility
**Priority**: High
**Time Estimate**: 10 minutes

**File to create**: `lib/core/utils/logger.dart`

```dart
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
```

---

(Continuing in next part due to length...)

## Remaining Tasks Summary

**Phase 3 (continued)**: Remote/Local Data Sources, Repositories, Validators & Extensions

**Phase 4**: Domain Layer - Use Cases for all features

**Phase 5**: Presentation - Riverpod Providers and DI

**Phase 6**: Presentation - UI Pages and Widgets

**Phase 7**: Polish - Custom Fonts, Design, Routing, Sync, Testing

---

## Critical Implementation Notes

### 1. Backend Schema Consideration
**IMPORTANT**: Current `dive_logs` table schema is minimal:
- Existing fields: `id`, `log_name`, `description`, `created_at`
- Missing fields: `dive_date`, `dive_site`, `location`, `max_depth`, `duration`, `water_temperature`, `air_temperature`, `entry_pressure`, `exit_pressure`, `gas_mix`, `notes`

**Two Options**:
1. **Extend dive_logs table** with additional columns (simpler)
2. **Create dive_entries table** with FK to dive_logs (better separation)

**Recommendation**: Option 2 is architecturally better. `dive_logs` acts as container/logbook, `dive_entries` are individual dives.

**Action Required**: Coordinate with backend team to extend schema before implementing dive log features.

---

### 2. Storage Strategy

**Decision Tree**:
- **Sensitive data** (auth tokens, passwords) → `flutter_secure_storage`
- **Simple settings** (locale, theme) → `SharedPreferences`
- **Structured data** (profiles, dive logs) → `Hive` with TypeAdapters
- **Complex queries** (if needed) → `SQLite`

---

### 3. Offline-First Implementation

**Read Operations**:
1. Try cache first
2. If online, fetch from server
3. Update cache with server data
4. Return data (cache or server)

**Write Operations**:
1. Write to cache immediately (optimistic update)
2. Add to sync queue
3. If online, sync immediately
4. If offline, queue for later sync

**Sync Queue**:
- Store pending operations in Hive
- Process when connection restored
- Retry failed operations with exponential backoff

---

### 4. Code Generation Commands

**One-time build**:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

**Watch mode** (during development):
```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

**When to run**:
- After creating/modifying Freezed models
- After creating/modifying Riverpod providers
- After changing JSON serialization

---

### 5. Testing Strategy

**Unit Tests**:
- Use cases (business logic)
- Repositories (offline-first logic)
- Validators and formatters

**Widget Tests**:
- Forms and validation
- Key UI components
- State changes

**Integration Tests**:
- Authentication flow
- Dive log creation flow
- Offline sync scenarios

---

## Execution Order & Dependencies

### Phase Dependencies
```
Phase 1 (Foundation)
    ↓
Phase 2 (Models & Code Gen)
    ↓
Phase 3 (Data Layer)
    ↓
Phase 4 (Domain Layer)
    ↓
Phase 5 (State Management)
    ↓
Phase 6 (UI)
    ↓
Phase 7 (Polish & Testing)
```

### Parallel Work Opportunities
- **After Phase 1**: All models can be created in parallel
- **After Phase 2**: Data sources for different features can be created in parallel
- **After Phase 4**: Providers for different features can be created in parallel
- **After Phase 5**: UI pages for different features can be created in parallel

---

## Critical Files to Implement First

1. **`pubspec.yaml`** - Dependencies must be correct before any code
2. **`lib/main.dart`** - App initialization and configuration
3. **`lib/core/network/dio_client.dart`** - All API calls depend on this
4. **`lib/core/theme/theme_loader.dart`** - Theme system foundation
5. **`lib/core/di/injection.dart`** - Storage and dependency initialization

---

## Next Steps After Foundation

Once Phase 1 is complete:
1. Generate all Freezed models (Phase 2)
2. Run build_runner to generate code
3. Implement data sources and repositories (Phase 3)
4. Create use cases (Phase 4)
5. Build Riverpod providers (Phase 5)
6. Develop UI (Phase 6)
7. Polish and test (Phase 7)

---

## Success Criteria

**Phase 1 Complete When**:
- ✅ All dependencies installed
- ✅ Folder structure created
- ✅ Theme loads from JSON
- ✅ i18n configured
- ✅ Dio client ready
- ✅ Hive initialized
- ✅ App starts without errors

**Full Implementation Complete When**:
- ✅ User can register and login
- ✅ User can create/edit profile
- ✅ User can add emergency contacts
- ✅ User can log dives with all parameters
- ✅ App works offline with sync queue
- ✅ UI has distinctive ocean-inspired design
- ✅ All features tested
- ✅ Documentation complete
