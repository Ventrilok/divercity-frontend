// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diver_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DiverModel _$DiverModelFromJson(Map<String, dynamic> json) => _DiverModel(
  id: json['id'] as String,
  firstname: json['firstname'] as String,
  lastname: json['lastname'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String?,
  bloodType: json['blood_type'] as String?,
  birthdate: json['birthdate'] == null
      ? null
      : DateTime.parse(json['birthdate'] as String),
  addressStreet: json['address_street'] as String?,
  addressCity: json['address_city'] as String?,
  addressState: json['address_state'] as String?,
  addressPostcode: json['address_postcode'] as String?,
  addressCountry: json['address_country'] as String?,
  diveCount: (json['dive_count'] as num?)?.toInt() ?? 0,
  joinedAt: json['joined_at'] == null
      ? null
      : DateTime.parse(json['joined_at'] as String),
);

Map<String, dynamic> _$DiverModelToJson(_DiverModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'email': instance.email,
      'phone': instance.phone,
      'blood_type': instance.bloodType,
      'birthdate': instance.birthdate?.toIso8601String(),
      'address_street': instance.addressStreet,
      'address_city': instance.addressCity,
      'address_state': instance.addressState,
      'address_postcode': instance.addressPostcode,
      'address_country': instance.addressCountry,
      'dive_count': instance.diveCount,
      'joined_at': instance.joinedAt?.toIso8601String(),
    };
