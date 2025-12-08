import '../../../../core/utils/typedef.dart';
import '../entities/dive_log.dart';
import '../repositories/dive_log_repository.dart';

/// Use case for creating a new dive log
/// Follows single responsibility principle
class CreateDiveLog {
  final DiveLogRepository repository;

  CreateDiveLog(this.repository);

  /// Execute the use case
  /// Returns `Either<Failure, DiveLog>` with created dive log
  ResultFuture<DiveLog> call(DiveLog diveLog) {
    return repository.createDiveLog(diveLog);
  }
}
