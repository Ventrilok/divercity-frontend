// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dive_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DiveLog {

 String get id; String get diveSite; String get location; DateTime get diveDate; double get maxDepth; int get duration; double? get waterTemperature; double? get airTemperature; double? get entryPressure; double? get exitPressure; String? get gasMix; String? get notes; bool get isFavorite; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of DiveLog
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiveLogCopyWith<DiveLog> get copyWith => _$DiveLogCopyWithImpl<DiveLog>(this as DiveLog, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiveLog&&(identical(other.id, id) || other.id == id)&&(identical(other.diveSite, diveSite) || other.diveSite == diveSite)&&(identical(other.location, location) || other.location == location)&&(identical(other.diveDate, diveDate) || other.diveDate == diveDate)&&(identical(other.maxDepth, maxDepth) || other.maxDepth == maxDepth)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.waterTemperature, waterTemperature) || other.waterTemperature == waterTemperature)&&(identical(other.airTemperature, airTemperature) || other.airTemperature == airTemperature)&&(identical(other.entryPressure, entryPressure) || other.entryPressure == entryPressure)&&(identical(other.exitPressure, exitPressure) || other.exitPressure == exitPressure)&&(identical(other.gasMix, gasMix) || other.gasMix == gasMix)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,diveSite,location,diveDate,maxDepth,duration,waterTemperature,airTemperature,entryPressure,exitPressure,gasMix,notes,isFavorite,createdAt,updatedAt);

@override
String toString() {
  return 'DiveLog(id: $id, diveSite: $diveSite, location: $location, diveDate: $diveDate, maxDepth: $maxDepth, duration: $duration, waterTemperature: $waterTemperature, airTemperature: $airTemperature, entryPressure: $entryPressure, exitPressure: $exitPressure, gasMix: $gasMix, notes: $notes, isFavorite: $isFavorite, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $DiveLogCopyWith<$Res>  {
  factory $DiveLogCopyWith(DiveLog value, $Res Function(DiveLog) _then) = _$DiveLogCopyWithImpl;
@useResult
$Res call({
 String id, String diveSite, String location, DateTime diveDate, double maxDepth, int duration, double? waterTemperature, double? airTemperature, double? entryPressure, double? exitPressure, String? gasMix, String? notes, bool isFavorite, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$DiveLogCopyWithImpl<$Res>
    implements $DiveLogCopyWith<$Res> {
  _$DiveLogCopyWithImpl(this._self, this._then);

  final DiveLog _self;
  final $Res Function(DiveLog) _then;

/// Create a copy of DiveLog
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? diveSite = null,Object? location = null,Object? diveDate = null,Object? maxDepth = null,Object? duration = null,Object? waterTemperature = freezed,Object? airTemperature = freezed,Object? entryPressure = freezed,Object? exitPressure = freezed,Object? gasMix = freezed,Object? notes = freezed,Object? isFavorite = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,diveSite: null == diveSite ? _self.diveSite : diveSite // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,diveDate: null == diveDate ? _self.diveDate : diveDate // ignore: cast_nullable_to_non_nullable
as DateTime,maxDepth: null == maxDepth ? _self.maxDepth : maxDepth // ignore: cast_nullable_to_non_nullable
as double,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,waterTemperature: freezed == waterTemperature ? _self.waterTemperature : waterTemperature // ignore: cast_nullable_to_non_nullable
as double?,airTemperature: freezed == airTemperature ? _self.airTemperature : airTemperature // ignore: cast_nullable_to_non_nullable
as double?,entryPressure: freezed == entryPressure ? _self.entryPressure : entryPressure // ignore: cast_nullable_to_non_nullable
as double?,exitPressure: freezed == exitPressure ? _self.exitPressure : exitPressure // ignore: cast_nullable_to_non_nullable
as double?,gasMix: freezed == gasMix ? _self.gasMix : gasMix // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [DiveLog].
extension DiveLogPatterns on DiveLog {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiveLog value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiveLog() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiveLog value)  $default,){
final _that = this;
switch (_that) {
case _DiveLog():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiveLog value)?  $default,){
final _that = this;
switch (_that) {
case _DiveLog() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String diveSite,  String location,  DateTime diveDate,  double maxDepth,  int duration,  double? waterTemperature,  double? airTemperature,  double? entryPressure,  double? exitPressure,  String? gasMix,  String? notes,  bool isFavorite,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiveLog() when $default != null:
return $default(_that.id,_that.diveSite,_that.location,_that.diveDate,_that.maxDepth,_that.duration,_that.waterTemperature,_that.airTemperature,_that.entryPressure,_that.exitPressure,_that.gasMix,_that.notes,_that.isFavorite,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String diveSite,  String location,  DateTime diveDate,  double maxDepth,  int duration,  double? waterTemperature,  double? airTemperature,  double? entryPressure,  double? exitPressure,  String? gasMix,  String? notes,  bool isFavorite,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _DiveLog():
return $default(_that.id,_that.diveSite,_that.location,_that.diveDate,_that.maxDepth,_that.duration,_that.waterTemperature,_that.airTemperature,_that.entryPressure,_that.exitPressure,_that.gasMix,_that.notes,_that.isFavorite,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String diveSite,  String location,  DateTime diveDate,  double maxDepth,  int duration,  double? waterTemperature,  double? airTemperature,  double? entryPressure,  double? exitPressure,  String? gasMix,  String? notes,  bool isFavorite,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _DiveLog() when $default != null:
return $default(_that.id,_that.diveSite,_that.location,_that.diveDate,_that.maxDepth,_that.duration,_that.waterTemperature,_that.airTemperature,_that.entryPressure,_that.exitPressure,_that.gasMix,_that.notes,_that.isFavorite,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _DiveLog extends DiveLog {
  const _DiveLog({required this.id, required this.diveSite, required this.location, required this.diveDate, required this.maxDepth, required this.duration, this.waterTemperature, this.airTemperature, this.entryPressure, this.exitPressure, this.gasMix, this.notes, this.isFavorite = false, this.createdAt, this.updatedAt}): super._();
  

@override final  String id;
@override final  String diveSite;
@override final  String location;
@override final  DateTime diveDate;
@override final  double maxDepth;
@override final  int duration;
@override final  double? waterTemperature;
@override final  double? airTemperature;
@override final  double? entryPressure;
@override final  double? exitPressure;
@override final  String? gasMix;
@override final  String? notes;
@override@JsonKey() final  bool isFavorite;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of DiveLog
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiveLogCopyWith<_DiveLog> get copyWith => __$DiveLogCopyWithImpl<_DiveLog>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiveLog&&(identical(other.id, id) || other.id == id)&&(identical(other.diveSite, diveSite) || other.diveSite == diveSite)&&(identical(other.location, location) || other.location == location)&&(identical(other.diveDate, diveDate) || other.diveDate == diveDate)&&(identical(other.maxDepth, maxDepth) || other.maxDepth == maxDepth)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.waterTemperature, waterTemperature) || other.waterTemperature == waterTemperature)&&(identical(other.airTemperature, airTemperature) || other.airTemperature == airTemperature)&&(identical(other.entryPressure, entryPressure) || other.entryPressure == entryPressure)&&(identical(other.exitPressure, exitPressure) || other.exitPressure == exitPressure)&&(identical(other.gasMix, gasMix) || other.gasMix == gasMix)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,diveSite,location,diveDate,maxDepth,duration,waterTemperature,airTemperature,entryPressure,exitPressure,gasMix,notes,isFavorite,createdAt,updatedAt);

@override
String toString() {
  return 'DiveLog(id: $id, diveSite: $diveSite, location: $location, diveDate: $diveDate, maxDepth: $maxDepth, duration: $duration, waterTemperature: $waterTemperature, airTemperature: $airTemperature, entryPressure: $entryPressure, exitPressure: $exitPressure, gasMix: $gasMix, notes: $notes, isFavorite: $isFavorite, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$DiveLogCopyWith<$Res> implements $DiveLogCopyWith<$Res> {
  factory _$DiveLogCopyWith(_DiveLog value, $Res Function(_DiveLog) _then) = __$DiveLogCopyWithImpl;
@override @useResult
$Res call({
 String id, String diveSite, String location, DateTime diveDate, double maxDepth, int duration, double? waterTemperature, double? airTemperature, double? entryPressure, double? exitPressure, String? gasMix, String? notes, bool isFavorite, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$DiveLogCopyWithImpl<$Res>
    implements _$DiveLogCopyWith<$Res> {
  __$DiveLogCopyWithImpl(this._self, this._then);

  final _DiveLog _self;
  final $Res Function(_DiveLog) _then;

/// Create a copy of DiveLog
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? diveSite = null,Object? location = null,Object? diveDate = null,Object? maxDepth = null,Object? duration = null,Object? waterTemperature = freezed,Object? airTemperature = freezed,Object? entryPressure = freezed,Object? exitPressure = freezed,Object? gasMix = freezed,Object? notes = freezed,Object? isFavorite = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_DiveLog(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,diveSite: null == diveSite ? _self.diveSite : diveSite // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,diveDate: null == diveDate ? _self.diveDate : diveDate // ignore: cast_nullable_to_non_nullable
as DateTime,maxDepth: null == maxDepth ? _self.maxDepth : maxDepth // ignore: cast_nullable_to_non_nullable
as double,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,waterTemperature: freezed == waterTemperature ? _self.waterTemperature : waterTemperature // ignore: cast_nullable_to_non_nullable
as double?,airTemperature: freezed == airTemperature ? _self.airTemperature : airTemperature // ignore: cast_nullable_to_non_nullable
as double?,entryPressure: freezed == entryPressure ? _self.entryPressure : entryPressure // ignore: cast_nullable_to_non_nullable
as double?,exitPressure: freezed == exitPressure ? _self.exitPressure : exitPressure // ignore: cast_nullable_to_non_nullable
as double?,gasMix: freezed == gasMix ? _self.gasMix : gasMix // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
