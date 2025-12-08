// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dive_log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DiveLogModel {

 String get id;@JsonKey(name: 'dive_site') String get diveSite; String get location;@JsonKey(name: 'dive_date') DateTime get diveDate;@JsonKey(name: 'max_depth') double get maxDepth; int get duration;@JsonKey(name: 'water_temperature') double? get waterTemperature;@JsonKey(name: 'air_temperature') double? get airTemperature;@JsonKey(name: 'entry_pressure') double? get entryPressure;@JsonKey(name: 'exit_pressure') double? get exitPressure;@JsonKey(name: 'gas_mix') String? get gasMix; String? get notes;@JsonKey(name: 'is_favorite') bool get isFavorite;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;
/// Create a copy of DiveLogModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiveLogModelCopyWith<DiveLogModel> get copyWith => _$DiveLogModelCopyWithImpl<DiveLogModel>(this as DiveLogModel, _$identity);

  /// Serializes this DiveLogModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiveLogModel&&(identical(other.id, id) || other.id == id)&&(identical(other.diveSite, diveSite) || other.diveSite == diveSite)&&(identical(other.location, location) || other.location == location)&&(identical(other.diveDate, diveDate) || other.diveDate == diveDate)&&(identical(other.maxDepth, maxDepth) || other.maxDepth == maxDepth)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.waterTemperature, waterTemperature) || other.waterTemperature == waterTemperature)&&(identical(other.airTemperature, airTemperature) || other.airTemperature == airTemperature)&&(identical(other.entryPressure, entryPressure) || other.entryPressure == entryPressure)&&(identical(other.exitPressure, exitPressure) || other.exitPressure == exitPressure)&&(identical(other.gasMix, gasMix) || other.gasMix == gasMix)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,diveSite,location,diveDate,maxDepth,duration,waterTemperature,airTemperature,entryPressure,exitPressure,gasMix,notes,isFavorite,createdAt,updatedAt);

@override
String toString() {
  return 'DiveLogModel(id: $id, diveSite: $diveSite, location: $location, diveDate: $diveDate, maxDepth: $maxDepth, duration: $duration, waterTemperature: $waterTemperature, airTemperature: $airTemperature, entryPressure: $entryPressure, exitPressure: $exitPressure, gasMix: $gasMix, notes: $notes, isFavorite: $isFavorite, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $DiveLogModelCopyWith<$Res>  {
  factory $DiveLogModelCopyWith(DiveLogModel value, $Res Function(DiveLogModel) _then) = _$DiveLogModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'dive_site') String diveSite, String location,@JsonKey(name: 'dive_date') DateTime diveDate,@JsonKey(name: 'max_depth') double maxDepth, int duration,@JsonKey(name: 'water_temperature') double? waterTemperature,@JsonKey(name: 'air_temperature') double? airTemperature,@JsonKey(name: 'entry_pressure') double? entryPressure,@JsonKey(name: 'exit_pressure') double? exitPressure,@JsonKey(name: 'gas_mix') String? gasMix, String? notes,@JsonKey(name: 'is_favorite') bool isFavorite,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class _$DiveLogModelCopyWithImpl<$Res>
    implements $DiveLogModelCopyWith<$Res> {
  _$DiveLogModelCopyWithImpl(this._self, this._then);

  final DiveLogModel _self;
  final $Res Function(DiveLogModel) _then;

/// Create a copy of DiveLogModel
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


/// Adds pattern-matching-related methods to [DiveLogModel].
extension DiveLogModelPatterns on DiveLogModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiveLogModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiveLogModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiveLogModel value)  $default,){
final _that = this;
switch (_that) {
case _DiveLogModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiveLogModel value)?  $default,){
final _that = this;
switch (_that) {
case _DiveLogModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'dive_site')  String diveSite,  String location, @JsonKey(name: 'dive_date')  DateTime diveDate, @JsonKey(name: 'max_depth')  double maxDepth,  int duration, @JsonKey(name: 'water_temperature')  double? waterTemperature, @JsonKey(name: 'air_temperature')  double? airTemperature, @JsonKey(name: 'entry_pressure')  double? entryPressure, @JsonKey(name: 'exit_pressure')  double? exitPressure, @JsonKey(name: 'gas_mix')  String? gasMix,  String? notes, @JsonKey(name: 'is_favorite')  bool isFavorite, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiveLogModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'dive_site')  String diveSite,  String location, @JsonKey(name: 'dive_date')  DateTime diveDate, @JsonKey(name: 'max_depth')  double maxDepth,  int duration, @JsonKey(name: 'water_temperature')  double? waterTemperature, @JsonKey(name: 'air_temperature')  double? airTemperature, @JsonKey(name: 'entry_pressure')  double? entryPressure, @JsonKey(name: 'exit_pressure')  double? exitPressure, @JsonKey(name: 'gas_mix')  String? gasMix,  String? notes, @JsonKey(name: 'is_favorite')  bool isFavorite, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _DiveLogModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'dive_site')  String diveSite,  String location, @JsonKey(name: 'dive_date')  DateTime diveDate, @JsonKey(name: 'max_depth')  double maxDepth,  int duration, @JsonKey(name: 'water_temperature')  double? waterTemperature, @JsonKey(name: 'air_temperature')  double? airTemperature, @JsonKey(name: 'entry_pressure')  double? entryPressure, @JsonKey(name: 'exit_pressure')  double? exitPressure, @JsonKey(name: 'gas_mix')  String? gasMix,  String? notes, @JsonKey(name: 'is_favorite')  bool isFavorite, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _DiveLogModel() when $default != null:
return $default(_that.id,_that.diveSite,_that.location,_that.diveDate,_that.maxDepth,_that.duration,_that.waterTemperature,_that.airTemperature,_that.entryPressure,_that.exitPressure,_that.gasMix,_that.notes,_that.isFavorite,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DiveLogModel extends DiveLogModel {
  const _DiveLogModel({required this.id, @JsonKey(name: 'dive_site') required this.diveSite, required this.location, @JsonKey(name: 'dive_date') required this.diveDate, @JsonKey(name: 'max_depth') required this.maxDepth, required this.duration, @JsonKey(name: 'water_temperature') this.waterTemperature, @JsonKey(name: 'air_temperature') this.airTemperature, @JsonKey(name: 'entry_pressure') this.entryPressure, @JsonKey(name: 'exit_pressure') this.exitPressure, @JsonKey(name: 'gas_mix') this.gasMix, this.notes, @JsonKey(name: 'is_favorite') this.isFavorite = false, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt}): super._();
  factory _DiveLogModel.fromJson(Map<String, dynamic> json) => _$DiveLogModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'dive_site') final  String diveSite;
@override final  String location;
@override@JsonKey(name: 'dive_date') final  DateTime diveDate;
@override@JsonKey(name: 'max_depth') final  double maxDepth;
@override final  int duration;
@override@JsonKey(name: 'water_temperature') final  double? waterTemperature;
@override@JsonKey(name: 'air_temperature') final  double? airTemperature;
@override@JsonKey(name: 'entry_pressure') final  double? entryPressure;
@override@JsonKey(name: 'exit_pressure') final  double? exitPressure;
@override@JsonKey(name: 'gas_mix') final  String? gasMix;
@override final  String? notes;
@override@JsonKey(name: 'is_favorite') final  bool isFavorite;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;

/// Create a copy of DiveLogModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiveLogModelCopyWith<_DiveLogModel> get copyWith => __$DiveLogModelCopyWithImpl<_DiveLogModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DiveLogModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiveLogModel&&(identical(other.id, id) || other.id == id)&&(identical(other.diveSite, diveSite) || other.diveSite == diveSite)&&(identical(other.location, location) || other.location == location)&&(identical(other.diveDate, diveDate) || other.diveDate == diveDate)&&(identical(other.maxDepth, maxDepth) || other.maxDepth == maxDepth)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.waterTemperature, waterTemperature) || other.waterTemperature == waterTemperature)&&(identical(other.airTemperature, airTemperature) || other.airTemperature == airTemperature)&&(identical(other.entryPressure, entryPressure) || other.entryPressure == entryPressure)&&(identical(other.exitPressure, exitPressure) || other.exitPressure == exitPressure)&&(identical(other.gasMix, gasMix) || other.gasMix == gasMix)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,diveSite,location,diveDate,maxDepth,duration,waterTemperature,airTemperature,entryPressure,exitPressure,gasMix,notes,isFavorite,createdAt,updatedAt);

@override
String toString() {
  return 'DiveLogModel(id: $id, diveSite: $diveSite, location: $location, diveDate: $diveDate, maxDepth: $maxDepth, duration: $duration, waterTemperature: $waterTemperature, airTemperature: $airTemperature, entryPressure: $entryPressure, exitPressure: $exitPressure, gasMix: $gasMix, notes: $notes, isFavorite: $isFavorite, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$DiveLogModelCopyWith<$Res> implements $DiveLogModelCopyWith<$Res> {
  factory _$DiveLogModelCopyWith(_DiveLogModel value, $Res Function(_DiveLogModel) _then) = __$DiveLogModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'dive_site') String diveSite, String location,@JsonKey(name: 'dive_date') DateTime diveDate,@JsonKey(name: 'max_depth') double maxDepth, int duration,@JsonKey(name: 'water_temperature') double? waterTemperature,@JsonKey(name: 'air_temperature') double? airTemperature,@JsonKey(name: 'entry_pressure') double? entryPressure,@JsonKey(name: 'exit_pressure') double? exitPressure,@JsonKey(name: 'gas_mix') String? gasMix, String? notes,@JsonKey(name: 'is_favorite') bool isFavorite,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class __$DiveLogModelCopyWithImpl<$Res>
    implements _$DiveLogModelCopyWith<$Res> {
  __$DiveLogModelCopyWithImpl(this._self, this._then);

  final _DiveLogModel _self;
  final $Res Function(_DiveLogModel) _then;

/// Create a copy of DiveLogModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? diveSite = null,Object? location = null,Object? diveDate = null,Object? maxDepth = null,Object? duration = null,Object? waterTemperature = freezed,Object? airTemperature = freezed,Object? entryPressure = freezed,Object? exitPressure = freezed,Object? gasMix = freezed,Object? notes = freezed,Object? isFavorite = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_DiveLogModel(
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
