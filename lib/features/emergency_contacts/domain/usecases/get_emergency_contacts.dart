import '../../../../core/utils/typedef.dart';
import '../entities/emergency_contact.dart';
import '../repositories/emergency_contact_repository.dart';

/// Use case for getting all emergency contacts for a diver
/// Follows single responsibility principle
class GetEmergencyContacts {
  final EmergencyContactRepository repository;

  GetEmergencyContacts(this.repository);

  /// Execute the use case
  /// Returns `Either<Failure, List<EmergencyContact>>`
  ResultFuture<List<EmergencyContact>> call(String diverId) {
    return repository.getEmergencyContacts(diverId);
  }
}
