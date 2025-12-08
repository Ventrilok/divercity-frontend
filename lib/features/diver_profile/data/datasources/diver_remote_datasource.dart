import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_error_handler.dart';
import '../models/diver_model.dart';

/// Abstract interface for remote diver data operations
abstract class DiverRemoteDataSource {
  /// Fetch diver profile from API
  Future<DiverModel> getDiverProfile(String diverId);

  /// Update diver profile via API
  Future<DiverModel> updateDiverProfile(DiverModel diver);
}

/// Implementation of DiverRemoteDataSource using Dio
class DiverRemoteDataSourceImpl implements DiverRemoteDataSource {
  final Dio dio;

  DiverRemoteDataSourceImpl(this.dio);

  @override
  Future<DiverModel> getDiverProfile(String diverId) async {
    try {
      final response = await dio.get(ApiConstants.diverById(diverId));
      return DiverModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiErrorHandler.handleDioException(e);
    }
  }

  @override
  Future<DiverModel> updateDiverProfile(DiverModel diver) async {
    try {
      final response = await dio.put(
        ApiConstants.diverById(diver.id),
        data: diver.toJson(),
      );
      return DiverModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiErrorHandler.handleDioException(e);
    }
  }
}
