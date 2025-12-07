# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

A complete plan for the project has been written in plan.md

## Project Overview

DiverCity is a cross-platform dive logbook application built with Flutter, targeting iOS, iPadOS, macOS, Windows, Android, and Web. The app allows divers to track dive logs with detailed parameters, media attachments, user profiles, and emergency contacts. The backend is Node.js with Supabase.

**Key Features:**
- Dive logging with technical parameters (depth, duration, temperature, gas mix)
- User profiles and emergency contacts
- Offline-first architecture with background sync
- Media attachments for dives
- Internationalization support

## Common Development Commands

### Running the App
```bash
# Run on default device
flutter run

# Run on specific device
flutter devices
flutter run -d <device-id>

# Run with hot reload (default)
flutter run

# Run in release mode
flutter run --release

# Run on Chrome (web)
flutter run -d chrome
```

### Code Generation
**IMPORTANT:** This project uses Freezed and json_serializable extensively. After any model changes:

```bash
# One-time build
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode during active development
flutter pub run build_runner watch --delete-conflicting-outputs
```

Generated files (`.freezed.dart`, `.g.dart`) should be committed to version control.

### Testing
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/path/to/test_file.dart

# Run tests with coverage
flutter test --coverage

# Run widget tests only
flutter test test/widget_test.dart
```

### Dependency Management
```bash
# Get dependencies
flutter pub get

# Upgrade dependencies
flutter pub upgrade

# Check for outdated packages
flutter pub outdated
```

### Code Quality
```bash
# Run linter
flutter analyze

# Format code
dart format .
```

### Building
```bash
# Build APK (Android)
flutter build apk

# Build iOS
flutter build ios

# Build for macOS
flutter build macos

# Build for Windows
flutter build windows

# Build for web
flutter build web
```

## Architecture

The project follows **Clean Architecture** with a feature-based folder structure:

```
lib/
├── core/              # Core utilities, constants, extensions
│   ├── theme/         # Theme configuration (uses assets/divercity_theme.json)
│   ├── constants/     # App-wide constants
│   └── utils/         # Helper functions
├── features/          # Feature modules (organized by domain)
│   └── feature_name/
│       ├── data/      # Data sources, repositories, models
│       ├── domain/    # Entities, use cases
│       └── presentation/  # Pages, widgets, state
├── shared/            # Shared widgets, utilities
└── main.dart
```

**Architectural Principles:**
- Repository pattern for data access
- Dependency injection for loose coupling
- Small, composable widgets over monolithic ones
- State management with Provider or Riverpod
- Separation of concerns (data/domain/presentation)

## Required Dependencies & Usage Rules

### HTTP & Networking
- **Dio (REQUIRED):** All API calls MUST use Dio with interceptors for logging, auth, and error handling
- NEVER use the `http` package directly for API requests
- API documentation available at: `http://localhost:3000/api-docs/` (Swagger)

### Data Storage
Follow this storage decision tree:
- **Sensitive data** (tokens, passwords) → `flutter_secure_storage`
- **Simple key-value settings** → `SharedPreferences`
- **Structured non-sensitive data** → `Hive` with TypeAdapters
- **Complex relational data** → `SQLite`

### Internationalization
- **easy_localization (REQUIRED):** All user-facing strings must use type-safe LocaleKeys
- NEVER use string literals for translations (e.g., `'welcome_message'.tr()`)
- ALWAYS use LocaleKeys classes (e.g., `LocaleKeys.home_welcomeMessage.tr()`)
- Support RTL languages (Arabic, Hebrew)
- Format dates, numbers, currencies according to locale

### Code Generation
- **Freezed (REQUIRED):** All data models must use Freezed for immutability
- **json_serializable:** For JSON serialization/deserialization
- Run `flutter pub run build_runner build` after model changes

## Theme & Design

### Theme Implementation
- Use the DiverCity theme defined in [assets/divercity_theme.json](assets/divercity_theme.json)
- Set theme in `MaterialApp` configuration
- NEVER hardcode colors or sizes in widgets - always use `Theme.of(context)`
- Support both light and dark mode based on system preferences

### Design Aesthetic
The app should have a **distinctive, memorable visual identity** inspired by diving:
- **Typography:** Characterful fonts that evoke underwater exploration (avoid Inter, Roboto, system fonts)
- **Color:** Ocean-inspired palette beyond predictable blue gradients
- **Motion:** Fluid animations that evoke underwater movement
- **Visuals:** Dive-specific iconography, custom illustrations, gradient meshes
- **Layout:** Asymmetric layouts with generous negative space
- Goal: Premium dive companion, not a generic CRUD interface

## Code Style & Standards

### General Guidelines
- Use `log` from `dart:developer` rather than `print` or `debugPrint` for logging
- Implement proper error handling with try-catch blocks
- Prefer small, composable widgets
- Follow repository pattern for data access
- Implement proper dependency injection

### Security
- Store sensitive data encrypted locally using `flutter_secure_storage`
- Validate all user inputs
- Never commit API keys, tokens, or credentials
- Use Row Level Security policies on backend

### Offline-First Approach
- Cache data locally for offline access
- Implement background sync when connectivity is restored
- Handle conflict resolution for offline-created entries
- Provide clear feedback for sync status

## API Integration

- Backend API documented via Swagger at `http://localhost:3000/api-docs/`
- All API interactions must follow Swagger contracts
- Key endpoints: auth, user profiles, dive CRUD, media upload, search/filter
- Use Dio interceptors for:
  - Authentication headers
  - Request/response logging
  - Error handling
  - Retry logic

## Testing Strategy

- Write widget tests for UI components
- Write unit tests for business logic (use cases, repositories)
- Test offline scenarios and sync behavior
- Test internationalization with multiple locales
- Run tests before commits

## Project State

**Current Status:** Early stage - the project currently has only the default Flutter counter app in [lib/main.dart](lib/main.dart). The architecture defined in [specs/initial-requirements.md](specs/initial-requirements.md) needs to be implemented.

**Next Steps:**
1. Set up required dependencies (Dio, Hive, flutter_secure_storage, easy_localization, Freezed)
2. Implement folder structure per clean architecture
3. Set up theme configuration from [assets/divercity_theme.json](assets/divercity_theme.json)
4. Implement authentication flow with Supabase
5. Build core dive logging features
