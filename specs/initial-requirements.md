# DiverCity - Dive Logbook Initial Requirements

I want to build a comprehensive diving logbook application that allows divers to track and document their diving experiences with detailed information and media attachments.

The app should be built with Flutter (targeting iOS, iPadOS, macOS, Windows, and Android) with a Node.js backend using Supabase, and have the following features:

## Core Dive Logging Features

### User Account & Profile

- Create and manage a user account with authentication
- Set up a personalised diver profile with:
  - Personal information (name, contact details)
  - Diver certifications and qualification levels
  - Diving preferences and specialities
  - Profile photo
- Secure authentication flow using Supabase Auth

### Emergency Contacts

- Record Emergency Contacts details for the user:
  - name
  - relationship
  - phone
  - email
  - address
  - notes
  - created_at

### Basic Dive Information Entry

- Record essential dive details:
  - Date and time of dive (with timezone support)
  - Dive site location (with search/autocomplete functionality)
  - Dive site name
  - Entry and exit times
- Support for various diving environments (sea, lakes, rivers, quarries)

### Technical Dive Parameters

- Record maximum depth achieved during the dive
- Log total dive duration
- Document water temperature at depth
- Document air/gas temperature
- Track additional parameters:
  - Entry pressure
  - Exit pressure
  - Gas mix used (air, nitrox, etc.)

### Personal Documentation

- Add personalised text notes for each dive with rich text support
- Support for offline media capture with sync when connectivity is restored

## API Documentation

- The complete API specification is available via Swagger at: **<http://localhost:3000/api-docs/>**
- All API interactions should follow the contracts defined in the Swagger documentation
- Key API endpoints to implement:
  - User authentication and profile management endpoints
  - Dive CRUD operations (Create, Read, Update, Delete)
  - Media upload and retrieval endpoints
  - Search and filter endpoints for dive logs
- Reference the Swagger spec for:
  - Exact request/response schemas
  - Required vs optional fields
  - Data validation rules
  - Authentication header formats
  - Error response structures

## Technical Requirements

### Backend Architecture

- Node.js backend already implemented with:
  - RESTful API endpoints
  - Supabase integration for database operations
  - Row Level Security policies for data protection
  - Layered architecture (controllers, services, routes)
  - SQL migrations for database schema management

### Frontend Architecture

- Flutter application with:
  - Cross-platform compatibility (iOS, iPadOS, macOS, Windows, Android, Web)
  - Offline-first architecture with local data caching
  - Background sync when connectivity is restored
  - Proper error handling and user feedback
  - Type-safe data models with code generation
  - Secure storage for sensitive data (tokens, passwords)
  - Internationalization support with type-safe translation keys
  - Distinctive, memorable UI that avoids generic design patterns

### Theming & Visual Identity

#### Theme Implementation

- Use the existing DiverCity theme defined in `assets/divercity_theme.json`
- Set theme in `MaterialApp` configuration, never hardcode colors/sizes in widgets
- Support light and dark mode based on system preferences

#### Design Aesthetic Direction

The app should have a **distinctive, memorable visual identity** that reflects the diving experience:

**Typography:**

- Choose characterful fonts that evoke underwater exploration
- Avoid generic fonts (Inter, Roboto, Arial, system fonts)
- Pair a distinctive display font for headings with a refined body font

**Color & Atmosphere:**

- Ocean-inspired palette that goes beyond predictable blue gradients
- Create depth through layered transparencies, subtle textures
- Use color to convey dive conditions (depth, temperature, visibility)

**Motion & Interactions:**

- Fluid animations that evoke underwater movement
- Staggered reveals for dive log entries
- Contextual micro-interactions (e.g., depth gauge animations)
- Page transitions that feel immersive

**Visual Details:**

- Gradient meshes or noise textures for atmospheric backgrounds
- Custom illustrations for empty states and onboarding
- Dive-specific iconography (not generic Material icons)
- Unique card designs for dive log entries that break from standard patterns

**Spatial Composition:**

- Asymmetric layouts for visual interest
- Generous negative space for premium feel
- Grid-breaking elements for key features
- Depth through layering and shadows

**Goal:** Create an app that feels like a premium dive companion, not a generic CRUD interface.

### Code Style

- Follow Flutter best practices with proper separation of concerns
- Organise code with a clear folder structure following clean architecture:

  ```
  lib/
  ├── core/              # Core utilities, constants, extensions
  │   ├── theme/         # Theme configuration
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

- Prefer small, composable widgets over large monolithic ones
- Use `Provider` or `Riverpod` for state management
- Implement proper error handling with try-catch blocks
- Use `log` from `dart:developer` rather than `print` or `debugPrint` for logging
- Follow repository pattern for data access
- Implement proper dependency injection

### Code Generation

- All data models must use Freezed for immutability
- Use json_serializable for API models
- Run `flutter pub run build_runner build` after model changes
- Run `flutter pub run build_runner watch` during active development
- Generated files (.freezed.dart, .g.dart) should be committed to version control

### Required Dependencies

#### HTTP & Networking

- **Dio** (required): All API calls must use Dio with interceptors for logging, auth, and error handling
- Never use the http package directly for API requests

#### Data Storage

- **Hive** (required): For caching and storing non-sensitive data
- **flutter_secure_storage** (required): For sensitive data (auth tokens, API keys, passwords)
- **SQLite**: For complex relational offline data (dive logs with relationships)

**Storage Decision Tree:**

- Sensitive data (tokens, passwords) → flutter_secure_storage
- Simple key-value settings → SharedPreferences
- Structured non-sensitive data → Hive with TypeAdapters
- Complex relational data → SQLite

#### Internationalization

- **easy_localization** (required): All user-facing strings must use type-safe LocaleKeys
- NEVER use string literals for translations (e.g., 'welcome_message'.tr())
- ALWAYS use LocaleKeys classes (e.g., LocaleKeys.home_welcomeMessage.tr())

#### Code Generation

- **Freezed** (required): All data models must use Freezed for immutability
- **json_serializable**: For JSON serialization/deserialization
- **build_runner**: Run after model changes

### Data Management

- **Sensitive Data:** Use flutter_secure_storage for auth tokens, API keys, personal info
- **App Cache:** Use Hive with TypeAdapters for non-sensitive structured data
- **Relational Data:** Use SQLite for dive logs with complex relationships
- **Simple Settings:** Use SharedPreferences for non-sensitive key-value pairs
- Sync with Supabase backend when online
- Handle conflict resolution for offline-created entries
- Implement proper data validation on client
- Support for data export (PDF, CSV formats)

### Security & Privacy

- Implement secure authentication flow
- Store sensitive data encrypted locally
- Use Row Level Security policies on backend
- Validate all user inputs
- Implement proper session management

## Other Requirements

### Performance

- Ensure smooth scrolling for dive log lists
- Implement pagination for large datasets
- Optimise image loading with lazy loading
- Minimise battery usage during background sync

### User Experience

- Provide clear feedback for all user actions
- Implement proper loading states
- Show meaningful error messages
- Support for pull-to-refresh on dive list
- Implement search and filter functionality for dive logs

### Internationalization

- Support multiple languages from day one
- Use easy_localization with type-safe translation keys
- All user-facing strings must be externalized
- Support RTL languages (Arabic, Hebrew)
- Format dates, numbers, and currencies according to locale
- Provide context-aware translations for diving terminology

### Accessibility

- Support for screen readers
- Proper contrast ratios for text
- Scalable text sizes
- Keyboard navigation support (desktop platforms)

---

This document serves as the initial requirements specification for the DiverCity dive logbook MVP, focusing on core dive logging functionality with user profiles and emergency contacts.
