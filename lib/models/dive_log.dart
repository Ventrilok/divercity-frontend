/// Simple DiveLog model for mockup
/// This is a plain Dart class (not Freezed) for rapid prototyping
class DiveLog {
  final String id;
  final String diveSite;
  final String location;
  final DateTime diveDate;
  final double maxDepth;
  final int duration;
  final double? waterTemperature;
  final double? airTemperature;
  final double? entryPressure;
  final double? exitPressure;
  final String? gasMix;
  final String? notes;

  DiveLog({
    required this.id,
    required this.diveSite,
    required this.location,
    required this.diveDate,
    required this.maxDepth,
    required this.duration,
    this.waterTemperature,
    this.airTemperature,
    this.entryPressure,
    this.exitPressure,
    this.gasMix,
    this.notes,
  });

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

  /// Create a copy with modified fields
  DiveLog copyWith({
    String? id,
    String? diveSite,
    String? location,
    DateTime? diveDate,
    double? maxDepth,
    int? duration,
    double? waterTemperature,
    double? airTemperature,
    double? entryPressure,
    double? exitPressure,
    String? gasMix,
    String? notes,
  }) {
    return DiveLog(
      id: id ?? this.id,
      diveSite: diveSite ?? this.diveSite,
      location: location ?? this.location,
      diveDate: diveDate ?? this.diveDate,
      maxDepth: maxDepth ?? this.maxDepth,
      duration: duration ?? this.duration,
      waterTemperature: waterTemperature ?? this.waterTemperature,
      airTemperature: airTemperature ?? this.airTemperature,
      entryPressure: entryPressure ?? this.entryPressure,
      exitPressure: exitPressure ?? this.exitPressure,
      gasMix: gasMix ?? this.gasMix,
      notes: notes ?? this.notes,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DiveLog && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
