import 'package:flutter/material.dart';

/// Dive log detail screen placeholder - will be implemented in Phase 7
class DiveLogDetailScreen extends StatelessWidget {
  final String diveLogId;

  const DiveLogDetailScreen({
    super.key,
    required this.diveLogId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dive Log Detail'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.info_outline, size: 64),
            const SizedBox(height: 16),
            const Text(
              'Dive Log Detail Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Dive ID: $diveLogId'),
            const SizedBox(height: 8),
            const Text('Coming soon...'),
          ],
        ),
      ),
    );
  }
}
