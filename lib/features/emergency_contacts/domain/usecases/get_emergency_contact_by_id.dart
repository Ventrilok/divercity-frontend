import '../../../../core/utils/typedef.dart';
import '../entities/emergency_contact.dart';
import '../repositories/emergency_contact_repository.dart';

/// Use case for getting a specific emergency contact by ID
/// Follows single responsibility principle
class GetEmergencyContactById {
  final EmergencyContactRepository repository;

  GetEmergencyContactById(this.repository);

  /// Execute the use case
  /// Returns `Either<Failure, EmergencyContact>`
  ResultFuture<EmergencyContact> call(String contactId) {
    return repository.getEmergencyContactById(contactId);
  }
}
