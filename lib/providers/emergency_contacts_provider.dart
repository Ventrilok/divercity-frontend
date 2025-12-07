import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/emergency_contact.dart';
import '../data/mock/mock_emergency_contacts.dart';

/// Notifier for managing emergency contacts (Riverpod 3.x)
class EmergencyContactsNotifier extends Notifier<List<EmergencyContact>> {
  @override
  List<EmergencyContact> build() {
    return MockEmergencyContacts.getAllContacts();
  }

  /// Add a new emergency contact
  void addContact(EmergencyContact contact) {
    state = [...state, contact];
  }

  /// Update an existing contact
  void updateContact(EmergencyContact updatedContact) {
    state = [
      for (final contact in state)
        if (contact.id == updatedContact.id) updatedContact else contact
    ];
  }

  /// Delete a contact by ID
  void deleteContact(String id) {
    state = state.where((contact) => contact.id != id).toList();
  }

  /// Get a contact by ID
  EmergencyContact? getContactById(String id) {
    try {
      return state.firstWhere((contact) => contact.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get primary contact (first in list)
  EmergencyContact? getPrimaryContact() {
    if (state.isEmpty) return null;
    return state.first;
  }

  /// Reorder contacts
  void reorderContacts(int oldIndex, int newIndex) {
    final items = List<EmergencyContact>.from(state);
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    state = items;
  }
}

/// Provider for accessing emergency contacts
final emergencyContactsProvider =
    NotifierProvider<EmergencyContactsNotifier, List<EmergencyContact>>(
  EmergencyContactsNotifier.new,
);

/// Provider for getting a specific contact by ID
final contactByIdProvider = Provider.family<EmergencyContact?, String>((ref, id) {
  final contacts = ref.watch(emergencyContactsProvider);
  try {
    return contacts.firstWhere((contact) => contact.id == id);
  } catch (e) {
    return null;
  }
});

/// Provider for getting the primary contact
final primaryContactProvider = Provider<EmergencyContact?>((ref) {
  final contacts = ref.watch(emergencyContactsProvider);
  if (contacts.isEmpty) return null;
  return contacts.first;
});
