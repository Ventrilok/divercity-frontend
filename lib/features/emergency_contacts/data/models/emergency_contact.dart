/// Simple EmergencyContact model for mockup
/// This is a plain Dart class (not Freezed) for rapid prototyping
class EmergencyContact {
  final String id;
  final String name;
  final String relationship;
  final String phone;
  final String? email;
  final String? address;
  final String? notes;

  EmergencyContact({
    required this.id,
    required this.name,
    required this.relationship,
    required this.phone,
    this.email,
    this.address,
    this.notes,
  });

  /// Format phone for display
  String get formattedPhone {
    // Simple formatting - can be enhanced later
    if (phone.length == 10) {
      return '(${phone.substring(0, 3)}) ${phone.substring(3, 6)}-${phone.substring(6)}';
    }
    return phone;
  }

  /// Create a copy with modified fields
  EmergencyContact copyWith({
    String? id,
    String? name,
    String? relationship,
    String? phone,
    String? email,
    String? address,
    String? notes,
  }) {
    return EmergencyContact(
      id: id ?? this.id,
      name: name ?? this.name,
      relationship: relationship ?? this.relationship,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      notes: notes ?? this.notes,
    );
  }

  /// Convert to JSON for persistence
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'relationship': relationship,
      'phone': phone,
      'email': email,
      'address': address,
      'notes': notes,
    };
  }

  /// Create from JSON
  factory EmergencyContact.fromJson(Map<String, dynamic> json) {
    return EmergencyContact(
      id: json['id'] as String,
      name: json['name'] as String,
      relationship: json['relationship'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String?,
      address: json['address'] as String?,
      notes: json['notes'] as String?,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EmergencyContact && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
