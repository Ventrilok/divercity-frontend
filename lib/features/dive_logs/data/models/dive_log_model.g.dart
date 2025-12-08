// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dive_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DiveLogModel _$DiveLogModelFromJson(Map<String, dynamic> json) =>
    _DiveLogModel(
      id: json['id'] as String,
      diveSite: json['dive_site'] as String,
      location: json['location'] as String,
      diveDate: DateTime.parse(json['dive_date'] as String),
      maxDepth: (json['max_depth'] as num).toDouble(),
      duration: (json['duration'] as num).toInt(),
      waterTemperature: (json['water_temperature'] as num?)?.toDouble(),
      airTemperature: (json['air_temperature'] as num?)?.toDouble(),
      entryPressure: (json['entry_pressure'] as num?)?.toDouble(),
      exitPressure: (json['exit_pressure'] as num?)?.toDouble(),
      gasMix: json['gas_mix'] as String?,
      notes: json['notes'] as String?,
      isFavorite: json['is_favorite'] as bool? ?? false,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$DiveLogModelToJson(_DiveLogModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dive_site': instance.diveSite,
      'location': instance.location,
      'dive_date': instance.diveDate.toIso8601String(),
      'max_depth': instance.maxDepth,
      'duration': instance.duration,
      'water_temperature': instance.waterTemperature,
      'air_temperature': instance.airTemperature,
      'entry_pressure': instance.entryPressure,
      'exit_pressure': instance.exitPressure,
      'gas_mix': instance.gasMix,
      'notes': instance.notes,
      'is_favorite': instance.isFavorite,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
