import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_error_handler.dart';
import '../models/dive_log_model.dart';

/// Abstract interface for dive log remote operations
abstract class DiveLogRemoteDataSource {
  /// Get all dive logs for a diver from the API
  Future<List<DiveLogModel>> getDiveLogs(String diverId);

  /// Get a specific dive log by ID from the API
  Future<DiveLogModel> getDiveLogById(String diveLogId);

  /// Create a new dive log via the API
  Future<DiveLogModel> createDiveLog(DiveLogModel diveLog);

  /// Update an existing dive log via the API
  Future<DiveLogModel> updateDiveLog(DiveLogModel diveLog);

  /// Delete a dive log via the API
  Future<void> deleteDiveLog(String diveLogId);
}

/// Implementation of DiveLogRemoteDataSource using Dio
class DiveLogRemoteDataSourceImpl implements DiveLogRemoteDataSource {
  final Dio dio;

  DiveLogRemoteDataSourceImpl(this.dio);

  @override
  Future<List<DiveLogModel>> getDiveLogs(String diverId) async {
    try {
      final response = await dio.get(
        ApiConstants.diveLogsByDiverId(diverId),
      );

      if (response.data is List) {
        return (response.data as List)
            .map((json) => DiveLogModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      return [];
    } on DioException catch (e) {
      throw ApiErrorHandler.handleDioException(e);
    }
  }

  @override
  Future<DiveLogModel> getDiveLogById(String diveLogId) async {
    try {
      final response = await dio.get(
        ApiConstants.diveLogById(diveLogId),
      );
      return DiveLogModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiErrorHandler.handleDioException(e);
    }
  }

  @override
  Future<DiveLogModel> createDiveLog(DiveLogModel diveLog) async {
    try {
      final response = await dio.post(
        ApiConstants.diveLogs,
        data: diveLog.toJson(),
      );
      return DiveLogModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiErrorHandler.handleDioException(e);
    }
  }

  @override
  Future<DiveLogModel> updateDiveLog(DiveLogModel diveLog) async {
    try {
      final response = await dio.put(
        ApiConstants.diveLogById(diveLog.id),
        data: diveLog.toJson(),
      );
      return DiveLogModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiErrorHandler.handleDioException(e);
    }
  }

  @override
  Future<void> deleteDiveLog(String diveLogId) async {
    try {
      await dio.delete(
        ApiConstants.diveLogById(diveLogId),
      );
    } on DioException catch (e) {
      throw ApiErrorHandler.handleDioException(e);
    }
  }
}
