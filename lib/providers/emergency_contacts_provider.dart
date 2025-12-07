import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/emergency_contact.dart';
import '../data/mock/mock_emergency_contacts.dart';

const String _contactsKey = 'emergency_contacts';

/// Notifier for managing emergency contacts (Riverpod 3.x) with persistence
class EmergencyContactsNotifier extends Notifier<List<EmergencyContact>> {
  SharedPreferences? _prefs;

  @override
  List<EmergencyContact> build() {
    _loadContacts();
    return MockEmergencyContacts.getAllContacts();
  }

  /// Load contacts from SharedPreferences
  Future<void> _loadContacts() async {
    _prefs = await SharedPreferences.getInstance();
    final String? jsonString = _prefs?.getString(_contactsKey);

    if (jsonString != null && jsonString.isNotEmpty) {
      try {
        final List<dynamic> jsonList = json.decode(jsonString);
        final List<EmergencyContact> loadedContacts = jsonList
            .map((json) =>
                EmergencyContact.fromJson(json as Map<String, dynamic>))
            .toList();
        state = loadedContacts;
      } catch (e) {
        // If there's an error loading, use mock data
        state = MockEmergencyContacts.getAllContacts();
      }
    }
  }

  /// Save contacts to SharedPreferences
  Future<void> _saveContacts() async {
    _prefs ??= await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> jsonList =
        state.map((contact) => contact.toJson()).toList();
    final String jsonString = json.encode(jsonList);
    await _prefs?.setString(_contactsKey, jsonString);
  }

  /// Add a new emergency contact
  void addContact(EmergencyContact contact) {
    state = [...state, contact];
    _saveContacts();
  }

  /// Update an existing contact
  void updateContact(EmergencyContact updatedContact) {
    state = [
      for (final contact in state)
        if (contact.id == updatedContact.id) updatedContact else contact
    ];
    _saveContacts();
  }

  /// Delete a contact by ID
  void deleteContact(String id) {
    state = state.where((contact) => contact.id != id).toList();
    _saveContacts();
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
    _saveContacts();
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
