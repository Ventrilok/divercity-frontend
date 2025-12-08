// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_contact_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EmergencyContactModel _$EmergencyContactModelFromJson(
  Map<String, dynamic> json,
) => _EmergencyContactModel(
  id: json['id'] as String,
  name: json['name'] as String,
  relationship: json['relationship'] as String,
  phone: json['phone'] as String,
  email: json['email'] as String?,
  address: json['address'] as String?,
  notes: json['notes'] as String?,
  isFavorite: json['is_favorite'] as bool? ?? false,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$EmergencyContactModelToJson(
  _EmergencyContactModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'relationship': instance.relationship,
  'phone': instance.phone,
  'email': instance.email,
  'address': instance.address,
  'notes': instance.notes,
  'is_favorite': instance.isFavorite,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};
