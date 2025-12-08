import '../../../../core/utils/typedef.dart';
import '../entities/dive_log.dart';

/// Repository interface for Dive Log operations
/// Defines the contract for data operations in the domain layer
abstract class DiveLogRepository {
  /// Get all dive logs for a diver
  /// Returns `Either<Failure, List<DiveLog>>`
  ResultFuture<List<DiveLog>> getDiveLogs(String diverId);

  /// Get a specific dive log by ID
  /// Returns `Either<Failure, DiveLog>`
  ResultFuture<DiveLog> getDiveLogById(String diveLogId);

  /// Create a new dive log
  /// Returns `Either<Failure, DiveLog>` with created log
  ResultFuture<DiveLog> createDiveLog(DiveLog diveLog);

  /// Update an existing dive log
  /// Returns `Either<Failure, DiveLog>` with updated log
  ResultFuture<DiveLog> updateDiveLog(DiveLog diveLog);

  /// Delete a dive log by ID
  /// Returns `Either<Failure, void>`
  ResultVoid deleteDiveLog(String diveLogId);
}
