import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/ocean_background.dart';
import '../widgets/dive_card.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/animated_list_item.dart';
import '../widgets/animated_fab.dart';
import '../features/dive_logs/presentation/providers/dive_log_provider.dart';
import '../features/diver_profile/presentation/providers/diver_provider.dart';
import '../features/emergency_contacts/presentation/providers/emergency_contacts_provider.dart';

/// Home screen - Main dashboard with stats and navigation
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diverState = ref.watch(diverProvider);
    final allDives = ref.watch(diveLogProvider);
    final recentDives = ref.watch(recentDivesProvider);
    final emergencyContacts = ref.watch(emergencyContactsProvider);

    // Show loading if diver profile is loading
    if (diverState.isLoading && diverState.diver == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final diver = diverState.diver;

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
                  'Welcome back, ${diver?.firstname ?? "Diver"}!',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Ready for your next adventure?',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white70,
                      ),
                ),
                const SizedBox(height: 24),

                // Stats cards
                Row(
                  children: [
                    Expanded(
                      child: _StatsCard(
                        icon: Icons.scuba_diving,
                        value: '${allDives.length}',
                        label: 'Total Dives',
                        onTap: () => context.go('/dive-logs'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatsCard(
                        icon: Icons.contact_emergency,
                        value: '${emergencyContacts.length}',
                        label: 'Contacts',
                        onTap: () => context.go('/emergency-contacts'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Quick actions
                Text(
                  'Quick Actions',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: _QuickActionCard(
                        icon: Icons.list_alt,
                        title: 'Dive Logs',
                        subtitle: '${allDives.length} dives',
                        onTap: () => context.go('/dive-logs'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _QuickActionCard(
                        icon: Icons.person,
                        title: 'Profile',
                        subtitle: diver?.fullName ?? 'View Profile',
                        onTap: () => context.go('/profile'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Recent dives section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Dives',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    TextButton(
                      onPressed: () => context.go('/dive-logs'),
                      child: Text(
                        'View All',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Display recent dives using DiveCard widget
                if (recentDives.isEmpty)
                  Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 32),
                        Icon(
                          Icons.waves,
                          size: 64,
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No dives yet',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.white70,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Start logging your dives!',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.white60,
                              ),
                        ),
                      ],
                    ),
                  )
                else
                  ...recentDives.asMap().entries.map(
                    (entry) {
                      final index = entry.key;
                      final dive = entry.value;
                      return AnimatedListItem(
                        index: index,
                        child: DiveCard(
                          dive: dive,
                          onTap: () => context.go('/dive-logs/${dive.id}'),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: AnimatedOceanFAB(
        onPressed: () => context.go('/dive-logs/add'),
        icon: Icons.add,
        label: 'Add Dive',
      ),
    );
  }
}

/// Stats card widget for displaying key metrics
class _StatsCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final VoidCallback? onTap;

  const _StatsCard({
    required this.icon,
    required this.value,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1A3A52),
                Color(0xFF2C5F7C),
              ],
            ),
          ),
          child: Column(
            children: [
              Icon(icon, size: 32, color: Colors.white),
              const SizedBox(height: 8),
              Text(
                value,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white70,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Quick action card for navigation
class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFE3F2FD),
                Color(0xFFBBDEFB),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 32, color: const Color(0xFF0077BE)),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black54,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
