# DiverCity - Revised Implementation Plan

**Based on:** plan2.md + Current project state
**Goal:** Working mockup with ocean-inspired design
**Constraint:** App must run without errors after each task

---

## Current Status Summary

✅ **COMPLETED:**
- All dependencies installed (pubspec.yaml)
- Theme system (theme_loader.dart, app_theme.dart)
- Translation files (en, es, fr, ar)
- Dependency injection (Hive, secure storage)
- Logger utility
- Basic splash page
- Core folder structure

❌ **NOT STARTED:**
- Models (simple classes for mockup)
- Mock data layer
- Riverpod providers
- GoRouter configuration
- Main UI screens (home, dive logs, profile, emergency contacts)
- Shared widgets (ocean-themed components)

---

## Revised Phase Plan

### ✅ Phase 1: Foundation (COMPLETE)
**Status:** Already done
**Verification:** `flutter analyze` passes ✅

---

### Phase 2: Data Layer (Mockup Version)
**Goal:** Create data models, mock data, and state providers
**Estimated time:** ~1 hour

#### Task 2.1: Create Simple Models
**Time:** 20 minutes
**Files to create:**
1. `lib/models/diver.dart` - Simple class with copyWith
2. `lib/models/dive_log.dart` - Simple class with copyWith
3. `lib/models/emergency_contact.dart` - Simple class with copyWith

**Success criteria:**
- Models compile without errors
- Each has required fields and copyWith method
- No dependencies on Freezed (use simple Dart classes)

**Test after task:**
```bash
flutter analyze  # Should pass
flutter run      # Should still show splash without errors
```

---

#### Task 2.2: Create Mock Data
**Time:** 20 minutes
**Files to create:**
1. `lib/data/mock/mock_divers.dart` - 1 mock diver
2. `lib/data/mock/mock_dive_logs.dart` - 5-10 mock dives
3. `lib/data/mock/mock_emergency_contacts.dart` - 2-3 mock contacts

**Success criteria:**
- Mock data files compile
- Static lists of mock objects ready to use
- Realistic dive data (real locations, reasonable depths/durations)

**Test after task:**
```bash
flutter analyze  # Should pass
flutter run      # Should still show splash without errors
```

---

#### Task 2.3: Create Riverpod Providers
**Time:** 20 minutes
**Files to create:**
1. `lib/providers/diver_provider.dart` - StateNotifierProvider for diver
2. `lib/providers/dive_log_provider.dart` - StateNotifierProvider for dive logs
3. `lib/providers/emergency_contacts_provider.dart` - StateNotifierProvider for contacts

**Success criteria:**
- Providers implement CRUD operations (add, update, delete)
- Initialized with mock data
- Compile without errors

**Test after task:**
```bash
flutter analyze  # Should pass
flutter run      # Should still show splash without errors
```

**Commit checkpoint:** "feat: add data models, mock data, and Riverpod providers"

---

### Phase 3: Navigation Setup
**Goal:** Set up routing so we can navigate between screens
**Estimated time:** 30 minutes

#### Task 3.1: Create Screen Placeholders
**Time:** 10 minutes
**Files to create:**
1. `lib/screens/home_screen.dart` - Simple placeholder with Text
2. `lib/screens/dive_logs_screen.dart` - Simple placeholder
3. `lib/screens/dive_log_detail_screen.dart` - Simple placeholder
4. `lib/screens/add_dive_screen.dart` - Simple placeholder
5. `lib/screens/profile_screen.dart` - Simple placeholder
6. `lib/screens/emergency_contacts_screen.dart` - Simple placeholder

**Each screen template:**
```dart
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text('Home Screen - Coming Soon')),
    );
  }
}
```

**Success criteria:**
- All screen files compile
- No dependencies yet (just basic scaffolds)

---

#### Task 3.2: Set Up GoRouter
**Time:** 15 minutes
**File to create:**
- `lib/core/routing/app_router.dart`

**Routes to implement:**
- `/` → SplashPage (redirect to /home after init)
- `/home` → HomeScreen
- `/dive-logs` → DiveLogsScreen
- `/dive-logs/:id` → DiveLogDetailScreen
- `/dive-logs/add` → AddDiveScreen
- `/profile` → ProfileScreen
- `/emergency-contacts` → EmergencyContactsScreen

**Success criteria:**
- Router compiles
- All routes defined

---

#### Task 3.3: Update main.dart to Use Router
**Time:** 5 minutes
**File to modify:**
- `lib/main.dart`

**Changes:**
- Replace `MaterialApp` with `MaterialApp.router`
- Add `routerConfig: appRouter`
- Remove `home: const SplashPage()`

**Success criteria:**
- App compiles
- App navigates from splash to home

---

#### Task 3.4: Update Splash to Auto-Navigate
**Time:** 5 minutes
**File to modify:**
- `lib/features/auth/presentation/pages/splash_page.dart`

**Changes:**
- Add 2-second delay
- Navigate to `/home` using `context.go('/home')`

**Test after task:**
```bash
flutter run
# Expected: App shows splash for 2 seconds, then navigates to home screen
# Verify: No errors, smooth transition
```

**Commit checkpoint:** "feat: add GoRouter navigation with screen placeholders"

---

### Phase 4: Shared Widgets
**Goal:** Create reusable ocean-themed components
**Estimated time:** 45 minutes

#### Task 4.1: Create Ocean Background Widget
**Time:** 15 minutes
**File to create:**
- `lib/widgets/ocean_background.dart`

**Features:**
- Ocean gradient (deep blue → light teal)
- Optional wave animation
- Wraps child content

**Test after task:**
Update home_screen.dart to use OceanBackground, verify gradient appears

---

#### Task 4.2: Create Dive Card Widget
**Time:** 15 minutes
**File to create:**
- `lib/widgets/dive_card.dart`

**Features:**
- Display dive site, location, date
- Show depth, duration, temperature
- Tappable with onTap callback
- Ocean-themed styling

**Test after task:**
Create test in home screen with sample dive, verify card renders

---

#### Task 4.3: Create Custom Button
**Time:** 10 minutes
**File to create:**
- `lib/widgets/custom_button.dart`

**Features:**
- Ocean-themed styling
- Support for icon + text
- Disabled state
- Loading state

**Test after task:**
Add button to home screen, verify styling

---

#### Task 4.4: Create Custom App Bar
**Time:** 5 minutes
**File to create:**
- `lib/widgets/custom_app_bar.dart`

**Features:**
- Ocean gradient background
- White text
- Optional actions

**Test after task:**
```bash
flutter run
# Verify all widgets render correctly
```

**Commit checkpoint:** "feat: add ocean-themed shared widgets"

---

### Phase 5: Home Screen Implementation
**Goal:** Build functional home screen with stats and navigation
**Estimated time:** 30 minutes

#### Task 5.1: Implement Home Screen
**Time:** 30 minutes
**File to modify:**
- `lib/screens/home_screen.dart`

**Features:**
- Ocean background
- Welcome message with diver name
- Stats cards (total dives, recent dive)
- Navigation cards to:
  - Dive Logs
  - Profile
  - Emergency Contacts
- Floating action button to add dive

**Data:**
- Use diver_provider for user info
- Use dive_log_provider for stats

**Test after task:**
```bash
flutter run
# Verify:
# - Stats display correctly from mock data
# - Navigation cards navigate to placeholder screens
# - FAB navigates to add dive screen
# - Ocean theme looks good
```

**Commit checkpoint:** "feat: implement home screen with navigation and stats"

---

### Phase 6: Dive Logs List Screen
**Goal:** Display list of dives, add/delete functionality
**Estimated time:** 45 minutes

#### Task 6.1: Implement Dive Logs List
**Time:** 30 minutes
**File to modify:**
- `lib/screens/dive_logs_screen.dart`

**Features:**
- Ocean background
- List of DiveCard widgets
- Pull to refresh (mock)
- Empty state if no dives
- FAB to add dive
- Tap card to view detail

**Data:**
- Use dive_log_provider
- Watch for changes

**Test after task:**
```bash
flutter run
# Verify:
# - Mock dives display in list
# - Tap card navigates to detail (placeholder)
# - FAB navigates to add dive screen
```

---

#### Task 6.2: Implement Add Dive Form
**Time:** 15 minutes
**File to modify:**
- `lib/screens/add_dive_screen.dart`

**Features:**
- Form with fields:
  - Dive site (text)
  - Location (text)
  - Date (date picker)
  - Max depth (number)
  - Duration (number)
  - Water temp (number)
  - Notes (multiline text)
- Save button (adds to provider)
- Cancel button (pops navigation)
- Form validation

**Test after task:**
```bash
flutter run
# Verify:
# - Can add new dive
# - New dive appears in list
# - Form validation works
# - Navigation works
```

**Commit checkpoint:** "feat: implement dive logs list and add dive form"

---

### Phase 7: Dive Log Detail Screen
**Goal:** View and edit individual dive logs
**Estimated time:** 30 minutes

#### Task 7.1: Implement Detail View
**Time:** 20 minutes
**File to modify:**
- `lib/screens/dive_log_detail_screen.dart`

**Features:**
- Display all dive details
- Visual depth/duration indicators
- Edit button (opens add form in edit mode)
- Delete button with confirmation
- Back navigation

**Test after task:**
```bash
flutter run
# Verify:
# - Detail view shows all dive info
# - Edit button works
# - Delete button removes dive and navigates back
```

---

#### Task 7.2: Add Edit Mode to Add Dive Screen
**Time:** 10 minutes
**File to modify:**
- `lib/screens/add_dive_screen.dart`

**Changes:**
- Accept optional diveLogId parameter
- If provided, load dive and pre-fill form
- Update instead of add on save

**Test after task:**
```bash
flutter run
# Verify:
# - Can edit existing dive
# - Changes persist
# - Navigation works
```

**Commit checkpoint:** "feat: implement dive log detail and edit functionality"

---

### Phase 8: Profile Screen
**Goal:** Display user profile
**Estimated time:** 30 minutes

#### Task 8.1: Implement Profile Screen
**Time:** 30 minutes
**File to modify:**
- `lib/screens/profile_screen.dart`

**Features:**
- Ocean background
- Profile picture (placeholder icon)
- User info from diver_provider
- Dive statistics
- Edit button (non-functional for mockup)
- Settings section (visual only)

**Test after task:**
```bash
flutter run
# Verify:
# - Profile displays user info
# - Stats show correct numbers
# - UI looks polished
```

**Commit checkpoint:** "feat: implement profile screen"

---

### Phase 9: Emergency Contacts Screen
**Goal:** Manage emergency contacts
**Estimated time:** 45 minutes

#### Task 9.1: Implement Contacts List
**Time:** 20 minutes
**File to modify:**
- `lib/screens/emergency_contacts_screen.dart`

**Features:**
- List of contact cards
- Add contact FAB
- Empty state
- Contact cards show name, relationship, phone
- Call/message buttons (visual only for mockup)

**Test after task:**
```bash
flutter run
# Verify:
# - Contacts display from mock data
# - Can navigate to add screen
```

---

#### Task 9.2: Add Contact Form (Bonus)
**Time:** 25 minutes
**File to create:**
- `lib/screens/add_emergency_contact_screen.dart`

**Features:**
- Form for contact info
- Save to provider
- Validation

**Test after task:**
```bash
flutter run
# Verify:
# - Can add/edit contacts
# - Changes persist in session
```

**Commit checkpoint:** "feat: implement emergency contacts management"

---

### Phase 10: Polish & Animations
**Goal:** Make it look professional
**Estimated time:** 1 hour

#### Task 10.1: Add Hero Animations
**Time:** 20 minutes
- Hero animation for dive cards
- Smooth transitions

#### Task 10.2: Add Page Transitions
**Time:** 15 minutes
- Custom route transitions
- Fluid page changes

#### Task 10.3: Add Micro-interactions
**Time:** 25 minutes
- Staggered list animations
- FAB rotation
- Ripple effects
- Loading states

**Test after task:**
```bash
flutter run
# Verify smooth animations throughout
```

**Commit checkpoint:** "feat: add animations and polish"

---

## Testing Strategy for Each Task

### Before Every Commit:

```bash
# 1. Analyze
flutter analyze

# 2. Test run
flutter run -d chrome  # or your device

# 3. Manual verification checklist:
# □ App launches without errors
# □ No red error screens
# □ New functionality works
# □ Existing functionality still works
# □ Navigation works
# □ UI renders correctly
# □ No console errors
```

### Key Checkpoints:

| Checkpoint | What Should Work | Commit Message |
|------------|------------------|----------------|
| After Phase 2 | App runs, shows splash → home, has mock data accessible | "feat: add data layer with models and providers" |
| After Phase 3 | Full navigation between all screens works | "feat: add GoRouter navigation" |
| After Phase 5 | Home screen shows stats and navigates | "feat: implement home screen" |
| After Phase 6 | Can view and add dive logs | "feat: implement dive logs" |
| After Phase 7 | Can view/edit/delete dives | "feat: implement dive details" |
| After Phase 8 | Profile screen complete | "feat: implement profile" |
| After Phase 9 | Emergency contacts complete | "feat: implement emergency contacts" |
| After Phase 10 | Polished, animated mockup | "feat: add polish and animations" |

---

## Success Criteria for Mockup

✅ App runs without errors on iOS/Android/Web
✅ Navigation works smoothly between all screens
✅ Ocean-inspired design throughout
✅ Can add/edit/delete dive logs
✅ Can view profile and emergency contacts
✅ Smooth animations and transitions
✅ Looks professional and demo-ready

---

## Estimated Timeline

| Phase | Time | Cumulative |
|-------|------|------------|
| Phase 1 | ✅ Done | 0h |
| Phase 2 | 1h | 1h |
| Phase 3 | 30min | 1.5h |
| Phase 4 | 45min | 2.25h |
| Phase 5 | 30min | 2.75h |
| Phase 6 | 45min | 3.5h |
| Phase 7 | 30min | 4h |
| Phase 8 | 30min | 4.5h |
| Phase 9 | 45min | 5.25h |
| Phase 10 | 1h | 6.25h |
| **Total** | **~6.25 hours** | |

---

## Next Immediate Steps

**To start implementation:**

1. Read this revised plan
2. Confirm approach
3. Start with Phase 2, Task 2.1 (Create Simple Models)
4. Test after each task
5. Commit at each checkpoint
6. Move sequentially through phases

**First session target:** Complete Phases 2-3 (~1.5 hours)
- Result: App with navigation and data layer working

---

## Notes

- This plan leverages existing foundation (theme, DI, translations)
- Each task leaves app in runnable state
- Follows plan2.md philosophy (mockup first)
- Can commit frequently with working code
- Backend integration deferred to future phase
- Simple classes instead of Freezed for speed
- Focus on visual quality and UX

