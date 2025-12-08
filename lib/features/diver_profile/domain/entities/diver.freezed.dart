// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diver.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Diver {

 String get id; String get firstname; String get lastname; String get email; String? get phone; String? get bloodType; DateTime? get birthdate; String? get addressStreet; String? get addressCity; String? get addressState; String? get addressPostcode; String? get addressCountry; int get diveCount; DateTime? get joinedAt;
/// Create a copy of Diver
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiverCopyWith<Diver> get copyWith => _$DiverCopyWithImpl<Diver>(this as Diver, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Diver&&(identical(other.id, id) || other.id == id)&&(identical(other.firstname, firstname) || other.firstname == firstname)&&(identical(other.lastname, lastname) || other.lastname == lastname)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.bloodType, bloodType) || other.bloodType == bloodType)&&(identical(other.birthdate, birthdate) || other.birthdate == birthdate)&&(identical(other.addressStreet, addressStreet) || other.addressStreet == addressStreet)&&(identical(other.addressCity, addressCity) || other.addressCity == addressCity)&&(identical(other.addressState, addressState) || other.addressState == addressState)&&(identical(other.addressPostcode, addressPostcode) || other.addressPostcode == addressPostcode)&&(identical(other.addressCountry, addressCountry) || other.addressCountry == addressCountry)&&(identical(other.diveCount, diveCount) || other.diveCount == diveCount)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,firstname,lastname,email,phone,bloodType,birthdate,addressStreet,addressCity,addressState,addressPostcode,addressCountry,diveCount,joinedAt);

@override
String toString() {
  return 'Diver(id: $id, firstname: $firstname, lastname: $lastname, email: $email, phone: $phone, bloodType: $bloodType, birthdate: $birthdate, addressStreet: $addressStreet, addressCity: $addressCity, addressState: $addressState, addressPostcode: $addressPostcode, addressCountry: $addressCountry, diveCount: $diveCount, joinedAt: $joinedAt)';
}


}

/// @nodoc
abstract mixin class $DiverCopyWith<$Res>  {
  factory $DiverCopyWith(Diver value, $Res Function(Diver) _then) = _$DiverCopyWithImpl;
@useResult
$Res call({
 String id, String firstname, String lastname, String email, String? phone, String? bloodType, DateTime? birthdate, String? addressStreet, String? addressCity, String? addressState, String? addressPostcode, String? addressCountry, int diveCount, DateTime? joinedAt
});




}
/// @nodoc
class _$DiverCopyWithImpl<$Res>
    implements $DiverCopyWith<$Res> {
  _$DiverCopyWithImpl(this._self, this._then);

  final Diver _self;
  final $Res Function(Diver) _then;

/// Create a copy of Diver
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? firstname = null,Object? lastname = null,Object? email = null,Object? phone = freezed,Object? bloodType = freezed,Object? birthdate = freezed,Object? addressStreet = freezed,Object? addressCity = freezed,Object? addressState = freezed,Object? addressPostcode = freezed,Object? addressCountry = freezed,Object? diveCount = null,Object? joinedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,firstname: null == firstname ? _self.firstname : firstname // ignore: cast_nullable_to_non_nullable
as String,lastname: null == lastname ? _self.lastname : lastname // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,bloodType: freezed == bloodType ? _self.bloodType : bloodType // ignore: cast_nullable_to_non_nullable
as String?,birthdate: freezed == birthdate ? _self.birthdate : birthdate // ignore: cast_nullable_to_non_nullable
as DateTime?,addressStreet: freezed == addressStreet ? _self.addressStreet : addressStreet // ignore: cast_nullable_to_non_nullable
as String?,addressCity: freezed == addressCity ? _self.addressCity : addressCity // ignore: cast_nullable_to_non_nullable
as String?,addressState: freezed == addressState ? _self.addressState : addressState // ignore: cast_nullable_to_non_nullable
as String?,addressPostcode: freezed == addressPostcode ? _self.addressPostcode : addressPostcode // ignore: cast_nullable_to_non_nullable
as String?,addressCountry: freezed == addressCountry ? _self.addressCountry : addressCountry // ignore: cast_nullable_to_non_nullable
as String?,diveCount: null == diveCount ? _self.diveCount : diveCount // ignore: cast_nullable_to_non_nullable
as int,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Diver].
extension DiverPatterns on Diver {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Diver value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Diver() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Diver value)  $default,){
final _that = this;
switch (_that) {
case _Diver():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Diver value)?  $default,){
final _that = this;
switch (_that) {
case _Diver() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String firstname,  String lastname,  String email,  String? phone,  String? bloodType,  DateTime? birthdate,  String? addressStreet,  String? addressCity,  String? addressState,  String? addressPostcode,  String? addressCountry,  int diveCount,  DateTime? joinedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Diver() when $default != null:
return $default(_that.id,_that.firstname,_that.lastname,_that.email,_that.phone,_that.bloodType,_that.birthdate,_that.addressStreet,_that.addressCity,_that.addressState,_that.addressPostcode,_that.addressCountry,_that.diveCount,_that.joinedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String firstname,  String lastname,  String email,  String? phone,  String? bloodType,  DateTime? birthdate,  String? addressStreet,  String? addressCity,  String? addressState,  String? addressPostcode,  String? addressCountry,  int diveCount,  DateTime? joinedAt)  $default,) {final _that = this;
switch (_that) {
case _Diver():
return $default(_that.id,_that.firstname,_that.lastname,_that.email,_that.phone,_that.bloodType,_that.birthdate,_that.addressStreet,_that.addressCity,_that.addressState,_that.addressPostcode,_that.addressCountry,_that.diveCount,_that.joinedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String firstname,  String lastname,  String email,  String? phone,  String? bloodType,  DateTime? birthdate,  String? addressStreet,  String? addressCity,  String? addressState,  String? addressPostcode,  String? addressCountry,  int diveCount,  DateTime? joinedAt)?  $default,) {final _that = this;
switch (_that) {
case _Diver() when $default != null:
return $default(_that.id,_that.firstname,_that.lastname,_that.email,_that.phone,_that.bloodType,_that.birthdate,_that.addressStreet,_that.addressCity,_that.addressState,_that.addressPostcode,_that.addressCountry,_that.diveCount,_that.joinedAt);case _:
  return null;

}
}

}

/// @nodoc


class _Diver extends Diver {
  const _Diver({required this.id, required this.firstname, required this.lastname, required this.email, this.phone, this.bloodType, this.birthdate, this.addressStreet, this.addressCity, this.addressState, this.addressPostcode, this.addressCountry, this.diveCount = 0, this.joinedAt}): super._();
  

@override final  String id;
@override final  String firstname;
@override final  String lastname;
@override final  String email;
@override final  String? phone;
@override final  String? bloodType;
@override final  DateTime? birthdate;
@override final  String? addressStreet;
@override final  String? addressCity;
@override final  String? addressState;
@override final  String? addressPostcode;
@override final  String? addressCountry;
@override@JsonKey() final  int diveCount;
@override final  DateTime? joinedAt;

/// Create a copy of Diver
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiverCopyWith<_Diver> get copyWith => __$DiverCopyWithImpl<_Diver>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Diver&&(identical(other.id, id) || other.id == id)&&(identical(other.firstname, firstname) || other.firstname == firstname)&&(identical(other.lastname, lastname) || other.lastname == lastname)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.bloodType, bloodType) || other.bloodType == bloodType)&&(identical(other.birthdate, birthdate) || other.birthdate == birthdate)&&(identical(other.addressStreet, addressStreet) || other.addressStreet == addressStreet)&&(identical(other.addressCity, addressCity) || other.addressCity == addressCity)&&(identical(other.addressState, addressState) || other.addressState == addressState)&&(identical(other.addressPostcode, addressPostcode) || other.addressPostcode == addressPostcode)&&(identical(other.addressCountry, addressCountry) || other.addressCountry == addressCountry)&&(identical(other.diveCount, diveCount) || other.diveCount == diveCount)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,firstname,lastname,email,phone,bloodType,birthdate,addressStreet,addressCity,addressState,addressPostcode,addressCountry,diveCount,joinedAt);

@override
String toString() {
  return 'Diver(id: $id, firstname: $firstname, lastname: $lastname, email: $email, phone: $phone, bloodType: $bloodType, birthdate: $birthdate, addressStreet: $addressStreet, addressCity: $addressCity, addressState: $addressState, addressPostcode: $addressPostcode, addressCountry: $addressCountry, diveCount: $diveCount, joinedAt: $joinedAt)';
}


}

/// @nodoc
abstract mixin class _$DiverCopyWith<$Res> implements $DiverCopyWith<$Res> {
  factory _$DiverCopyWith(_Diver value, $Res Function(_Diver) _then) = __$DiverCopyWithImpl;
@override @useResult
$Res call({
 String id, String firstname, String lastname, String email, String? phone, String? bloodType, DateTime? birthdate, String? addressStreet, String? addressCity, String? addressState, String? addressPostcode, String? addressCountry, int diveCount, DateTime? joinedAt
});




}
/// @nodoc
class __$DiverCopyWithImpl<$Res>
    implements _$DiverCopyWith<$Res> {
  __$DiverCopyWithImpl(this._self, this._then);

  final _Diver _self;
  final $Res Function(_Diver) _then;

/// Create a copy of Diver
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? firstname = null,Object? lastname = null,Object? email = null,Object? phone = freezed,Object? bloodType = freezed,Object? birthdate = freezed,Object? addressStreet = freezed,Object? addressCity = freezed,Object? addressState = freezed,Object? addressPostcode = freezed,Object? addressCountry = freezed,Object? diveCount = null,Object? joinedAt = freezed,}) {
  return _then(_Diver(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,firstname: null == firstname ? _self.firstname : firstname // ignore: cast_nullable_to_non_nullable
as String,lastname: null == lastname ? _self.lastname : lastname // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,bloodType: freezed == bloodType ? _self.bloodType : bloodType // ignore: cast_nullable_to_non_nullable
as String?,birthdate: freezed == birthdate ? _self.birthdate : birthdate // ignore: cast_nullable_to_non_nullable
as DateTime?,addressStreet: freezed == addressStreet ? _self.addressStreet : addressStreet // ignore: cast_nullable_to_non_nullable
as String?,addressCity: freezed == addressCity ? _self.addressCity : addressCity // ignore: cast_nullable_to_non_nullable
as String?,addressState: freezed == addressState ? _self.addressState : addressState // ignore: cast_nullable_to_non_nullable
as String?,addressPostcode: freezed == addressPostcode ? _self.addressPostcode : addressPostcode // ignore: cast_nullable_to_non_nullable
as String?,addressCountry: freezed == addressCountry ? _self.addressCountry : addressCountry // ignore: cast_nullable_to_non_nullable
as String?,diveCount: null == diveCount ? _self.diveCount : diveCount // ignore: cast_nullable_to_non_nullable
as int,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
