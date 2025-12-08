import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/diver.dart';

// Use a mock diver ID for now (until auth is implemented)
const String kMockDiverId = 'mock-diver-001';

/// State for diver profile with loading and error handling
class DiverState {
  final Diver? diver;
  final bool isLoading;
  final String? error;

  DiverState({
    this.diver,
    this.isLoading = false,
    this.error,
  });

  DiverState copyWith({
    Diver? diver,
    bool? isLoading,
    String? error,
  }) {
    return DiverState(
      diver: diver ?? this.diver,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Notifier for managing diver profile with API integration
class DiverNotifier extends Notifier<DiverState> {
  @override
  DiverState build() {
    // Load diver profile on initialization
    loadDiver();
    return DiverState(isLoading: true);
  }

  /// Load diver profile from API (or cache if offline)
  Future<void> loadDiver() async {
    state = state.copyWith(isLoading: true, error: null);

    final useCase = ref.read(getDiverProfileProvider);
    final result = await useCase(kMockDiverId);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
      (diver) {
        state = state.copyWith(
          diver: diver,
          isLoading: false,
          error: null,
        );
      },
    );
  }

  /// Update diver profile via API
  Future<void> updateDiver(Diver updatedDiver) async {
    state = state.copyWith(isLoading: true, error: null);

    final useCase = ref.read(updateDiverProfileProvider);
    final result = await useCase(updatedDiver);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
      (diver) {
        state = state.copyWith(
          diver: diver,
          isLoading: false,
          error: null,
        );
      },
    );
  }

  /// Update specific profile fields
  Future<void> updateProfile({
    String? firstname,
    String? lastname,
    String? email,
    String? phone,
    String? bloodType,
    DateTime? birthdate,
    String? addressStreet,
    String? addressCity,
    String? addressState,
    String? addressPostcode,
    String? addressCountry,
  }) async {
    if (state.diver == null) return;

    final updatedDiver = state.diver!.copyWith(
      firstname: firstname ?? state.diver!.firstname,
      lastname: lastname ?? state.diver!.lastname,
      email: email ?? state.diver!.email,
      phone: phone ?? state.diver!.phone,
      bloodType: bloodType,
      birthdate: birthdate,
      addressStreet: addressStreet,
      addressCity: addressCity,
      addressState: addressState,
      addressPostcode: addressPostcode,
      addressCountry: addressCountry,
    );

    await updateDiver(updatedDiver);
  }

  /// Increment dive count (called when a new dive is added)
  Future<void> incrementDiveCount() async {
    if (state.diver == null) return;

    final updatedDiver = state.diver!.copyWith(
      diveCount: state.diver!.diveCount + 1,
    );

    await updateDiver(updatedDiver);
  }

  /// Decrement dive count (called when a dive is deleted)
  Future<void> decrementDiveCount() async {
    if (state.diver == null || state.diver!.diveCount == 0) return;

    final updatedDiver = state.diver!.copyWith(
      diveCount: state.diver!.diveCount - 1,
    );

    await updateDiver(updatedDiver);
  }
}

/// Provider for accessing the diver profile
final diverProvider = NotifierProvider<DiverNotifier, DiverState>(
  DiverNotifier.new,
);
