import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/dive_log.dart';

part 'dive_log_model.freezed.dart';
part 'dive_log_model.g.dart';

/// Data model for Dive Log with JSON serialization
/// Extends domain entity and adds fromJson/toJson capabilities
@freezed
class DiveLogModel with _$DiveLogModel {
  const DiveLogModel._();

  const factory DiveLogModel({
    required String id,
    @JsonKey(name: 'dive_site') required String diveSite,
    required String location,
    @JsonKey(name: 'dive_date') required DateTime diveDate,
    @JsonKey(name: 'max_depth') required double maxDepth,
    required int duration,
    @JsonKey(name: 'water_temperature') double? waterTemperature,
    @JsonKey(name: 'air_temperature') double? airTemperature,
    @JsonKey(name: 'entry_pressure') double? entryPressure,
    @JsonKey(name: 'exit_pressure') double? exitPressure,
    @JsonKey(name: 'gas_mix') String? gasMix,
    String? notes,
    @JsonKey(name: 'is_favorite') @Default(false) bool isFavorite,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _DiveLogModel;

  factory DiveLogModel.fromJson(Map<String, dynamic> json) =>
      _$DiveLogModelFromJson(json);

  /// Convert model to domain entity
  DiveLog toEntity() => DiveLog(
        id: id,
        diveSite: diveSite,
        location: location,
        diveDate: diveDate,
        maxDepth: maxDepth,
        duration: duration,
        waterTemperature: waterTemperature,
        airTemperature: airTemperature,
        entryPressure: entryPressure,
        exitPressure: exitPressure,
        gasMix: gasMix,
        notes: notes,
        isFavorite: isFavorite,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  /// Create model from domain entity
  factory DiveLogModel.fromEntity(DiveLog diveLog) => DiveLogModel(
        id: diveLog.id,
        diveSite: diveLog.diveSite,
        location: diveLog.location,
        diveDate: diveLog.diveDate,
        maxDepth: diveLog.maxDepth,
        duration: diveLog.duration,
        waterTemperature: diveLog.waterTemperature,
        airTemperature: diveLog.airTemperature,
        entryPressure: diveLog.entryPressure,
        exitPressure: diveLog.exitPressure,
        gasMix: diveLog.gasMix,
        notes: diveLog.notes,
        isFavorite: diveLog.isFavorite,
        createdAt: diveLog.createdAt,
        updatedAt: diveLog.updatedAt,
      );
}
