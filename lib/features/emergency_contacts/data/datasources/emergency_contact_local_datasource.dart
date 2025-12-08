import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/error/exceptions.dart';
import '../models/emergency_contact_model.dart';

/// Abstract interface for emergency contact local operations
abstract class EmergencyContactLocalDataSource {
  /// Get all cached emergency contacts for a diver
  Future<List<EmergencyContactModel>> getCachedEmergencyContacts(
      String diverId);

  /// Get a specific cached emergency contact by ID
  Future<EmergencyContactModel?> getCachedEmergencyContact(String contactId);

  /// Cache multiple emergency contacts
  Future<void> cacheEmergencyContacts(
      String diverId, List<EmergencyContactModel> contacts);

  /// Cache a single emergency contact
  Future<void> cacheEmergencyContact(EmergencyContactModel contact);

  /// Delete a cached emergency contact
  Future<void> deleteCachedEmergencyContact(String contactId);

  /// Clear all cached emergency contacts
  Future<void> clearCache();
}

/// Implementation of EmergencyContactLocalDataSource using Hive
class EmergencyContactLocalDataSourceImpl
    implements EmergencyContactLocalDataSource {
  static const String _boxName = 'emergency_contacts_cache';
  static const String _contactsKey = 'emergency_contacts';

  @override
  Future<List<EmergencyContactModel>> getCachedEmergencyContacts(
      String diverId) async {
    try {
      final box = await Hive.openBox(_boxName);
      final data = box.get('${_contactsKey}_$diverId');

      if (data == null) return [];

      if (data is List) {
        return data
            .map((item) => EmergencyContactModel.fromJson(
                Map<String, dynamic>.from(item as Map)))
            .toList();
      }
      return [];
    } catch (e) {
      throw CacheException('Failed to get cached emergency contacts: $e');
    }
  }

  @override
  Future<EmergencyContactModel?> getCachedEmergencyContact(
      String contactId) async {
    try {
      final box = await Hive.openBox(_boxName);
      final data = box.get('contact_$contactId');

      if (data == null) return null;

      return EmergencyContactModel.fromJson(
          Map<String, dynamic>.from(data as Map));
    } catch (e) {
      throw CacheException('Failed to get cached emergency contact: $e');
    }
  }

  @override
  Future<void> cacheEmergencyContacts(
      String diverId, List<EmergencyContactModel> contacts) async {
    try {
      final box = await Hive.openBox(_boxName);
      final jsonList = contacts.map((contact) => contact.toJson()).toList();
      await box.put('${_contactsKey}_$diverId', jsonList);

      // Also cache individual contacts
      for (final contact in contacts) {
        await box.put('contact_${contact.id}', contact.toJson());
      }
    } catch (e) {
      throw CacheException('Failed to cache emergency contacts: $e');
    }
  }

  @override
  Future<void> cacheEmergencyContact(EmergencyContactModel contact) async {
    try {
      final box = await Hive.openBox(_boxName);
      await box.put('contact_${contact.id}', contact.toJson());
    } catch (e) {
      throw CacheException('Failed to cache emergency contact: $e');
    }
  }

  @override
  Future<void> deleteCachedEmergencyContact(String contactId) async {
    try {
      final box = await Hive.openBox(_boxName);
      await box.delete('contact_$contactId');
    } catch (e) {
      throw CacheException('Failed to delete cached emergency contact: $e');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      final box = await Hive.openBox(_boxName);
      await box.clear();
    } catch (e) {
      throw CacheException('Failed to clear emergency contacts cache: $e');
    }
  }
}
