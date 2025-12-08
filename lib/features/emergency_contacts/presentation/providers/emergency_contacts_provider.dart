import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/injection.dart';
import '../../domain/entities/emergency_contact.dart';
import '../../../diver_profile/presentation/providers/diver_provider.dart';

/// State for emergency contacts with loading and error handling
class EmergencyContactsState {
  final List<EmergencyContact> contacts;
  final bool isLoading;
  final String? error;

  EmergencyContactsState({
    this.contacts = const [],
    this.isLoading = false,
    this.error,
  });

  EmergencyContactsState copyWith({
    List<EmergencyContact>? contacts,
    bool? isLoading,
    String? error,
  }) {
    return EmergencyContactsState(
      contacts: contacts ?? this.contacts,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Notifier for managing emergency contacts with API integration
class EmergencyContactsNotifier extends Notifier<EmergencyContactsState> {
  @override
  EmergencyContactsState build() {
    // Load emergency contacts on initialization
    loadContacts();
    return EmergencyContactsState(isLoading: true);
  }

  /// Load emergency contacts from API (or cache if offline)
  Future<void> loadContacts() async {
    state = state.copyWith(isLoading: true, error: null);

    final useCase = ref.read(getEmergencyContactsProvider);
    final result = await useCase(kMockDiverId);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
      (contacts) {
        state = state.copyWith(
          contacts: contacts,
          isLoading: false,
          error: null,
        );
      },
    );
  }

  /// Add a new emergency contact
  Future<void> addContact(EmergencyContact contact) async {
    state = state.copyWith(isLoading: true, error: null);

    final useCase = ref.read(createEmergencyContactProvider);
    final result = await useCase(contact);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
      (createdContact) {
        state = state.copyWith(
          contacts: [...state.contacts, createdContact],
          isLoading: false,
          error: null,
        );
      },
    );
  }

  /// Update an existing contact
  Future<void> updateContact(EmergencyContact updatedContact) async {
    state = state.copyWith(isLoading: true, error: null);

    final useCase = ref.read(updateEmergencyContactProvider);
    final result = await useCase(updatedContact);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.message,
        );
      },
      (updated) {
        state = state.copyWith(
          contacts: [
            for (final contact in state.contacts)
              if (contact.id == updated.id) updated else contact
          ],
          isLoading: false,
          error: null,
        );
      },
    );
  }

  /// Delete an emergency contact by ID
  Future<void> deleteContact(String id) async {
    state = state.copyWith(isLoading: true, error: null);

    final useCase = ref.read(deleteEmergencyContactProvider);
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
          contacts: state.contacts.where((contact) => contact.id != id).toList(),
          isLoading: false,
          error: null,
        );
      },
    );
  }

  /// Toggle favorite status of an emergency contact
  Future<void> toggleFavorite(String id) async {
    final contact = state.contacts.firstWhere((c) => c.id == id);
    final updatedContact = contact.copyWith(isFavorite: !contact.isFavorite);
    await updateContact(updatedContact);
  }

  /// Get a contact by ID
  EmergencyContact? getContactById(String id) {
    try {
      return state.contacts.firstWhere((contact) => contact.id == id);
    } catch (e) {
      return null;
    }
  }
}

/// Provider for accessing emergency contacts
final emergencyContactsProvider =
    NotifierProvider<EmergencyContactsNotifier, EmergencyContactsState>(
  EmergencyContactsNotifier.new,
);

/// Provider for getting a specific contact by ID
final emergencyContactByIdProvider =
    Provider.family<EmergencyContact?, String>((ref, id) {
  final state = ref.watch(emergencyContactsProvider);
  try {
    return state.contacts.firstWhere((contact) => contact.id == id);
  } catch (e) {
    return null;
  }
});

/// Provider for getting favorite contacts
final favoriteContactsProvider = Provider<List<EmergencyContact>>((ref) {
  final state = ref.watch(emergencyContactsProvider);
  return state.contacts.where((contact) => contact.isFavorite).toList();
});
