/// Simple Diver model for mockup
/// This is a plain Dart class (not Freezed) for rapid prototyping
class Diver {
  final String id;
  final String firstname;
  final String lastname;
  final String? email;
  final String? phone;
  final int diveCount;
  final DateTime? joinedAt;
  final String? bloodType;
  final DateTime? birthdate;
  final String? addressStreet;
  final String? addressCity;
  final String? addressState;
  final String? addressPostcode;
  final String? addressCountry;

  Diver({
    required this.id,
    required this.firstname,
    required this.lastname,
    this.email,
    this.phone,
    this.diveCount = 0,
    this.joinedAt,
    this.bloodType,
    this.birthdate,
    this.addressStreet,
    this.addressCity,
    this.addressState,
    this.addressPostcode,
    this.addressCountry,
  });

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

  /// Create a copy with modified fields
  Diver copyWith({
    String? id,
    String? firstname,
    String? lastname,
    String? email,
    String? phone,
    int? diveCount,
    DateTime? joinedAt,
    String? bloodType,
    DateTime? birthdate,
    String? addressStreet,
    String? addressCity,
    String? addressState,
    String? addressPostcode,
    String? addressCountry,
  }) {
    return Diver(
      id: id ?? this.id,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      diveCount: diveCount ?? this.diveCount,
      joinedAt: joinedAt ?? this.joinedAt,
      bloodType: bloodType ?? this.bloodType,
      birthdate: birthdate ?? this.birthdate,
      addressStreet: addressStreet ?? this.addressStreet,
      addressCity: addressCity ?? this.addressCity,
      addressState: addressState ?? this.addressState,
      addressPostcode: addressPostcode ?? this.addressPostcode,
      addressCountry: addressCountry ?? this.addressCountry,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Diver && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
