import '../../../../core/utils/typedef.dart';
import '../repositories/diver_repository.dart';

/// Use case for getting a diver profile
/// Follows single responsibility principle
class GetDiverProfile {
  final DiverRepository repository;

  GetDiverProfile(this.repository);

  /// Execute the use case
  /// Returns `Either<Failure, Diver>`
  ResultFuture<Diver> call(String diverId) {
    return repository.getDiverProfile(diverId);
  }
}
