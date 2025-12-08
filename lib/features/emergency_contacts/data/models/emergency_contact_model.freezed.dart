// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'emergency_contact_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EmergencyContactModel {

 String get id; String get name; String get relationship; String get phone; String? get email; String? get address; String? get notes;@JsonKey(name: 'is_favorite') bool get isFavorite;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;
/// Create a copy of EmergencyContactModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmergencyContactModelCopyWith<EmergencyContactModel> get copyWith => _$EmergencyContactModelCopyWithImpl<EmergencyContactModel>(this as EmergencyContactModel, _$identity);

  /// Serializes this EmergencyContactModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmergencyContactModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.relationship, relationship) || other.relationship == relationship)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.address, address) || other.address == address)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,relationship,phone,email,address,notes,isFavorite,createdAt,updatedAt);

@override
String toString() {
  return 'EmergencyContactModel(id: $id, name: $name, relationship: $relationship, phone: $phone, email: $email, address: $address, notes: $notes, isFavorite: $isFavorite, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $EmergencyContactModelCopyWith<$Res>  {
  factory $EmergencyContactModelCopyWith(EmergencyContactModel value, $Res Function(EmergencyContactModel) _then) = _$EmergencyContactModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String relationship, String phone, String? email, String? address, String? notes,@JsonKey(name: 'is_favorite') bool isFavorite,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class _$EmergencyContactModelCopyWithImpl<$Res>
    implements $EmergencyContactModelCopyWith<$Res> {
  _$EmergencyContactModelCopyWithImpl(this._self, this._then);

  final EmergencyContactModel _self;
  final $Res Function(EmergencyContactModel) _then;

/// Create a copy of EmergencyContactModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? relationship = null,Object? phone = null,Object? email = freezed,Object? address = freezed,Object? notes = freezed,Object? isFavorite = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,relationship: null == relationship ? _self.relationship : relationship // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [EmergencyContactModel].
extension EmergencyContactModelPatterns on EmergencyContactModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmergencyContactModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmergencyContactModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmergencyContactModel value)  $default,){
final _that = this;
switch (_that) {
case _EmergencyContactModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmergencyContactModel value)?  $default,){
final _that = this;
switch (_that) {
case _EmergencyContactModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String relationship,  String phone,  String? email,  String? address,  String? notes, @JsonKey(name: 'is_favorite')  bool isFavorite, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmergencyContactModel() when $default != null:
return $default(_that.id,_that.name,_that.relationship,_that.phone,_that.email,_that.address,_that.notes,_that.isFavorite,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String relationship,  String phone,  String? email,  String? address,  String? notes, @JsonKey(name: 'is_favorite')  bool isFavorite, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _EmergencyContactModel():
return $default(_that.id,_that.name,_that.relationship,_that.phone,_that.email,_that.address,_that.notes,_that.isFavorite,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String relationship,  String phone,  String? email,  String? address,  String? notes, @JsonKey(name: 'is_favorite')  bool isFavorite, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _EmergencyContactModel() when $default != null:
return $default(_that.id,_that.name,_that.relationship,_that.phone,_that.email,_that.address,_that.notes,_that.isFavorite,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EmergencyContactModel extends EmergencyContactModel {
  const _EmergencyContactModel({required this.id, required this.name, required this.relationship, required this.phone, this.email, this.address, this.notes, @JsonKey(name: 'is_favorite') this.isFavorite = false, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt}): super._();
  factory _EmergencyContactModel.fromJson(Map<String, dynamic> json) => _$EmergencyContactModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String relationship;
@override final  String phone;
@override final  String? email;
@override final  String? address;
@override final  String? notes;
@override@JsonKey(name: 'is_favorite') final  bool isFavorite;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;

/// Create a copy of EmergencyContactModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmergencyContactModelCopyWith<_EmergencyContactModel> get copyWith => __$EmergencyContactModelCopyWithImpl<_EmergencyContactModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmergencyContactModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmergencyContactModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.relationship, relationship) || other.relationship == relationship)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.address, address) || other.address == address)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,relationship,phone,email,address,notes,isFavorite,createdAt,updatedAt);

@override
String toString() {
  return 'EmergencyContactModel(id: $id, name: $name, relationship: $relationship, phone: $phone, email: $email, address: $address, notes: $notes, isFavorite: $isFavorite, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$EmergencyContactModelCopyWith<$Res> implements $EmergencyContactModelCopyWith<$Res> {
  factory _$EmergencyContactModelCopyWith(_EmergencyContactModel value, $Res Function(_EmergencyContactModel) _then) = __$EmergencyContactModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String relationship, String phone, String? email, String? address, String? notes,@JsonKey(name: 'is_favorite') bool isFavorite,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class __$EmergencyContactModelCopyWithImpl<$Res>
    implements _$EmergencyContactModelCopyWith<$Res> {
  __$EmergencyContactModelCopyWithImpl(this._self, this._then);

  final _EmergencyContactModel _self;
  final $Res Function(_EmergencyContactModel) _then;

/// Create a copy of EmergencyContactModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? relationship = null,Object? phone = null,Object? email = freezed,Object? address = freezed,Object? notes = freezed,Object? isFavorite = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_EmergencyContactModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,relationship: null == relationship ? _self.relationship : relationship // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
