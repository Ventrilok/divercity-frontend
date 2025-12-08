import '../../../../core/utils/typedef.dart';
import '../repositories/emergency_contact_repository.dart';

/// Use case for deleting an emergency contact
/// Follows single responsibility principle
class DeleteEmergencyContact {
  final EmergencyContactRepository repository;

  DeleteEmergencyContact(this.repository);

  /// Execute the use case
  /// Returns `Either<Failure, void>`
  ResultVoid call(String contactId) {
    return repository.deleteEmergencyContact(contactId);
  }
}
