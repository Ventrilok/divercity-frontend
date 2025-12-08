import '../../../../core/utils/typedef.dart';
import '../entities/dive_log.dart';
import '../repositories/dive_log_repository.dart';

/// Use case for getting all dive logs for a diver
/// Follows single responsibility principle
class GetDiveLogs {
  final DiveLogRepository repository;

  GetDiveLogs(this.repository);

  /// Execute the use case
  /// Returns `Either<Failure, List<DiveLog>>`
  ResultFuture<List<DiveLog>> call(String diverId) {
    return repository.getDiveLogs(diverId);
  }
}
