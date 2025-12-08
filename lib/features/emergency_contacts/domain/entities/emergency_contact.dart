import 'package:freezed_annotation/freezed_annotation.dart';

part 'emergency_contact.freezed.dart';

/// Domain entity for Emergency Contact
/// Represents an emergency contact in the business logic layer
@freezed
class EmergencyContact with _$EmergencyContact {
  const EmergencyContact._();

  const factory EmergencyContact({
    required String id,
    required String name,
    required String relationship,
    required String phone,
    String? email,
    String? address,
    String? notes,
    @Default(false) bool isFavorite,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _EmergencyContact;

  /// Format phone for display
  String get formattedPhone {
    // Simple formatting - can be enhanced later
    if (phone.length == 10) {
      return '(${phone.substring(0, 3)}) ${phone.substring(3, 6)}-${phone.substring(6)}';
    }
    return phone;
  }
}
