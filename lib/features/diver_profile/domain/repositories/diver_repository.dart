import '../../../../core/utils/typedef.dart';
import '../entities/diver.dart';

/// Repository interface for Diver operations
/// Defines the contract for data operations in the domain layer
abstract class DiverRepository {
  /// Get diver profile by ID
  /// Returns Either<Failure, Diver>
  ResultFuture<Diver> getDiverProfile(String diverId);

  /// Update diver profile
  /// Returns Either<Failure, Diver> with updated profile
  ResultFuture<Diver> updateDiverProfile(Diver diver);
}
