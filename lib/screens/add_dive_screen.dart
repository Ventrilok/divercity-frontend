import 'package:flutter/material.dart';

/// Add/Edit dive screen placeholder - will be implemented in Phase 6
class AddDiveScreen extends StatelessWidget {
  final String? diveLogId;

  const AddDiveScreen({
    super.key,
    this.diveLogId,
  });

  bool get isEditMode => diveLogId != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? 'Edit Dive' : 'Add Dive'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.edit_note, size: 64),
            const SizedBox(height: 16),
            Text(
              isEditMode ? 'Edit Dive Screen' : 'Add Dive Screen',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (isEditMode) Text('Editing Dive ID: $diveLogId'),
            const SizedBox(height: 8),
            const Text('Coming soon...'),
          ],
        ),
      ),
    );
  }
}
