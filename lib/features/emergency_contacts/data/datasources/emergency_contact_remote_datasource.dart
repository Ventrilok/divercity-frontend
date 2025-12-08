import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_error_handler.dart';
import '../models/emergency_contact_model.dart';

/// Abstract interface for emergency contact remote operations
abstract class EmergencyContactRemoteDataSource {
  /// Get all emergency contacts for a diver from the API
  Future<List<EmergencyContactModel>> getEmergencyContacts(String diverId);

  /// Get a specific emergency contact by ID from the API
  Future<EmergencyContactModel> getEmergencyContactById(String contactId);

  /// Create a new emergency contact via the API
  Future<EmergencyContactModel> createEmergencyContact(EmergencyContactModel contact);

  /// Update an existing emergency contact via the API
  Future<EmergencyContactModel> updateEmergencyContact(EmergencyContactModel contact);

  /// Delete an emergency contact via the API
  Future<void> deleteEmergencyContact(String contactId);
}

/// Implementation of EmergencyContactRemoteDataSource using Dio
class EmergencyContactRemoteDataSourceImpl
    implements EmergencyContactRemoteDataSource {
  final Dio dio;

  EmergencyContactRemoteDataSourceImpl(this.dio);

  @override
  Future<List<EmergencyContactModel>> getEmergencyContacts(
      String diverId) async {
    try {
      final response = await dio.get(
        ApiConstants.emergencyContactsByDiverId(diverId),
      );

      if (response.data is List) {
        return (response.data as List)
            .map((json) =>
                EmergencyContactModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      return [];
    } on DioException catch (e) {
      throw ApiErrorHandler.handleDioException(e);
    }
  }

  @override
  Future<EmergencyContactModel> getEmergencyContactById(
      String contactId) async {
    try {
      final response = await dio.get(
        ApiConstants.emergencyContactById(contactId),
      );
      return EmergencyContactModel.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiErrorHandler.handleDioException(e);
    }
  }

  @override
  Future<EmergencyContactModel> createEmergencyContact(
      EmergencyContactModel contact) async {
    try {
      final response = await dio.post(
        ApiConstants.emergencyContacts,
        data: contact.toJson(),
      );
      return EmergencyContactModel.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiErrorHandler.handleDioException(e);
    }
  }

  @override
  Future<EmergencyContactModel> updateEmergencyContact(
      EmergencyContactModel contact) async {
    try {
      final response = await dio.put(
        ApiConstants.emergencyContactById(contact.id),
        data: contact.toJson(),
      );
      return EmergencyContactModel.fromJson(
          response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiErrorHandler.handleDioException(e);
    }
  }

  @override
  Future<void> deleteEmergencyContact(String contactId) async {
    try {
      await dio.delete(
        ApiConstants.emergencyContactById(contactId),
      );
    } on DioException catch (e) {
      throw ApiErrorHandler.handleDioException(e);
    }
  }
}
