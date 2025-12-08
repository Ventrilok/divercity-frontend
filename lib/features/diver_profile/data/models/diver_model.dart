import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/diver.dart';

part 'diver_model.freezed.dart';
part 'diver_model.g.dart';

/// Data model for Diver with JSON serialization
/// Extends domain entity and adds fromJson/toJson capabilities
@freezed
class DiverModel with _$DiverModel {
  const DiverModel._();

  const factory DiverModel({
    required String id,
    required String firstname,
    required String lastname,
    required String email,
    String? phone,
    @JsonKey(name: 'blood_type') String? bloodType,
    DateTime? birthdate,
    @JsonKey(name: 'address_street') String? addressStreet,
    @JsonKey(name: 'address_city') String? addressCity,
    @JsonKey(name: 'address_state') String? addressState,
    @JsonKey(name: 'address_postcode') String? addressPostcode,
    @JsonKey(name: 'address_country') String? addressCountry,
    @JsonKey(name: 'dive_count') @Default(0) int diveCount,
    @JsonKey(name: 'joined_at') DateTime? joinedAt,
  }) = _DiverModel;

  factory DiverModel.fromJson(Map<String, dynamic> json) =>
      _$DiverModelFromJson(json);

  /// Convert model to domain entity
  Diver toEntity() => Diver(
        id: id,
        firstname: firstname,
        lastname: lastname,
        email: email,
        phone: phone,
        bloodType: bloodType,
        birthdate: birthdate,
        addressStreet: addressStreet,
        addressCity: addressCity,
        addressState: addressState,
        addressPostcode: addressPostcode,
        addressCountry: addressCountry,
        diveCount: diveCount,
        joinedAt: joinedAt,
      );

  /// Create model from domain entity
  factory DiverModel.fromEntity(Diver diver) => DiverModel(
        id: diver.id,
        firstname: diver.firstname,
        lastname: diver.lastname,
        email: diver.email,
        phone: diver.phone,
        bloodType: diver.bloodType,
        birthdate: diver.birthdate,
        addressStreet: diver.addressStreet,
        addressCity: diver.addressCity,
        addressState: diver.addressState,
        addressPostcode: diver.addressPostcode,
        addressCountry: diver.addressCountry,
        diveCount: diver.diveCount,
        joinedAt: diver.joinedAt,
      );

  /// Full name of the diver
  String get fullName => '$firstname $lastname';

  /// Age calculated from birthdate
  int? get age {
    if (birthdate == null) return null;
    final now = DateTime.now();
    int age = now.year - birthdate!.year;
    if (now.month < birthdate!.month ||
        (now.month == birthdate!.month && now.day < birthdate!.day)) {
      age--;
    }
    return age;
  }
}
