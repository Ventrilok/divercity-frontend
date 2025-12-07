import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/dive_log.dart';
import '../../../../data/mock/mock_dive_logs.dart';
import '../../../diver_profile/presentation/providers/diver_provider.dart';

const String _diveLogsKey = 'dive_logs';

/// Notifier for managing dive logs (Riverpod 3.x) with persistence
class DiveLogNotifier extends Notifier<List<DiveLog>> {
  SharedPreferences? _prefs;

  @override
  List<DiveLog> build() {
    _loadDiveLogs();
    return MockDiveLogs.getAllDiveLogs();
  }

  /// Load dive logs from SharedPreferences
  Future<void> _loadDiveLogs() async {
    _prefs = await SharedPreferences.getInstance();
    final String? jsonString = _prefs?.getString(_diveLogsKey);

    if (jsonString != null && jsonString.isNotEmpty) {
      try {
        final List<dynamic> jsonList = json.decode(jsonString);
        final List<DiveLog> loadedLogs = jsonList
            .map((json) => DiveLog.fromJson(json as Map<String, dynamic>))
            .toList();
        state = loadedLogs;
      } catch (e) {
        // If there's an error loading, use mock data
        state = MockDiveLogs.getAllDiveLogs();
      }
    }
  }

  /// Save dive logs to SharedPreferences
  Future<void> _saveDiveLogs() async {
    _prefs ??= await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> jsonList =
        state.map((log) => log.toJson()).toList();
    final String jsonString = json.encode(jsonList);
    await _prefs?.setString(_diveLogsKey, jsonString);
  }

  /// Add a new dive log
  void addDiveLog(DiveLog diveLog) {
    state = [...state, diveLog];
    _saveDiveLogs();
    // Update diver's dive count
    ref.read(diverProvider.notifier).incrementDiveCount();
  }

  /// Update an existing dive log
  void updateDiveLog(DiveLog updatedLog) {
    state = [
      for (final log in state)
        if (log.id == updatedLog.id) updatedLog else log
    ];
    _saveDiveLogs();
  }

  /// Delete a dive log by ID
  void deleteDiveLog(String id) {
    state = state.where((log) => log.id != id).toList();
    _saveDiveLogs();
    // Update diver's dive count
    ref.read(diverProvider.notifier).decrementDiveCount();
  }

  /// Toggle favorite status of a dive log
  void toggleFavorite(String id) {
    state = [
      for (final log in state)
        if (log.id == id) log.copyWith(isFavorite: !log.isFavorite) else log
    ];
    _saveDiveLogs();
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

  /// Get favorite dive logs
  List<DiveLog> getFavoriteDiveLogs() {
    return state.where((log) => log.isFavorite).toList();
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

/// Provider for getting favorite dive logs
final favoriteDiveLogsProvider = Provider<List<DiveLog>>((ref) {
  final logs = ref.watch(diveLogProvider);
  return logs.where((log) => log.isFavorite).toList();
});
