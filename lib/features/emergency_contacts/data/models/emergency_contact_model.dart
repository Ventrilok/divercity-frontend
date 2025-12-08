import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/emergency_contact.dart';

part 'emergency_contact_model.freezed.dart';
part 'emergency_contact_model.g.dart';

/// Data model for Emergency Contact with JSON serialization
/// Extends domain entity and adds fromJson/toJson capabilities
@freezed
class EmergencyContactModel with _$EmergencyContactModel {
  const EmergencyContactModel._();

  const factory EmergencyContactModel({
    required String id,
    required String name,
    required String relationship,
    required String phone,
    String? email,
    String? address,
    String? notes,
    @JsonKey(name: 'is_favorite') @Default(false) bool isFavorite,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _EmergencyContactModel;

  factory EmergencyContactModel.fromJson(Map<String, dynamic> json) =>
      _$EmergencyContactModelFromJson(json);

  /// Convert model to domain entity
  EmergencyContact toEntity() => EmergencyContact(
        id: id,
        name: name,
        relationship: relationship,
        phone: phone,
        email: email,
        address: address,
        notes: notes,
        isFavorite: isFavorite,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  /// Create model from domain entity
  factory EmergencyContactModel.fromEntity(EmergencyContact contact) =>
      EmergencyContactModel(
        id: contact.id,
        name: contact.name,
        relationship: contact.relationship,
        phone: contact.phone,
        email: contact.email,
        address: contact.address,
        notes: contact.notes,
        isFavorite: contact.isFavorite,
        createdAt: contact.createdAt,
        updatedAt: contact.updatedAt,
      );
}
