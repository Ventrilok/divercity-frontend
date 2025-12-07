import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/diver.dart';
import '../../../../data/mock/mock_divers.dart';

/// Notifier for managing diver profile (Riverpod 3.x)
class DiverNotifier extends Notifier<Diver> {
  @override
  Diver build() {
    return MockDivers.getCurrentDiver();
  }

  /// Update diver profile
  void updateDiver(Diver updatedDiver) {
    state = updatedDiver;
  }

  /// Update specific fields
  void updateProfile({
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
  }) {
    state = state.copyWith(
      firstname: firstname,
      lastname: lastname,
      email: email,
      phone: phone,
      bloodType: bloodType,
      birthdate: birthdate,
      addressStreet: addressStreet,
      addressCity: addressCity,
      addressState: addressState,
      addressPostcode: addressPostcode,
      addressCountry: addressCountry,
    );
  }

  /// Increment dive count (called when a new dive is added)
  void incrementDiveCount() {
    state = state.copyWith(diveCount: state.diveCount + 1);
  }

  /// Decrement dive count (called when a dive is deleted)
  void decrementDiveCount() {
    if (state.diveCount > 0) {
      state = state.copyWith(diveCount: state.diveCount - 1);
    }
  }
}

/// Provider for accessing the current diver profile
final diverProvider = NotifierProvider<DiverNotifier, Diver>(
  DiverNotifier.new,
);
