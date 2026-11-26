// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place_suggestion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlaceSuggestion {

 String get placeId;/// The place's name, e.g. "Suria KLCC".
 String get mainText;/// Where [mainText] matches what was typed, as [start, end) offsets.
 List<({int end, int start,})> get matches;/// Area or address, e.g. "Jalan Ampang, Kuala Lumpur".
 String get secondaryText;/// Straight-line distance from the user, when known.
 int? get distanceM;/// Provider place types, most specific first.
 List<String> get types;
/// Create a copy of PlaceSuggestion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceSuggestionCopyWith<PlaceSuggestion> get copyWith => _$PlaceSuggestionCopyWithImpl<PlaceSuggestion>(this as PlaceSuggestion, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PlaceSuggestion;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceSuggestion&&(identical(other.placeId, _this.placeId) || other.placeId == _this.placeId)&&(identical(other.mainText, _this.mainText) || other.mainText == _this.mainText)&&const DeepCollectionEquality().equals(other.matches, _this.matches)&&(identical(other.secondaryText, _this.secondaryText) || other.secondaryText == _this.secondaryText)&&(identical(other.distanceM, _this.distanceM) || other.distanceM == _this.distanceM)&&const DeepCollectionEquality().equals(other.types, _this.types));
}


@override
int get hashCode {
  final _this = this as PlaceSuggestion;
  return Object.hash(runtimeType,_this.placeId,_this.mainText,const DeepCollectionEquality().hash(_this.matches),_this.secondaryText,_this.distanceM,const DeepCollectionEquality().hash(_this.types));
}

@override
String toString() {
  final _this = this as PlaceSuggestion;
  return 'PlaceSuggestion(placeId: ${_this.placeId}, mainText: ${_this.mainText}, matches: ${_this.matches}, secondaryText: ${_this.secondaryText}, distanceM: ${_this.distanceM}, types: ${_this.types})';
}


}

/// @nodoc
abstract mixin class $PlaceSuggestionCopyWith<$Res>  {
  factory $PlaceSuggestionCopyWith(PlaceSuggestion value, $Res Function(PlaceSuggestion) _then) = _$PlaceSuggestionCopyWithImpl;
@useResult
$Res call({
 String placeId, String mainText, List<({int end, int start,})> matches, String secondaryText, int? distanceM, List<String> types
});




}
/// @nodoc
class _$PlaceSuggestionCopyWithImpl<$Res>
    implements $PlaceSuggestionCopyWith<$Res> {
  _$PlaceSuggestionCopyWithImpl(this._self, this._then);

  final PlaceSuggestion _self;
  final $Res Function(PlaceSuggestion) _then;

/// Create a copy of PlaceSuggestion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? placeId = null,Object? mainText = null,Object? matches = null,Object? secondaryText = null,Object? distanceM = freezed,Object? types = null,}) {
  return _then(PlaceSuggestion(
placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,mainText: null == mainText ? _self.mainText : mainText // ignore: cast_nullable_to_non_nullable
as String,matches: null == matches ? _self.matches : matches // ignore: cast_nullable_to_non_nullable
as List<({int end, int start,})>,secondaryText: null == secondaryText ? _self.secondaryText : secondaryText // ignore: cast_nullable_to_non_nullable
as String,distanceM: freezed == distanceM ? _self.distanceM : distanceM // ignore: cast_nullable_to_non_nullable
as int?,types: null == types ? _self.types : types // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaceSuggestion].
extension PlaceSuggestionPatterns on PlaceSuggestion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceSuggestion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceSuggestion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceSuggestion value)  $default,){
final _that = this;
switch (_that) {
case _PlaceSuggestion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceSuggestion value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceSuggestion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String placeId,  String mainText,  List<({int end, int start,})> matches,  String secondaryText,  int? distanceM,  List<String> types)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceSuggestion() when $default != null:
return $default(_that.placeId,_that.mainText,_that.matches,_that.secondaryText,_that.distanceM,_that.types);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String placeId,  String mainText,  List<({int end, int start,})> matches,  String secondaryText,  int? distanceM,  List<String> types)  $default,) {final _that = this;
switch (_that) {
case _PlaceSuggestion():
return $default(_that.placeId,_that.mainText,_that.matches,_that.secondaryText,_that.distanceM,_that.types);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String placeId,  String mainText,  List<({int end, int start,})> matches,  String secondaryText,  int? distanceM,  List<String> types)?  $default,) {final _that = this;
switch (_that) {
case _PlaceSuggestion() when $default != null:
return $default(_that.placeId,_that.mainText,_that.matches,_that.secondaryText,_that.distanceM,_that.types);case _:
  return null;

}
}

}

/// @nodoc


class _PlaceSuggestion implements PlaceSuggestion {
  const _PlaceSuggestion({required this.placeId, required this.mainText,  List<({int end, int start,})> matches = const [], this.secondaryText = '', this.distanceM,  List<String> types = const []}): _matches = matches,_types = types;
  

@override final  String placeId;
/// The place's name, e.g. "Suria KLCC".
@override final  String mainText;
/// Where [mainText] matches what was typed, as [start, end) offsets.
 final  List<({int end, int start,})> _matches;
/// Where [mainText] matches what was typed, as [start, end) offsets.
@override@JsonKey() List<({int end, int start,})> get matches {
  if (_matches is EqualUnmodifiableListView) return _matches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_matches);
}

/// Area or address, e.g. "Jalan Ampang, Kuala Lumpur".
@override@JsonKey() final  String secondaryText;
/// Straight-line distance from the user, when known.
@override final  int? distanceM;
/// Provider place types, most specific first.
 final  List<String> _types;
/// Provider place types, most specific first.
@override@JsonKey() List<String> get types {
  if (_types is EqualUnmodifiableListView) return _types;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_types);
}


/// Create a copy of PlaceSuggestion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceSuggestionCopyWith<_PlaceSuggestion> get copyWith => __$PlaceSuggestionCopyWithImpl<_PlaceSuggestion>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceSuggestion&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.mainText, mainText) || other.mainText == mainText)&&const DeepCollectionEquality().equals(other.matches, _matches)&&(identical(other.secondaryText, secondaryText) || other.secondaryText == secondaryText)&&(identical(other.distanceM, distanceM) || other.distanceM == distanceM)&&const DeepCollectionEquality().equals(other.types, _types));
}


@override
int get hashCode {
    return Object.hash(runtimeType,placeId,mainText,const DeepCollectionEquality().hash(_matches),secondaryText,distanceM,const DeepCollectionEquality().hash(_types));
}

@override
String toString() {
    return 'PlaceSuggestion(placeId: $placeId, mainText: $mainText, matches: $matches, secondaryText: $secondaryText, distanceM: $distanceM, types: $types)';
}


}

/// @nodoc
abstract mixin class _$PlaceSuggestionCopyWith<$Res> implements $PlaceSuggestionCopyWith<$Res> {
  factory _$PlaceSuggestionCopyWith(_PlaceSuggestion value, $Res Function(_PlaceSuggestion) _then) = __$PlaceSuggestionCopyWithImpl;
@override @useResult
$Res call({
 String placeId, String mainText, List<({int end, int start,})> matches, String secondaryText, int? distanceM, List<String> types
});




}
/// @nodoc
class __$PlaceSuggestionCopyWithImpl<$Res>
    implements _$PlaceSuggestionCopyWith<$Res> {
  __$PlaceSuggestionCopyWithImpl(this._self, this._then);

  final _PlaceSuggestion _self;
  final $Res Function(_PlaceSuggestion) _then;

/// Create a copy of PlaceSuggestion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? placeId = null,Object? mainText = null,Object? matches = null,Object? secondaryText = null,Object? distanceM = freezed,Object? types = null,}) {
  return _then(_PlaceSuggestion(
placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,mainText: null == mainText ? _self.mainText : mainText // ignore: cast_nullable_to_non_nullable
as String,matches: null == matches ? _self._matches : matches // ignore: cast_nullable_to_non_nullable
as List<({int end, int start,})>,secondaryText: null == secondaryText ? _self.secondaryText : secondaryText // ignore: cast_nullable_to_non_nullable
as String,distanceM: freezed == distanceM ? _self.distanceM : distanceM // ignore: cast_nullable_to_non_nullable
as int?,types: null == types ? _self._types : types // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
