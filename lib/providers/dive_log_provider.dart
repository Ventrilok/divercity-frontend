import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/dive_log.dart';
import '../data/mock/mock_dive_logs.dart';
import 'diver_provider.dart';

/// Notifier for managing dive logs (Riverpod 3.x)
class DiveLogNotifier extends Notifier<List<DiveLog>> {
  @override
  List<DiveLog> build() {
    return MockDiveLogs.getAllDiveLogs();
  }

  /// Add a new dive log
  void addDiveLog(DiveLog diveLog) {
    state = [...state, diveLog];
    // Update diver's dive count
    ref.read(diverProvider.notifier).incrementDiveCount();
  }

  /// Update an existing dive log
  void updateDiveLog(DiveLog updatedLog) {
    state = [
      for (final log in state)
        if (log.id == updatedLog.id) updatedLog else log
    ];
  }

  /// Delete a dive log by ID
  void deleteDiveLog(String id) {
    state = state.where((log) => log.id != id).toList();
    // Update diver's dive count
    ref.read(diverProvider.notifier).decrementDiveCount();
  }

  /// Get a dive log by ID
  DiveLog? getDiveLogById(String id) {
    try {
      return state.firstWhere((log) => log.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get recent dive logs
  List<DiveLog> getRecentDiveLogs({int count = 3}) {
    final sorted = List<DiveLog>.from(state);
    sorted.sort((a, b) => b.diveDate.compareTo(a.diveDate));
    return sorted.take(count).toList();
  }

  /// Get most recent dive
  DiveLog? getMostRecentDive() {
    if (state.isEmpty) return null;
    final sorted = List<DiveLog>.from(state);
    sorted.sort((a, b) => b.diveDate.compareTo(a.diveDate));
    return sorted.first;
  }

  /// Get dive logs sorted by date (newest first)
  List<DiveLog> getSortedDiveLogs() {
    final sorted = List<DiveLog>.from(state);
    sorted.sort((a, b) => b.diveDate.compareTo(a.diveDate));
    return sorted;
  }
}

/// Provider for accessing dive logs
final diveLogProvider = NotifierProvider<DiveLogNotifier, List<DiveLog>>(
  DiveLogNotifier.new,
);

/// Provider for getting a specific dive log by ID
final diveLogByIdProvider = Provider.family<DiveLog?, String>((ref, id) {
  final logs = ref.watch(diveLogProvider);
  try {
    return logs.firstWhere((log) => log.id == id);
  } catch (e) {
    return null;
  }
});

/// Provider for getting recent dives
final recentDivesProvider = Provider<List<DiveLog>>((ref) {
  final logs = ref.watch(diveLogProvider);
  final sorted = List<DiveLog>.from(logs);
  sorted.sort((a, b) => b.diveDate.compareTo(a.diveDate));
  return sorted.take(3).toList();
});

/// Provider for getting sorted dive logs (newest first)
final sortedDiveLogsProvider = Provider<List<DiveLog>>((ref) {
  final logs = ref.watch(diveLogProvider);
  final sorted = List<DiveLog>.from(logs);
  sorted.sort((a, b) => b.diveDate.compareTo(a.diveDate));
  return sorted;
});
