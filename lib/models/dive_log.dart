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
  final bool isFavorite;

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
    this.isFavorite = false,
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
    bool? isFavorite,
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
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  /// Convert to JSON for persistence
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'diveSite': diveSite,
      'location': location,
      'diveDate': diveDate.toIso8601String(),
      'maxDepth': maxDepth,
      'duration': duration,
      'waterTemperature': waterTemperature,
      'airTemperature': airTemperature,
      'entryPressure': entryPressure,
      'exitPressure': exitPressure,
      'gasMix': gasMix,
      'notes': notes,
      'isFavorite': isFavorite,
    };
  }

  /// Create from JSON
  factory DiveLog.fromJson(Map<String, dynamic> json) {
    return DiveLog(
      id: json['id'] as String,
      diveSite: json['diveSite'] as String,
      location: json['location'] as String,
      diveDate: DateTime.parse(json['diveDate'] as String),
      maxDepth: (json['maxDepth'] as num).toDouble(),
      duration: json['duration'] as int,
      waterTemperature: json['waterTemperature'] != null
          ? (json['waterTemperature'] as num).toDouble()
          : null,
      airTemperature: json['airTemperature'] != null
          ? (json['airTemperature'] as num).toDouble()
          : null,
      entryPressure: json['entryPressure'] != null
          ? (json['entryPressure'] as num).toDouble()
          : null,
      exitPressure: json['exitPressure'] != null
          ? (json['exitPressure'] as num).toDouble()
          : null,
      gasMix: json['gasMix'] as String?,
      notes: json['notes'] as String?,
      isFavorite: json['isFavorite'] as bool? ?? false,
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
