import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../screens/home_screen.dart';
import '../../screens/dive_logs_screen.dart';
import '../../screens/dive_log_detail_screen.dart';
import '../../screens/add_dive_screen.dart';
import '../../screens/profile_screen.dart';
import '../../screens/emergency_contacts_screen.dart';

/// GoRouter configuration for the app
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // Splash screen
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),

    // Home screen
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),

    // Dive logs list
    GoRoute(
      path: '/dive-logs',
      name: 'dive-logs',
      builder: (context, state) => const DiveLogsScreen(),
    ),

    // Add new dive
    GoRoute(
      path: '/dive-logs/add',
      name: 'add-dive',
      builder: (context, state) => const AddDiveScreen(),
    ),

    // Dive log detail
    GoRoute(
      path: '/dive-logs/:id',
      name: 'dive-log-detail',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return DiveLogDetailScreen(diveLogId: id);
      },
    ),

    // Edit dive (reuses AddDiveScreen with ID)
    GoRoute(
      path: '/dive-logs/:id/edit',
      name: 'edit-dive',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return AddDiveScreen(diveLogId: id);
      },
    ),

    // Profile screen
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => const ProfileScreen(),
    ),

    // Emergency contacts screen
    GoRoute(
      path: '/emergency-contacts',
      name: 'emergency-contacts',
      builder: (context, state) => const EmergencyContactsScreen(),
    ),
  ],

  // Error page
  errorBuilder: (context, state) => const Scaffold(
    body: Center(
      child: Text('Page not found'),
    ),
  ),
);
