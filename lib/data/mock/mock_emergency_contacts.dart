import '../../features/emergency_contacts/data/models/emergency_contact.dart';

/// Mock emergency contact data for prototype
class MockEmergencyContacts {
  static final List<EmergencyContact> contacts = [
    EmergencyContact(
      id: 'contact-001',
      name: 'Sarah Rivera',
      relationship: 'Spouse',
      phone: '+1234567891',
      email: 'sarah.rivera@example.com',
      address: '123 Ocean Drive, Miami, FL 33139',
      notes: 'Primary emergency contact',
    ),
    EmergencyContact(
      id: 'contact-002',
      name: 'Dr. James Chen',
      relationship: 'Dive Physician',
      phone: '+1234567892',
      email: 'dr.chen@divemedicine.com',
      address: '456 Medical Plaza, Miami, FL 33140',
      notes: 'Hyperbaric medicine specialist',
    ),
    EmergencyContact(
      id: 'contact-003',
      name: 'Maria Garcia',
      relationship: 'Dive Buddy',
      phone: '+1234567893',
      email: 'maria.garcia@example.com',
      address: '789 Coastal Road, Miami, FL 33141',
      notes: 'Frequent dive partner, PADI Rescue Diver',
    ),
  ];

  /// Get all emergency contacts
  static List<EmergencyContact> getAllContacts() {
    return List.from(contacts);
  }

  /// Get primary contact (first in list)
  static EmergencyContact? getPrimaryContact() {
    if (contacts.isEmpty) return null;
    return contacts.first;
  }
}
