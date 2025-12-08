import '../../../../core/utils/typedef.dart';
import '../entities/diver.dart';
import '../repositories/diver_repository.dart';

/// Use case for updating a diver profile
/// Follows single responsibility principle
class UpdateDiverProfile {
  final DiverRepository repository;

  UpdateDiverProfile(this.repository);

  /// Execute the use case
  /// Returns `Either<Failure, Diver>` with updated diver
  ResultFuture<Diver> call(Diver diver) {
    return repository.updateDiverProfile(diver);
  }
}
