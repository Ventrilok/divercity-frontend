import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/diver.dart';
import '../../domain/repositories/diver_repository.dart';
import '../datasources/diver_local_datasource.dart';
import '../datasources/diver_remote_datasource.dart';
import '../models/diver_model.dart';

/// Implementation of DiverRepository with offline-first architecture
class DiverRepositoryImpl implements DiverRepository {
  final DiverRemoteDataSource remoteDataSource;
  final DiverLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  DiverRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Diver>> getDiverProfile(String diverId) async {
    // Check if device is connected to internet
    final isConnected = await networkInfo.isConnected;

    if (isConnected) {
      // Online: Fetch from API and cache
      try {
        final remoteDiver = await remoteDataSource.getDiverProfile(diverId);
        await localDataSource.cacheDiver(remoteDiver);
        return Right(remoteDiver.toEntity());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on NetworkException catch (e) {
        return Left(NetworkFailure(e.message));
      } on TimeoutException catch (e) {
        return Left(NetworkFailure(e.message));
      } catch (e) {
        return Left(UnexpectedFailure('Failed to fetch diver profile: $e'));
      }
    } else {
      // Offline: Return cached data
      try {
        final cachedDiver = await localDataSource.getCachedDiver();
        if (cachedDiver != null) {
          return Right(cachedDiver.toEntity());
        }
        return const Left(
          CacheFailure('No cached data available. Please connect to internet.'),
        );
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      } catch (e) {
        return Left(UnexpectedFailure('Failed to load cached profile: $e'));
      }
    }
  }

  @override
  Future<Either<Failure, Diver>> updateDiverProfile(Diver diver) async {
    // Check if device is connected to internet
    final isConnected = await networkInfo.isConnected;

    if (!isConnected) {
      return const Left(
        NetworkFailure(
          'Cannot update profile while offline. Please connect to internet.',
        ),
      );
    }

    try {
      final diverModel = DiverModel.fromEntity(diver);
      final updatedDiver = await remoteDataSource.updateDiverProfile(diverModel);
      await localDataSource.cacheDiver(updatedDiver);
      return Right(updatedDiver.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    } on TimeoutException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure('Failed to update diver profile: $e'));
    }
  }
}
