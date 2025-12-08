import '../../../../core/utils/typedef.dart';
import '../entities/dive_log.dart';
import '../repositories/dive_log_repository.dart';

/// Use case for getting a specific dive log by ID
/// Follows single responsibility principle
class GetDiveLogById {
  final DiveLogRepository repository;

  GetDiveLogById(this.repository);

  /// Execute the use case
  /// Returns `Either<Failure, DiveLog>`
  ResultFuture<DiveLog> call(String diveLogId) {
    return repository.getDiveLogById(diveLogId);
  }
}
