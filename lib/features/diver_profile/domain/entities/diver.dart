import 'package:freezed_annotation/freezed_annotation.dart';

part 'diver.freezed.dart';

/// Domain entity for Diver
/// Represents a diver's profile in the business logic layer
@freezed
class Diver with _$Diver {
  const Diver._();

  const factory Diver({
    required String id,
    required String firstname,
    required String lastname,
    required String email,
    String? phone,
    String? bloodType,
    DateTime? birthdate,
    String? addressStreet,
    String? addressCity,
    String? addressState,
    String? addressPostcode,
    String? addressCountry,
    @Default(0) int diveCount,
    DateTime? joinedAt,
  }) = _Diver;

  /// Full name of the diver
  String get fullName => '$firstname $lastname';

  /// Age calculated from birthdate
  int? get age {
    if (birthdate == null) return null;
    final now = DateTime.now();
    int calculatedAge = now.year - birthdate!.year;
    if (now.month < birthdate!.month ||
        (now.month == birthdate!.month && now.day < birthdate!.day)) {
      calculatedAge--;
    }
    return calculatedAge;
  }
}
