import 'package:dartz/dartz.dart';
import '../error/failures.dart';

/// Type alias for `Future<Either<Failure, T>>`
/// Used for async operations that can fail
///
/// Example:
/// ```dart
/// ResultFuture<Diver> getDiverProfile(String id);
/// ```
typedef ResultFuture<T> = Future<Either<Failure, T>>;

/// Type alias for `Future<Either<Failure, void>>`
/// Used for async operations that don't return a value but can fail
///
/// Example:
/// ```dart
/// ResultVoid deleteDiveLog(String id);
/// ```
typedef ResultVoid = Future<Either<Failure, void>>;

/// Type alias for `Either<Failure, T>`
/// Used for sync operations that can fail
///
/// Example:
/// ```dart
/// Result<int> calculateAge(DateTime birthdate);
/// ```
typedef Result<T> = Either<Failure, T>;

/// Type alias for `Map<String, dynamic>`
/// Commonly used for JSON data
typedef DataMap = Map<String, dynamic>;

/// Type alias for `List<Map<String, dynamic>>`
/// Commonly used for JSON arrays
typedef DataList = List<Map<String, dynamic>>;
