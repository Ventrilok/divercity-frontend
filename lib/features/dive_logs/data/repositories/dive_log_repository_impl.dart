import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/dive_log.dart';
import '../../domain/repositories/dive_log_repository.dart';
import '../datasources/dive_log_local_datasource.dart';
import '../datasources/dive_log_remote_datasource.dart';
import '../models/dive_log_model.dart';

/// Implementation of DiveLogRepository with offline-first caching
class DiveLogRepositoryImpl implements DiveLogRepository {
  final DiveLogRemoteDataSource remoteDataSource;
  final DiveLogLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  DiveLogRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<DiveLog>>> getDiveLogs(String diverId) async {
    final isConnected = await networkInfo.isConnected;

    if (isConnected) {
      try {
        final remoteDiveLogs = await remoteDataSource.getDiveLogs(diverId);
        await localDataSource.cacheDiveLogs(diverId, remoteDiveLogs);
        return Right(remoteDiveLogs.map((model) => model.toEntity()).toList());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on NetworkException catch (e) {
        return Left(NetworkFailure(e.message));
      } on AppException catch (e) {
        return Left(UnexpectedFailure(e.message));
      }
    } else {
      try {
        final cachedDiveLogs = await localDataSource.getCachedDiveLogs(diverId);
        if (cachedDiveLogs.isEmpty) {
          return const Left(CacheFailure('No cached dive logs available'));
        }
        return Right(cachedDiveLogs.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, DiveLog>> getDiveLogById(String diveLogId) async {
    final isConnected = await networkInfo.isConnected;

    if (isConnected) {
      try {
        final remoteDiveLog = await remoteDataSource.getDiveLogById(diveLogId);
        await localDataSource.cacheDiveLog(remoteDiveLog);
        return Right(remoteDiveLog.toEntity());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on NetworkException catch (e) {
        return Left(NetworkFailure(e.message));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(e.message));
      } on AppException catch (e) {
        return Left(UnexpectedFailure(e.message));
      }
    } else {
      try {
        final cachedDiveLog = await localDataSource.getCachedDiveLog(diveLogId);
        if (cachedDiveLog == null) {
          return const Left(CacheFailure('Dive log not found in cache'));
        }
        return Right(cachedDiveLog.toEntity());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, DiveLog>> createDiveLog(DiveLog diveLog) async {
    final isConnected = await networkInfo.isConnected;

    if (isConnected) {
      try {
        final model = DiveLogModel.fromEntity(diveLog);
        final createdDiveLog = await remoteDataSource.createDiveLog(model);
        await localDataSource.cacheDiveLog(createdDiveLog);
        return Right(createdDiveLog.toEntity());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on ValidationException catch (e) {
        return Left(ValidationFailure(e.message));
      } on AppException catch (e) {
        return Left(UnexpectedFailure(e.message));
      }
    } else {
      return const Left(
        NetworkFailure('Cannot create dive log while offline'),
      );
    }
  }

  @override
  Future<Either<Failure, DiveLog>> updateDiveLog(DiveLog diveLog) async {
    final isConnected = await networkInfo.isConnected;

    if (isConnected) {
      try {
        final model = DiveLogModel.fromEntity(diveLog);
        final updatedDiveLog = await remoteDataSource.updateDiveLog(model);
        await localDataSource.cacheDiveLog(updatedDiveLog);
        return Right(updatedDiveLog.toEntity());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on ValidationException catch (e) {
        return Left(ValidationFailure(e.message));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(e.message));
      } on AppException catch (e) {
        return Left(UnexpectedFailure(e.message));
      }
    } else {
      return const Left(
        NetworkFailure('Cannot update dive log while offline'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteDiveLog(String diveLogId) async {
    final isConnected = await networkInfo.isConnected;

    if (isConnected) {
      try {
        await remoteDataSource.deleteDiveLog(diveLogId);
        await localDataSource.deleteCachedDiveLog(diveLogId);
        return const Right(null);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(e.message));
      } on AppException catch (e) {
        return Left(UnexpectedFailure(e.message));
      }
    } else {
      return const Left(
        NetworkFailure('Cannot delete dive log while offline'),
      );
    }
  }
}
