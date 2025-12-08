import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/emergency_contact.dart';
import '../../domain/repositories/emergency_contact_repository.dart';
import '../datasources/emergency_contact_local_datasource.dart';
import '../datasources/emergency_contact_remote_datasource.dart';
import '../models/emergency_contact_model.dart';

/// Implementation of EmergencyContactRepository with offline-first caching
class EmergencyContactRepositoryImpl implements EmergencyContactRepository {
  final EmergencyContactRemoteDataSource remoteDataSource;
  final EmergencyContactLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  EmergencyContactRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<EmergencyContact>>> getEmergencyContacts(
      String diverId) async {
    final isConnected = await networkInfo.isConnected;

    if (isConnected) {
      try {
        final remoteContacts =
            await remoteDataSource.getEmergencyContacts(diverId);
        await localDataSource.cacheEmergencyContacts(diverId, remoteContacts);
        return Right(remoteContacts.map((model) => model.toEntity()).toList());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on NetworkException catch (e) {
        return Left(NetworkFailure(e.message));
      } on AppException catch (e) {
        return Left(UnexpectedFailure(e.message));
      }
    } else {
      try {
        final cachedContacts =
            await localDataSource.getCachedEmergencyContacts(diverId);
        if (cachedContacts.isEmpty) {
          return const Left(
              CacheFailure('No cached emergency contacts available'));
        }
        return Right(cachedContacts.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, EmergencyContact>> getEmergencyContactById(
      String contactId) async {
    final isConnected = await networkInfo.isConnected;

    if (isConnected) {
      try {
        final remoteContact =
            await remoteDataSource.getEmergencyContactById(contactId);
        await localDataSource.cacheEmergencyContact(remoteContact);
        return Right(remoteContact.toEntity());
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
        final cachedContact =
            await localDataSource.getCachedEmergencyContact(contactId);
        if (cachedContact == null) {
          return const Left(
              CacheFailure('Emergency contact not found in cache'));
        }
        return Right(cachedContact.toEntity());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, EmergencyContact>> createEmergencyContact(
      EmergencyContact contact) async {
    final isConnected = await networkInfo.isConnected;

    if (isConnected) {
      try {
        final model = EmergencyContactModel.fromEntity(contact);
        final createdContact =
            await remoteDataSource.createEmergencyContact(model);
        await localDataSource.cacheEmergencyContact(createdContact);
        return Right(createdContact.toEntity());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on ValidationException catch (e) {
        return Left(ValidationFailure(e.message));
      } on AppException catch (e) {
        return Left(UnexpectedFailure(e.message));
      }
    } else {
      return const Left(
        NetworkFailure('Cannot create emergency contact while offline'),
      );
    }
  }

  @override
  Future<Either<Failure, EmergencyContact>> updateEmergencyContact(
      EmergencyContact contact) async {
    final isConnected = await networkInfo.isConnected;

    if (isConnected) {
      try {
        final model = EmergencyContactModel.fromEntity(contact);
        final updatedContact =
            await remoteDataSource.updateEmergencyContact(model);
        await localDataSource.cacheEmergencyContact(updatedContact);
        return Right(updatedContact.toEntity());
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
        NetworkFailure('Cannot update emergency contact while offline'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteEmergencyContact(String contactId) async {
    final isConnected = await networkInfo.isConnected;

    if (isConnected) {
      try {
        await remoteDataSource.deleteEmergencyContact(contactId);
        await localDataSource.deleteCachedEmergencyContact(contactId);
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
        NetworkFailure('Cannot delete emergency contact while offline'),
      );
    }
  }
}
