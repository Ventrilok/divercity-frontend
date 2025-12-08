import '../../../../core/utils/typedef.dart';
import '../entities/dive_log.dart';
import '../repositories/dive_log_repository.dart';

/// Use case for updating an existing dive log
/// Follows single responsibility principle
class UpdateDiveLog {
  final DiveLogRepository repository;

  UpdateDiveLog(this.repository);

  /// Execute the use case
  /// Returns `Either<Failure, DiveLog>` with updated dive log
  ResultFuture<DiveLog> call(DiveLog diveLog) {
    return repository.updateDiveLog(diveLog);
  }
}
