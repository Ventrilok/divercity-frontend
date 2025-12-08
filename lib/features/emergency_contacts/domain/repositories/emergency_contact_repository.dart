import '../../../../core/utils/typedef.dart';
import '../entities/emergency_contact.dart';

/// Repository interface for Emergency Contact operations
/// Defines the contract for data operations in the domain layer
abstract class EmergencyContactRepository {
  /// Get all emergency contacts for a diver
  /// Returns `Either<Failure, List<EmergencyContact>>`
  ResultFuture<List<EmergencyContact>> getEmergencyContacts(String diverId);

  /// Get a specific emergency contact by ID
  /// Returns `Either<Failure, EmergencyContact>`
  ResultFuture<EmergencyContact> getEmergencyContactById(String contactId);

  /// Create a new emergency contact
  /// Returns `Either<Failure, EmergencyContact>` with created contact
  ResultFuture<EmergencyContact> createEmergencyContact(EmergencyContact contact);

  /// Update an existing emergency contact
  /// Returns `Either<Failure, EmergencyContact>` with updated contact
  ResultFuture<EmergencyContact> updateEmergencyContact(EmergencyContact contact);

  /// Delete an emergency contact by ID
  /// Returns `Either<Failure, void>`
  ResultVoid deleteEmergencyContact(String contactId);
}
