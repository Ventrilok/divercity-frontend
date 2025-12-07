import '../../features/diver_profile/data/models/diver.dart';

/// Mock diver data for prototype
class MockDivers {
  static final Diver currentDiver = Diver(
    id: 'diver-001',
    firstname: 'Alex',
    lastname: 'Rivera',
    email: 'alex.rivera@example.com',
    phone: '+1234567890',
    diveCount: 47,
    joinedAt: DateTime(2022, 3, 15),
    bloodType: 'O+',
    birthdate: DateTime(1990, 6, 20),
    addressStreet: '123 Ocean Drive',
    addressCity: 'Miami',
    addressState: 'Florida',
    addressPostcode: '33139',
    addressCountry: 'USA',
  );

  /// Get the current user's diver profile
  static Diver getCurrentDiver() => currentDiver;
}
