import '../../../../core/utils/typedef.dart';
import '../repositories/dive_log_repository.dart';

/// Use case for deleting a dive log
/// Follows single responsibility principle
class DeleteDiveLog {
  final DiveLogRepository repository;

  DeleteDiveLog(this.repository);

  /// Execute the use case
  /// Returns `Either<Failure, void>`
  ResultVoid call(String diveLogId) {
    return repository.deleteDiveLog(diveLogId);
  }
}
