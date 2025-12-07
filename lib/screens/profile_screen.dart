import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../widgets/ocean_background.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/simple_bar_chart.dart';
import '../models/dive_log.dart';
import '../providers/diver_provider.dart';
import '../providers/dive_log_provider.dart';

/// Profile screen - displays user information and dive statistics
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diver = ref.watch(diverProvider);
    final allDives = ref.watch(diveLogProvider);

    // Calculate statistics
    final totalDives = allDives.length;
    final totalDepth = allDives.fold<double>(
      0,
      (sum, dive) => sum + dive.maxDepth,
    );
    final avgDepth = totalDives > 0 ? totalDepth / totalDives : 0.0;

    final totalDuration = allDives.fold<int>(
      0,
      (sum, dive) => sum + dive.duration,
    );
    final avgDuration = totalDives > 0 ? totalDuration / totalDives : 0.0;

    final maxDepth = allDives.isEmpty
        ? 0.0
        : allDives.map((d) => d.maxDepth).reduce((a, b) => a > b ? a : b);

    final longestDive = allDives.isEmpty
        ? 0
        : allDives.map((d) => d.duration).reduce((a, b) => a > b ? a : b);

    final dateFormat = DateFormat('MMMM d, yyyy');

    return Scaffold(
      appBar: const OceanAppBar(title: 'Profile'),
      body: OceanBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Profile Header Card
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF0077BE),
                          Color(0xFF00A8E8),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        // Avatar
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.white,
                              width: 4,
                            ),
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 60,
                            color: Color(0xFF0077BE),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Name
                        Text(
                          diver.fullName,
                          style:
                              Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 8),

                        // Email
                        if (diver.email != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.email, color: Colors.white70, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                diver.email!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Colors.white70,
                                    ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 4),

                        // Phone
                        if (diver.phone != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.phone, color: Colors.white70, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                diver.phone!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Colors.white70,
                                    ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 16),

                        // Member since
                        if (diver.joinedAt != null)
                          Text(
                            'Member since ${dateFormat.format(diver.joinedAt!)}',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.white60,
                                    ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Statistics Section
                Text(
                  'Diving Statistics',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),

                // Total Dives & Total Time
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        icon: Icons.scuba_diving,
                        label: 'Total Dives',
                        value: '$totalDives',
                        color: const Color(0xFF00A8E8),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        icon: Icons.access_time,
                        label: 'Total Time',
                        value: '$totalDuration min',
                        color: const Color(0xFF0077BE),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Average Depth & Max Depth
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        icon: Icons.trending_down,
                        label: 'Avg Depth',
                        value: '${avgDepth.toStringAsFixed(1)}m',
                        color: const Color(0xFF5FC3E4),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        icon: Icons.arrow_downward,
                        label: 'Max Depth',
                        value: '${maxDepth.toStringAsFixed(1)}m',
                        color: const Color(0xFF003F5C),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Average Duration & Longest Dive
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        icon: Icons.timer_outlined,
                        label: 'Avg Duration',
                        value: '${avgDuration.toStringAsFixed(0)} min',
                        color: const Color(0xFF58A6D6),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        icon: Icons.timer,
                        label: 'Longest Dive',
                        value: '$longestDive min',
                        color: const Color(0xFF2E7D9A),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Monthly Dive Chart
                if (allDives.isNotEmpty) ...[
                  Text(
                    'Monthly Activity',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  _buildMonthlyDiveChart(allDives),
                  const SizedBox(height: 24),
                ],

                // Settings Section
                Text(
                  'Settings',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),

                _SettingsCard(
                  children: [
                    _SettingsItem(
                      icon: Icons.edit,
                      title: 'Edit Profile',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Edit profile - Coming soon!'),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1),
                    _SettingsItem(
                      icon: Icons.notifications,
                      title: 'Notifications',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Notifications - Coming soon!'),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1),
                    _SettingsItem(
                      icon: Icons.language,
                      title: 'Language',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Language settings - Coming soon!'),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1),
                    _SettingsItem(
                      icon: Icons.dark_mode,
                      title: 'Theme',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Theme settings - Coming soon!'),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1),
                    _SettingsItem(
                      icon: Icons.info,
                      title: 'About',
                      onTap: () {
                        showAboutDialog(
                          context: context,
                          applicationName: 'DiverCity',
                          applicationVersion: '1.0.0',
                          applicationLegalese: '© 2024 DiverCity',
                          children: [
                            const SizedBox(height: 16),
                            const Text('Your dive companion for tracking and managing your underwater adventures.'),
                          ],
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Build monthly dive activity chart
  Widget _buildMonthlyDiveChart(List<DiveLog> dives) {
    // Get last 6 months
    final now = DateTime.now();
    final monthlyData = <ChartData>[];

    for (int i = 5; i >= 0; i--) {
      final month = DateTime(now.year, now.month - i, 1);
      final monthName = DateFormat('MMM').format(month);

      final count = dives.where((dive) {
        return dive.diveDate.year == month.year &&
            dive.diveDate.month == month.month;
      }).length;

      monthlyData.add(ChartData(
        label: monthName,
        value: count.toDouble(),
        color: const Color(0xFF00A8E8),
      ));
    }

    return SimpleBarChart(
      title: 'Dives per Month (Last 6 Months)',
      data: monthlyData,
      height: 180,
    );
  }
}

/// Stat card widget for displaying statistics
class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withValues(alpha: 0.2),
              color.withValues(alpha: 0.05),
            ],
          ),
        ),
        child: Column(
          children: [
            Icon(icon, size: 28, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.black54,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Settings card container
class _SettingsCard extends StatelessWidget {
  final List<Widget> children;

  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: children,
      ),
    );
  }
}

/// Settings item widget
class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _SettingsItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF0077BE)),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
