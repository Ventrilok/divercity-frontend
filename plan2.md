# DiverCity Flutter App - Mockup/Prototype Implementation Plan

## Overview
Create a working, interactive Flutter app prototype with mock data. This approach allows you to visualize and test the UI/UX before implementing full backend integration.

## Strategy
1. **Foundation first**: Set up dependencies, theme, and i18n
2. **Mock data providers**: Create fake data instead of API calls
3. **UI implementation**: Build all pages with the ocean-inspired design
4. **Navigation**: Implement routing between pages
5. **Interactive mockup**: Allow CRUD operations on mock data (stored in memory/local storage)
6. **Polish**: Animations and design refinements

**Backend integration will be deferred to Phase 2** (after prototype approval)

---

## Phase 1: Quick Foundation Setup (~30 minutes)

### Task 1.1: Fix Asset Configuration & Add Dependencies
**Files to modify:**
- [pubspec.yaml](pubspec.yaml)

**Actions:**
1. Fix asset path: Change `appainter_theme.json` to `divercity_theme.json`
2. Add essential dependencies only:
   - `flutter_riverpod` (state management)
   - `go_router` (navigation)
   - `json_theme` (theme loading)
   - `easy_localization` (i18n)
   - `uuid` (generating IDs for mock data)
   - `intl` (date formatting)
   - `shared_preferences` (persisting mock data)

**Skip for now:**
- Dio (no API calls yet)
- Hive (use shared_preferences for simple persistence)
- Freezed (can add later if needed)
- Supabase

**Commands:**
```bash
flutter pub get
```

---

### Task 1.2: Create Simplified Folder Structure
**Create only what's needed for mockup:**

```
lib/
├── core/
│   ├── theme/
│   │   ├── theme_loader.dart
│   │   └── app_theme.dart
│   ├── routing/
│   │   └── app_router.dart
│   └── constants/
│       └── app_constants.dart
├── data/
│   └── mock/
│       ├── mock_divers.dart
│       ├── mock_dive_logs.dart
│       └── mock_emergency_contacts.dart
├── models/
│   ├── diver.dart
│   ├── dive_log.dart
│   └── emergency_contact.dart
├── providers/
│   ├── diver_provider.dart
│   ├── dive_log_provider.dart
│   └── emergency_contacts_provider.dart
├── screens/
│   ├── splash_screen.dart
│   ├── home_screen.dart
│   ├── profile_screen.dart
│   ├── dive_logs_screen.dart
│   ├── dive_log_detail_screen.dart
│   ├── add_dive_screen.dart
│   └── emergency_contacts_screen.dart
└── widgets/
    ├── ocean_background.dart
    ├── dive_card.dart
    └── custom_button.dart

assets/
├── divercity_theme.json (exists)
└── translations/
    ├── en.json
    ├── es.json
    ├── fr.json
    └── ar.json
```

---

### Task 1.3: Set Up Translation Files
**Create minimal translations** (only what's visible in mockup)

**Files to create:**
- `assets/translations/en.json`
- `assets/translations/es.json` (copy of en.json for now)
- `assets/translations/fr.json` (copy of en.json for now)
- `assets/translations/ar.json` (copy of en.json for now)

**en.json content:**
```json
{
  "app": {
    "name": "DiverCity",
    "tagline": "Your Dive Companion"
  },
  "nav": {
    "home": "Home",
    "dive_logs": "Dive Logs",
    "profile": "Profile",
    "emergency": "Emergency Contacts"
  },
  "profile": {
    "title": "Profile",
    "first_name": "First Name",
    "last_name": "Last Name",
    "email": "Email",
    "phone": "Phone",
    "dive_count": "Total Dives",
    "edit": "Edit Profile"
  },
  "dive_log": {
    "title": "Dive Logs",
    "add_dive": "Add Dive",
    "dive_number": "Dive #{{number}}",
    "max_depth": "Max Depth (m)",
    "duration": "Duration (min)",
    "water_temp": "Water Temp (°C)",
    "dive_site": "Dive Site",
    "location": "Location",
    "dive_date": "Date",
    "notes": "Notes",
    "no_dives": "No dive logs yet",
    "start_logging": "Start logging your dives!"
  },
  "emergency": {
    "title": "Emergency Contacts",
    "add_contact": "Add Contact",
    "name": "Name",
    "relationship": "Relationship",
    "phone": "Phone",
    "no_contacts": "No emergency contacts"
  },
  "common": {
    "save": "Save",
    "cancel": "Cancel",
    "delete": "Delete",
    "edit": "Edit",
    "close": "Close"
  }
}
```

**Update pubspec.yaml:**
```yaml
flutter:
  assets:
    - assets/divercity_theme.json
    - assets/translations/
```

---

### Task 1.4: Create Theme System
**Files to create:**
- `lib/core/theme/theme_loader.dart` (load from JSON)
- `lib/core/theme/app_theme.dart` (constants and custom colors)

**Implementation:**
- Load theme from `assets/divercity_theme.json`
- Define ocean-inspired gradients and colors
- Create consistent spacing and border radius constants

---

## Phase 2: Mock Data Layer (~20 minutes)

### Task 2.1: Create Simple Models
**Files to create:**
- `lib/models/diver.dart`
- `lib/models/dive_log.dart`
- `lib/models/emergency_contact.dart`

**Use simple classes (NOT Freezed for now):**

**Example - `lib/models/diver.dart`:**
```dart
class Diver {
  final String id;
  final String firstname;
  final String lastname;
  final String? email;
  final String? phone;
  final int diveCount;
  final DateTime? joinedAt;

  Diver({
    required this.id,
    required this.firstname,
    required this.lastname,
    this.email,
    this.phone,
    this.diveCount = 0,
    this.joinedAt,
  });

  String get fullName => '$firstname $lastname';

  Diver copyWith({
    String? id,
    String? firstname,
    String? lastname,
    String? email,
    String? phone,
    int? diveCount,
    DateTime? joinedAt,
  }) {
    return Diver(
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      diveCount: diveCount ?? this.diveCount,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }
}
```

**Example - `lib/models/dive_log.dart`:**
```dart
class DiveLog {
  final String id;
  final String diveSite;
  final String location;
  final DateTime diveDate;
  final double maxDepth;
  final int duration;
  final double? waterTemperature;
  final String? notes;

  DiveLog({
    required this.id,
    required this.diveSite,
    required this.location,
    required this.diveDate,
    required this.maxDepth,
    required this.duration,
    this.waterTemperature,
    this.notes,
  });

  DiveLog copyWith({
    String? id,
    String? diveSite,
    String? location,
    DateTime? diveDate,
    double? maxDepth,
    int? duration,
    double? waterTemperature,
    String? notes,
  }) {
    return DiveLog(
      id: id ?? this.id,
      diveSite: diveSite ?? this.diveSite,
      location: location ?? this.location,
      diveDate: diveDate ?? this.diveDate,
      maxDepth: maxDepth ?? this.maxDepth,
      duration: duration ?? this.duration,
      waterTemperature: waterTemperature ?? this.waterTemperature,
      notes: notes ?? this.notes,
    );
  }
}
```

**Example - `lib/models/emergency_contact.dart`:**
```dart
class EmergencyContact {
  final String id;
  final String name;
  final String relationship;
  final String phone;
  final String? email;

  EmergencyContact({
    required this.id,
    required this.name,
    required this.relationship,
    required this.phone,
    this.email,
  });

  EmergencyContact copyWith({
    String? id,
    String? name,
    String? relationship,
    String? phone,
    String? email,
  }) {
    return EmergencyContact(
      id: id ?? this.id,
      name: name ?? this.name,
      relationship: relationship ?? this.relationship,
      phone: phone ?? this.phone,
      email: email ?? this.email,
    );
  }
}
```

---

### Task 2.2: Create Mock Data
**Files to create:**
- `lib/data/mock/mock_divers.dart`
- `lib/data/mock/mock_dive_logs.dart`
- `lib/data/mock/mock_emergency_contacts.dart`

**Example - `lib/data/mock/mock_dive_logs.dart`:**
```dart
import 'package:uuid/uuid.dart';
import '../../models/dive_log.dart';

class MockDiveLogs {
  static final List<DiveLog> diveLogs = [
    DiveLog(
      id: const Uuid().v4(),
      diveSite: 'Blue Hole',
      location: 'Dahab, Egypt',
      diveDate: DateTime(2024, 11, 15, 10, 30),
      maxDepth: 28.5,
      duration: 45,
      waterTemperature: 24.0,
      notes: 'Amazing visibility! Saw a large grouper.',
    ),
    DiveLog(
      id: const Uuid().v4(),
      diveSite: 'The Bells',
      location: 'Dahab, Egypt',
      diveDate: DateTime(2024, 11, 16, 14, 00),
      maxDepth: 26.0,
      duration: 42,
      waterTemperature: 23.5,
      notes: 'Strong current at depth. Beautiful coral formations.',
    ),
    DiveLog(
      id: const Uuid().v4(),
      diveSite: 'Canyon',
      location: 'Dahab, Egypt',
      diveDate: DateTime(2024, 11, 17, 11, 15),
      maxDepth: 30.0,
      duration: 38,
      waterTemperature: 24.5,
      notes: 'Narrow passages, thrilling dive!',
    ),
    // Add 5-10 more mock dives for a realistic demo
  ];
}
```

---

### Task 2.3: Create Riverpod Providers
**Files to create:**
- `lib/providers/diver_provider.dart`
- `lib/providers/dive_log_provider.dart`
- `lib/providers/emergency_contacts_provider.dart`

**Example - `lib/providers/dive_log_provider.dart`:**
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/dive_log.dart';
import '../data/mock/mock_dive_logs.dart';
import 'package:uuid/uuid.dart';

class DiveLogNotifier extends StateNotifier<List<DiveLog>> {
  DiveLogNotifier() : super(MockDiveLogs.diveLogs);

  void addDiveLog(DiveLog diveLog) {
    state = [...state, diveLog];
  }

  void updateDiveLog(DiveLog updatedLog) {
    state = [
      for (final log in state)
        if (log.id == updatedLog.id) updatedLog else log
    ];
  }

  void deleteDiveLog(String id) {
    state = state.where((log) => log.id != id).toList();
  }
}

final diveLogProvider = StateNotifierProvider<DiveLogNotifier, List<DiveLog>>(
  (ref) => DiveLogNotifier(),
);
```

---

## Phase 3: Navigation Setup (~15 minutes)

### Task 3.1: Set Up GoRouter
**File to create:** `lib/core/routing/app_router.dart`

**Routes to implement:**
1. `/` - Splash/Home screen
2. `/home` - Main dashboard
3. `/dive-logs` - List of dive logs
4. `/dive-logs/:id` - Dive log details
5. `/dive-logs/add` - Add new dive
6. `/profile` - User profile
7. `/emergency-contacts` - Emergency contacts list

**Example implementation:**
```dart
import 'package:go_router/go_router.dart';
import '../../screens/splash_screen.dart';
import '../../screens/home_screen.dart';
import '../../screens/dive_logs_screen.dart';
import '../../screens/dive_log_detail_screen.dart';
import '../../screens/add_dive_screen.dart';
import '../../screens/profile_screen.dart';
import '../../screens/emergency_contacts_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/dive-logs',
      builder: (context, state) => const DiveLogsScreen(),
    ),
    GoRoute(
      path: '/dive-logs/add',
      builder: (context, state) => const AddDiveScreen(),
    ),
    GoRoute(
      path: '/dive-logs/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return DiveLogDetailScreen(diveLogId: id);
      },
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/emergency-contacts',
      builder: (context, state) => const EmergencyContactsScreen(),
    ),
  ],
);
```

---

### Task 3.2: Update main.dart
**File to modify:** [lib/main.dart](lib/main.dart)

**Implementation:**
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'core/theme/theme_loader.dart';
import 'core/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  final theme = await ThemeLoader.loadTheme();
  final darkTheme = ThemeLoader.createDarkTheme(theme);

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
    return MaterialApp.router(
      title: 'DiverCity',
      theme: ThemeLoader.customizeTheme(theme),
      darkTheme: ThemeLoader.customizeTheme(darkTheme),
      themeMode: ThemeMode.system,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
```

---

## Phase 4: UI Implementation (~2-3 hours)

### Task 4.1: Create Shared Widgets
**Files to create:**
- `lib/widgets/ocean_background.dart` - Gradient background widget
- `lib/widgets/dive_card.dart` - Card to display dive summary
- `lib/widgets/custom_button.dart` - Ocean-themed button
- `lib/widgets/custom_app_bar.dart` - Custom app bar with ocean styling

**Focus on:**
- Ocean-inspired gradients
- Fluid animations
- Distinctive design (NOT generic Material)
- Proper use of theme colors

---

### Task 4.2: Implement Splash/Home Screen
**File to create:** `lib/screens/splash_screen.dart`

**Features:**
- Ocean gradient background
- App logo/name with animation
- Auto-navigate to home after 2 seconds
- Optional: Animated waves or bubbles

**File to create:** `lib/screens/home_screen.dart`

**Features:**
- Dashboard with stats (total dives, recent dives)
- Quick access cards to main sections
- Ocean-themed design
- Bottom navigation or drawer

---

### Task 4.3: Implement Dive Logs Screen
**File to create:** `lib/screens/dive_logs_screen.dart`

**Features:**
- List of dive logs using `dive_card.dart`
- Pull to refresh
- Floating action button to add new dive
- Show empty state if no dives
- Search/filter options (visual only for mockup)

**File to create:** `lib/screens/dive_log_detail_screen.dart`

**Features:**
- Display all dive details
- Edit/Delete buttons
- Visual representation of depth/duration
- Notes section
- Back navigation

**File to create:** `lib/screens/add_dive_screen.dart`

**Features:**
- Form to add new dive
- Date picker
- Number inputs for depth/duration/temperature
- Text inputs for location/notes
- Save button (adds to provider)
- Form validation

---

### Task 4.4: Implement Profile Screen
**File to create:** `lib/screens/profile_screen.dart`

**Features:**
- Display mock user info
- Profile picture (placeholder)
- Dive statistics
- Edit profile button (can be non-functional for mockup)
- Settings options

---

### Task 4.5: Implement Emergency Contacts Screen
**File to create:** `lib/screens/emergency_contacts_screen.dart`

**Features:**
- List of emergency contacts
- Add contact button
- Contact cards with name, relationship, phone
- Call/message buttons (visual only)

---

## Phase 5: Polish & Animations (~1 hour)

### Task 5.1: Add Ocean-Inspired Animations
- Hero animations between screens
- Fluid page transitions
- Animated list items (staggered fade-in)
- Floating action button animation
- Wave animations on backgrounds

### Task 5.2: Improve Visual Design
- Custom fonts (find distinctive dive-themed font)
- Custom iconography
- Gradient overlays
- Depth-based color schemes
- Consistent spacing and padding

### Task 5.3: Add Responsive Layout
- Handle different screen sizes
- Tablet-friendly layouts
- Landscape orientation support

---

## Phase 6: Optional Enhancements

### Task 6.1: Local Persistence (Optional)
- Save mock data to `shared_preferences`
- Persist user changes across app restarts
- Simple serialization/deserialization

### Task 6.2: Interactive Features
- Mark dives as favorite
- Sort/filter dive logs
- Search functionality
- Statistics charts (simple bar/line charts)

---

## Success Criteria for Mockup

✅ **App runs without errors** on iOS/Android/Web
✅ **Navigation works** - can move between all screens
✅ **Ocean-inspired design** - distinctive visual identity
✅ **Interactive mockup** - can add/edit/delete dive logs
✅ **Smooth animations** - fluid transitions and effects
✅ **Responsive UI** - works on different screen sizes
✅ **Demo-ready** - looks professional and polished

---

## What's Deferred to Phase 2 (Backend Integration)

The following will be implemented AFTER mockup approval:
- [ ] Backend API integration with Dio
- [ ] Authentication flow (login/signup)
- [ ] Data persistence with Hive/SQLite
- [ ] Offline-first architecture
- [ ] Background sync
- [ ] Image upload for dive photos
- [ ] Real user management
- [ ] Production error handling
- [ ] Unit/widget/integration tests

---

## Estimated Timeline

| Phase | Time | Status |
|-------|------|--------|
| Phase 1: Foundation | ~30 min | Pending |
| Phase 2: Mock Data | ~20 min | Pending |
| Phase 3: Navigation | ~15 min | Pending |
| Phase 4: UI Implementation | ~2-3 hours | Pending |
| Phase 5: Polish | ~1 hour | Pending |
| Phase 6: Optional | ~30 min | Optional |
| **Total** | **~4-5 hours** | |

---

## Critical Files to Implement

**Priority Order:**
1. `pubspec.yaml` - Dependencies
2. `assets/translations/en.json` - Translations
3. `lib/models/*.dart` - Data models
4. `lib/data/mock/*.dart` - Mock data
5. `lib/core/theme/theme_loader.dart` - Theme system
6. `lib/core/routing/app_router.dart` - Navigation
7. `lib/providers/*.dart` - State management
8. `lib/main.dart` - App entry point
9. `lib/screens/*.dart` - UI screens
10. `lib/widgets/*.dart` - Shared widgets

---

## Notes

- **This is a prototype/mockup** - focus is on UI/UX, not production architecture
- **Mock data is ephemeral** (or persisted in shared_preferences if implemented)
- **No authentication** required for mockup
- **Backend integration** will follow clean architecture in Phase 2
- **Design exploration** - try different ocean themes and find what works best

---

## Next Steps

1. **Review this plan** - does this approach make sense?
2. **Start implementation** - begin with Phase 1
3. **Iterate on design** - adjust ocean theme based on visual results
4. **Demo and gather feedback** - show mockup to stakeholders
5. **Plan Phase 2** - backend integration after mockup approval
