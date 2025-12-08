import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/dive_log.dart';
import '../../../diver_profile/presentation/providers/diver_provider.dart';

/// State for dive logs with loading and error handling
class DiveLogState {
  final List<DiveLog> diveLogs;
  final bool isLoading;
  final String? error;

  DiveLogState({
    this.diveLogs = const [],
    this.isLoading = false,
    this.error,
  });

  DiveLogState copyWith({
    List<DiveLog>? diveLogs,
    bool? isLoading,
    String? error,
  }) {
    return DiveLogState(
      diveLogs: diveLogs ?? this.diveLogs,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Notifier for managing dive logs with API integration
class DiveLogNotifier extends Notifier<DiveLogState> {
  @override
  DiveLogState build() {
    // Load dive logs on initialization
    loadDiveLogs();
    return DiveLogState(isLoading: true);
  }

  /// Load dive logs from API (or cache if offline)
  Future<void> loadDiveLogs() async {
    state = state.copyWith(isLoading: true, error: null);

    final useCase = ref.read(getDiveLogsProvider);
    final result = await useCase(kMockDiverId);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
      (diveLogs) {
        state = state.copyWith(
          diveLogs: diveLogs,
          isLoading: false,
          error: null,
        );
      },
    );
  }

  /// Add a new dive log
  Future<void> addDiveLog(DiveLog diveLog) async {
    state = state.copyWith(isLoading: true, error: null);

    final useCase = ref.read(createDiveLogProvider);
    final result = await useCase(diveLog);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
      (createdLog) {
        state = state.copyWith(
          diveLogs: [...state.diveLogs, createdLog],
          isLoading: false,
          error: null,
        );
        // Update diver's dive count
        ref.read(diverProvider.notifier).incrementDiveCount();
      },
    );
  }

  /// Update an existing dive log
  Future<void> updateDiveLog(DiveLog updatedLog) async {
    state = state.copyWith(isLoading: true, error: null);

    final useCase = ref.read(updateDiveLogProvider);
    final result = await useCase(updatedLog);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
      (updated) {
        state = state.copyWith(
          diveLogs: [
            for (final log in state.diveLogs)
              if (log.id == updated.id) updated else log
          ],
          isLoading: false,
          error: null,
        );
      },
    );
  }

  /// Delete a dive log by ID
  Future<void> deleteDiveLog(String id) async {
    state = state.copyWith(isLoading: true, error: null);

    final useCase = ref.read(deleteDiveLogProvider);
    final result = await useCase(id);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
      (_) {
        state = state.copyWith(
          diveLogs: state.diveLogs.where((log) => log.id != id).toList(),
          isLoading: false,
          error: null,
        );
        // Update diver's dive count
        ref.read(diverProvider.notifier).decrementDiveCount();
      },
    );
  }

  /// Toggle favorite status of a dive log
  Future<void> toggleFavorite(String id) async {
    final log = state.diveLogs.firstWhere((log) => log.id == id);
    final updatedLog = log.copyWith(isFavorite: !log.isFavorite);
    await updateDiveLog(updatedLog);
  }

  /// Get a dive log by ID
  DiveLog? getDiveLogById(String id) {
    try {
      return state.diveLogs.firstWhere((log) => log.id == id);
    } catch (e) {
      return null;
    }
  }
}

/// Provider for accessing dive logs
final diveLogProvider = NotifierProvider<DiveLogNotifier, DiveLogState>(
  DiveLogNotifier.new,
);

/// Provider for getting a specific dive log by ID
final diveLogByIdProvider = Provider.family<DiveLog?, String>((ref, id) {
  final state = ref.watch(diveLogProvider);
  try {
    return state.diveLogs.firstWhere((log) => log.id == id);
  } catch (e) {
    return null;
  }
});

/// Provider for getting recent dives
final recentDivesProvider = Provider<List<DiveLog>>((ref) {
  final state = ref.watch(diveLogProvider);
  final sorted = List<DiveLog>.from(state.diveLogs);
  sorted.sort((a, b) => b.diveDate.compareTo(a.diveDate));
  return sorted.take(3).toList();
});

/// Provider for getting sorted dive logs (newest first)
final sortedDiveLogsProvider = Provider<List<DiveLog>>((ref) {
  final state = ref.watch(diveLogProvider);
  final sorted = List<DiveLog>.from(state.diveLogs);
  sorted.sort((a, b) => b.diveDate.compareTo(a.diveDate));
  return sorted;
});

/// Provider for getting favorite dive logs
final favoriteDiveLogsProvider = Provider<List<DiveLog>>((ref) {
  final state = ref.watch(diveLogProvider);
  return state.diveLogs.where((log) => log.isFavorite).toList();
});
