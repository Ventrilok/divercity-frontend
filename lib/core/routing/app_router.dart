import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../screens/home_screen.dart';
import '../../screens/dive_logs_screen.dart';
import '../../screens/dive_log_detail_screen.dart';
import '../../screens/add_dive_screen.dart';
import '../../screens/profile_screen.dart';
import '../../screens/emergency_contacts_screen.dart';

/// Custom page transition with fade and slide effect
Page<dynamic> _buildPageWithTransition(
  BuildContext context,
  GoRouterState state,
  Widget child,
) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 0.03);
      const end = Offset.zero;
      const curve = Curves.easeInOutCubic;

      var tween = Tween(begin: begin, end: end).chain(
        CurveTween(curve: curve),
      );

      var offsetAnimation = animation.drive(tween);
      var fadeAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeIn,
      );

      return SlideTransition(
        position: offsetAnimation,
        child: FadeTransition(
          opacity: fadeAnimation,
          child: child,
        ),
      );
    },
  );
}

/// GoRouter configuration for the app
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // Splash screen (no transition)
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),

    // Home screen
    GoRoute(
      path: '/home',
      name: 'home',
      pageBuilder: (context, state) => _buildPageWithTransition(
        context,
        state,
        const HomeScreen(),
      ),
    ),

    // Dive logs list
    GoRoute(
      path: '/dive-logs',
      name: 'dive-logs',
      pageBuilder: (context, state) => _buildPageWithTransition(
        context,
        state,
        const DiveLogsScreen(),
      ),
    ),

    // Add new dive
    GoRoute(
      path: '/dive-logs/add',
      name: 'add-dive',
      pageBuilder: (context, state) => _buildPageWithTransition(
        context,
        state,
        const AddDiveScreen(),
      ),
    ),

    // Dive log detail
    GoRoute(
      path: '/dive-logs/:id',
      name: 'dive-log-detail',
      pageBuilder: (context, state) {
        final id = state.pathParameters['id']!;
        return _buildPageWithTransition(
          context,
          state,
          DiveLogDetailScreen(diveLogId: id),
        );
      },
    ),

    // Edit dive (reuses AddDiveScreen with ID)
    GoRoute(
      path: '/dive-logs/:id/edit',
      name: 'edit-dive',
      pageBuilder: (context, state) {
        final id = state.pathParameters['id']!;
        return _buildPageWithTransition(
          context,
          state,
          AddDiveScreen(diveLogId: id),
        );
      },
    ),

    // Profile screen
    GoRoute(
      path: '/profile',
      name: 'profile',
      pageBuilder: (context, state) => _buildPageWithTransition(
        context,
        state,
        const ProfileScreen(),
      ),
    ),

    // Emergency contacts screen
    GoRoute(
      path: '/emergency-contacts',
      name: 'emergency-contacts',
      pageBuilder: (context, state) => _buildPageWithTransition(
        context,
        state,
        const EmergencyContactsScreen(),
      ),
    ),
  ],

  // Error page
  errorBuilder: (context, state) => const Scaffold(
    body: Center(
      child: Text('Page not found'),
    ),
  ),
);
