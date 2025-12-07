import 'package:flutter/material.dart';
import '../features/dive_logs/data/models/dive_log.dart';

/// Card widget to display a dive log summary
/// Designed with ocean-inspired styling
class DiveCard extends StatelessWidget {
  final DiveLog dive;
  final VoidCallback? onTap;
  final bool showDetails;

  const DiveCard({
    super.key,
    required this.dive,
    this.onTap,
    this.showDetails = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Hero(
      tag: 'dive-${dive.id}',
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [
                      const Color(0xFF1A3A52),
                      const Color(0xFF2C5F7C),
                    ]
                  : [
                      const Color(0xFFE3F2FD),
                      const Color(0xFFBBDEFB),
                    ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Site name and location
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: theme.colorScheme.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dive.diveSite,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          Text(
                            dive.location,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                if (showDetails) ...[
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 12),

                  // Dive stats
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatColumn(
                        context,
                        Icons.arrow_downward,
                        dive.formattedDepth,
                        'Depth',
                        isDark,
                      ),
                      _buildStatColumn(
                        context,
                        Icons.timer,
                        dive.formattedDuration,
                        'Duration',
                        isDark,
                      ),
                      if (dive.waterTemperature != null)
                        _buildStatColumn(
                          context,
                          Icons.thermostat,
                          dive.formattedWaterTemp!,
                          'Temp',
                          isDark,
                        ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Date
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: isDark ? Colors.white60 : Colors.black45,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        dive.formattedDate,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isDark ? Colors.white60 : Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }

  Widget _buildStatColumn(
    BuildContext context,
    IconData icon,
    String value,
    String label,
    bool isDark,
  ) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Icon(
          icon,
          color: theme.colorScheme.primary,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: isDark ? Colors.white60 : Colors.black54,
          ),
        ),
      ],
    );
  }
}

/// Compact version of dive card for lists
class CompactDiveCard extends StatelessWidget {
  final DiveLog dive;
  final VoidCallback? onTap;

  const CompactDiveCard({
    super.key,
    required this.dive,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return DiveCard(
      dive: dive,
      onTap: onTap,
      showDetails: false,
    );
  }
}
