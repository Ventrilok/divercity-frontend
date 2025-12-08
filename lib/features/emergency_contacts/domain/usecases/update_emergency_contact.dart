import '../../../../core/utils/typedef.dart';
import '../entities/emergency_contact.dart';
import '../repositories/emergency_contact_repository.dart';

/// Use case for updating an existing emergency contact
/// Follows single responsibility principle
class UpdateEmergencyContact {
  final EmergencyContactRepository repository;

  UpdateEmergencyContact(this.repository);

  /// Execute the use case
  /// Returns `Either<Failure, EmergencyContact>` with updated contact
  ResultFuture<EmergencyContact> call(EmergencyContact contact) {
    return repository.updateEmergencyContact(contact);
  }
}
