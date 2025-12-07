import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../widgets/ocean_background.dart';
import '../widgets/custom_app_bar.dart';
import '../features/dive_logs/presentation/providers/dive_log_provider.dart';

/// Dive log detail screen - displays full dive information
class DiveLogDetailScreen extends ConsumerWidget {
  final String diveLogId;

  const DiveLogDetailScreen({
    super.key,
    required this.diveLogId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allDives = ref.watch(diveLogProvider);
    final dive = allDives.firstWhere(
      (d) => d.id == diveLogId,
      orElse: () => throw Exception('Dive not found'),
    );

    final dateFormat = DateFormat('EEEE, MMMM d, yyyy');
    final timeFormat = DateFormat('h:mm a');

    return Scaffold(
      appBar: OceanAppBar(
        title: 'Dive Details',
        actions: [
          IconButton(
            icon: Icon(
              dive.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: dive.isFavorite ? Colors.red : null,
            ),
            onPressed: () {
              ref.read(diveLogProvider.notifier).toggleFavorite(diveLogId);
            },
            tooltip: dive.isFavorite ? 'Remove from favorites' : 'Add to favorites',
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.go('/dive-logs/$diveLogId/edit'),
            tooltip: 'Edit dive',
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _showDeleteDialog(context, ref),
            tooltip: 'Delete dive',
          ),
        ],
      ),
      body: OceanBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dive Site Card
                _InfoCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Color(0xFF00A8E8),
                            size: 32,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dive.diveSite,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  dive.location,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: Colors.black54,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Date and Time Card
                _InfoCard(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        color: Color(0xFF00A8E8),
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dateFormat.format(dive.diveDate),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              timeFormat.format(dive.diveDate),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.black54,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Dive Stats
                Text(
                  'Dive Statistics',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        icon: Icons.arrow_downward,
                        label: 'Max Depth',
                        value: '${dive.maxDepth}m',
                        color: const Color(0xFF0077BE),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        icon: Icons.timer,
                        label: 'Duration',
                        value: '${dive.duration} min',
                        color: const Color(0xFF00A8E8),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                if (dive.waterTemperature != null)
                  _StatCard(
                    icon: Icons.thermostat,
                    label: 'Water Temperature',
                    value: '${dive.waterTemperature}°C',
                    color: const Color(0xFF5FC3E4),
                  ),
                const SizedBox(height: 24),

                // Notes Section
                if (dive.notes != null && dive.notes!.isNotEmpty) ...[
                  Text(
                    'Notes',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  _InfoCard(
                    child: Text(
                      dive.notes!,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Dive'),
        content: const Text(
          'Are you sure you want to delete this dive log? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(diveLogProvider.notifier).deleteDiveLog(diveLogId);
              Navigator.pop(context);
              context.go('/dive-logs');
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

/// Info card widget for displaying dive information
class _InfoCard extends StatelessWidget {
  final Widget child;

  const _InfoCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}

/// Stat card widget for displaying dive statistics
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
              color.withValues(alpha: 0.1),
            ],
          ),
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
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
