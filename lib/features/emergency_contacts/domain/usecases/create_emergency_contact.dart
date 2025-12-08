import '../../../../core/utils/typedef.dart';
import '../entities/emergency_contact.dart';
import '../repositories/emergency_contact_repository.dart';

/// Use case for creating a new emergency contact
/// Follows single responsibility principle
class CreateEmergencyContact {
  final EmergencyContactRepository repository;

  CreateEmergencyContact(this.repository);

  /// Execute the use case
  /// Returns `Either<Failure, EmergencyContact>` with created contact
  ResultFuture<EmergencyContact> call(EmergencyContact contact) {
    return repository.createEmergencyContact(contact);
  }
}
