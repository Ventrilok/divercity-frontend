import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/ocean_background.dart';
import '../widgets/dive_card.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_app_bar.dart';
import '../providers/dive_log_provider.dart';
import '../providers/diver_provider.dart';

/// Home screen with ocean-themed widgets demo
/// Full implementation in Phase 5
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diver = ref.watch(diverProvider);
    final recentDives = ref.watch(recentDivesProvider);

    return Scaffold(
      appBar: const OceanAppBar(
        title: 'DiverCity',
      ),
      body: OceanBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome section
                Text(
                  'Welcome back, ${diver.firstname}!',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'You have ${diver.diveCount} logged dives',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white70,
                      ),
                ),
                const SizedBox(height: 24),

                // Recent dives section
                Text(
                  'Recent Dives',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),

                // Display recent dives using DiveCard widget
                ...recentDives.map(
                  (dive) => DiveCard(
                    dive: dive,
                    onTap: () {
                      // Navigation will be added in Phase 7
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // Demo buttons
                Center(
                  child: Column(
                    children: [
                      OceanButton(
                        text: 'View All Dives',
                        icon: Icons.list,
                        onPressed: () {},
                      ),
                      const SizedBox(height: 12),
                      OceanButton(
                        text: 'Add Dive',
                        icon: Icons.add,
                        onPressed: () {},
                        isOutlined: true,
                      ),
                      const SizedBox(height: 12),
                      OceanButtonSmall(
                        text: 'Profile',
                        icon: Icons.person,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
