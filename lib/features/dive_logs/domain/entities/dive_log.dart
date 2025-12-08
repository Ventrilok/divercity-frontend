import 'package:freezed_annotation/freezed_annotation.dart';

part 'dive_log.freezed.dart';

/// Domain entity for Dive Log
/// Represents a dive log entry in the business logic layer
@freezed
class DiveLog with _$DiveLog {
  const DiveLog._();

  const factory DiveLog({
    required String id,
    required String diveSite,
    required String location,
    required DateTime diveDate,
    required double maxDepth,
    required int duration,
    double? waterTemperature,
    double? airTemperature,
    double? entryPressure,
    double? exitPressure,
    String? gasMix,
    String? notes,
    @Default(false) bool isFavorite,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _DiveLog;

  /// Format depth with unit
  String get formattedDepth => '${maxDepth.toStringAsFixed(1)}m';

  /// Format duration with unit
  String get formattedDuration => '${duration}min';

  /// Format water temperature with unit
  String? get formattedWaterTemp =>
      waterTemperature != null ? '${waterTemperature!.toStringAsFixed(1)}°C' : null;

  /// Format date in readable format
  String get formattedDate {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${months[diveDate.month - 1]} ${diveDate.day}, ${diveDate.year}';
  }
}
