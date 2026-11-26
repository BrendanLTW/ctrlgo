// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'geo_position.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GeoPosition {

 double get lat; double get lng; DateTime get timestamp;/// Horizontal accuracy radius in metres.
 double get accuracyM;/// Degrees clockwise from north; null when unknown.
 double? get headingDeg; double? get speedKmh;
/// Create a copy of GeoPosition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeoPositionCopyWith<GeoPosition> get copyWith => _$GeoPositionCopyWithImpl<GeoPosition>(this as GeoPosition, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GeoPosition;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeoPosition&&(identical(other.lat, _this.lat) || other.lat == _this.lat)&&(identical(other.lng, _this.lng) || other.lng == _this.lng)&&(identical(other.timestamp, _this.timestamp) || other.timestamp == _this.timestamp)&&(identical(other.accuracyM, _this.accuracyM) || other.accuracyM == _this.accuracyM)&&(identical(other.headingDeg, _this.headingDeg) || other.headingDeg == _this.headingDeg)&&(identical(other.speedKmh, _this.speedKmh) || other.speedKmh == _this.speedKmh));
}


@override
int get hashCode {
  final _this = this as GeoPosition;
  return Object.hash(runtimeType,_this.lat,_this.lng,_this.timestamp,_this.accuracyM,_this.headingDeg,_this.speedKmh);
}

@override
String toString() {
  final _this = this as GeoPosition;
  return 'GeoPosition(lat: ${_this.lat}, lng: ${_this.lng}, timestamp: ${_this.timestamp}, accuracyM: ${_this.accuracyM}, headingDeg: ${_this.headingDeg}, speedKmh: ${_this.speedKmh})';
}


}

/// @nodoc
abstract mixin class $GeoPositionCopyWith<$Res>  {
  factory $GeoPositionCopyWith(GeoPosition value, $Res Function(GeoPosition) _then) = _$GeoPositionCopyWithImpl;
@useResult
$Res call({
 double lat, double lng, DateTime timestamp, double accuracyM, double? headingDeg, double? speedKmh
});




}
/// @nodoc
class _$GeoPositionCopyWithImpl<$Res>
    implements $GeoPositionCopyWith<$Res> {
  _$GeoPositionCopyWithImpl(this._self, this._then);

  final GeoPosition _self;
  final $Res Function(GeoPosition) _then;

/// Create a copy of GeoPosition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lat = null,Object? lng = null,Object? timestamp = null,Object? accuracyM = null,Object? headingDeg = freezed,Object? speedKmh = freezed,}) {
  return _then(GeoPosition(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,accuracyM: null == accuracyM ? _self.accuracyM : accuracyM // ignore: cast_nullable_to_non_nullable
as double,headingDeg: freezed == headingDeg ? _self.headingDeg : headingDeg // ignore: cast_nullable_to_non_nullable
as double?,speedKmh: freezed == speedKmh ? _self.speedKmh : speedKmh // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [GeoPosition].
extension GeoPositionPatterns on GeoPosition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GeoPosition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GeoPosition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GeoPosition value)  $default,){
final _that = this;
switch (_that) {
case _GeoPosition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GeoPosition value)?  $default,){
final _that = this;
switch (_that) {
case _GeoPosition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double lat,  double lng,  DateTime timestamp,  double accuracyM,  double? headingDeg,  double? speedKmh)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GeoPosition() when $default != null:
return $default(_that.lat,_that.lng,_that.timestamp,_that.accuracyM,_that.headingDeg,_that.speedKmh);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double lat,  double lng,  DateTime timestamp,  double accuracyM,  double? headingDeg,  double? speedKmh)  $default,) {final _that = this;
switch (_that) {
case _GeoPosition():
return $default(_that.lat,_that.lng,_that.timestamp,_that.accuracyM,_that.headingDeg,_that.speedKmh);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double lat,  double lng,  DateTime timestamp,  double accuracyM,  double? headingDeg,  double? speedKmh)?  $default,) {final _that = this;
switch (_that) {
case _GeoPosition() when $default != null:
return $default(_that.lat,_that.lng,_that.timestamp,_that.accuracyM,_that.headingDeg,_that.speedKmh);case _:
  return null;

}
}

}

/// @nodoc


class _GeoPosition implements GeoPosition {
  const _GeoPosition({required this.lat, required this.lng, required this.timestamp, this.accuracyM = 0, this.headingDeg, this.speedKmh});
  

@override final  double lat;
@override final  double lng;
@override final  DateTime timestamp;
/// Horizontal accuracy radius in metres.
@override@JsonKey() final  double accuracyM;
/// Degrees clockwise from north; null when unknown.
@override final  double? headingDeg;
@override final  double? speedKmh;

/// Create a copy of GeoPosition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GeoPositionCopyWith<_GeoPosition> get copyWith => __$GeoPositionCopyWithImpl<_GeoPosition>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeoPosition&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.accuracyM, accuracyM) || other.accuracyM == accuracyM)&&(identical(other.headingDeg, headingDeg) || other.headingDeg == headingDeg)&&(identical(other.speedKmh, speedKmh) || other.speedKmh == speedKmh));
}


@override
int get hashCode {
    return Object.hash(runtimeType,lat,lng,timestamp,accuracyM,headingDeg,speedKmh);
}

@override
String toString() {
    return 'GeoPosition(lat: $lat, lng: $lng, timestamp: $timestamp, accuracyM: $accuracyM, headingDeg: $headingDeg, speedKmh: $speedKmh)';
}


}

/// @nodoc
abstract mixin class _$GeoPositionCopyWith<$Res> implements $GeoPositionCopyWith<$Res> {
  factory _$GeoPositionCopyWith(_GeoPosition value, $Res Function(_GeoPosition) _then) = __$GeoPositionCopyWithImpl;
@override @useResult
$Res call({
 double lat, double lng, DateTime timestamp, double accuracyM, double? headingDeg, double? speedKmh
});




}
/// @nodoc
class __$GeoPositionCopyWithImpl<$Res>
    implements _$GeoPositionCopyWith<$Res> {
  __$GeoPositionCopyWithImpl(this._self, this._then);

  final _GeoPosition _self;
  final $Res Function(_GeoPosition) _then;

/// Create a copy of GeoPosition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lat = null,Object? lng = null,Object? timestamp = null,Object? accuracyM = null,Object? headingDeg = freezed,Object? speedKmh = freezed,}) {
  return _then(_GeoPosition(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,accuracyM: null == accuracyM ? _self.accuracyM : accuracyM // ignore: cast_nullable_to_non_nullable
as double,headingDeg: freezed == headingDeg ? _self.headingDeg : headingDeg // ignore: cast_nullable_to_non_nullable
as double?,speedKmh: freezed == speedKmh ? _self.speedKmh : speedKmh // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
