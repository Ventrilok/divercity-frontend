import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'core/theme/theme_loader.dart';
import 'core/di/injection.dart';
import 'core/utils/logger.dart';
import 'core/routing/app_router.dart';

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
          child: MyApp(theme: theme, darkTheme: darkTheme),
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

  const MyApp({super.key, required this.theme, required this.darkTheme});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'DiverCity',

      // Theme
      theme: ThemeLoader.customizeTheme(theme),
      darkTheme: ThemeLoader.customizeTheme(darkTheme),
      themeMode: ThemeMode.system,

      // Localization
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      // Routing with GoRouter
      routerConfig: appRouter,

      // Debug
      debugShowCheckedModeBanner: false,
    );
  }
}
