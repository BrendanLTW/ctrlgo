// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recent_search.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecentSearch {

 DateTime? get searchedAt;
/// Create a copy of RecentSearch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecentSearchCopyWith<RecentSearch> get copyWith => _$RecentSearchCopyWithImpl<RecentSearch>(this as RecentSearch, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RecentSearch;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecentSearch&&(identical(other.searchedAt, _this.searchedAt) || other.searchedAt == _this.searchedAt));
}


@override
int get hashCode {
  final _this = this as RecentSearch;
  return Object.hash(runtimeType,_this.searchedAt);
}

@override
String toString() {
  final _this = this as RecentSearch;
  return 'RecentSearch(searchedAt: ${_this.searchedAt})';
}


}

/// @nodoc
abstract mixin class $RecentSearchCopyWith<$Res>  {
  factory $RecentSearchCopyWith(RecentSearch value, $Res Function(RecentSearch) _then) = _$RecentSearchCopyWithImpl;
@useResult
$Res call({
 DateTime? searchedAt
});




}
/// @nodoc
class _$RecentSearchCopyWithImpl<$Res>
    implements $RecentSearchCopyWith<$Res> {
  _$RecentSearchCopyWithImpl(this._self, this._then);

  final RecentSearch _self;
  final $Res Function(RecentSearch) _then;

/// Create a copy of RecentSearch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? searchedAt = freezed,}) {
  return _then(_self.copyWith(
searchedAt: freezed == searchedAt ? _self.searchedAt : searchedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [RecentSearch].
extension RecentSearchPatterns on RecentSearch {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RecentPlace value)?  place,TResult Function( RecentQuery value)?  query,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RecentPlace() when place != null:
return place(_that);case RecentQuery() when query != null:
return query(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RecentPlace value)  place,required TResult Function( RecentQuery value)  query,}){
final _that = this;
switch (_that) {
case RecentPlace():
return place(_that);case RecentQuery():
return query(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RecentPlace value)?  place,TResult? Function( RecentQuery value)?  query,}){
final _that = this;
switch (_that) {
case RecentPlace() when place != null:
return place(_that);case RecentQuery() when query != null:
return query(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String placeId,  String label,  String secondaryText,  DateTime? searchedAt)?  place,TResult Function( String query,  DateTime? searchedAt)?  query,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RecentPlace() when place != null:
return place(_that.placeId,_that.label,_that.secondaryText,_that.searchedAt);case RecentQuery() when query != null:
return query(_that.query,_that.searchedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String placeId,  String label,  String secondaryText,  DateTime? searchedAt)  place,required TResult Function( String query,  DateTime? searchedAt)  query,}) {final _that = this;
switch (_that) {
case RecentPlace():
return place(_that.placeId,_that.label,_that.secondaryText,_that.searchedAt);case RecentQuery():
return query(_that.query,_that.searchedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String placeId,  String label,  String secondaryText,  DateTime? searchedAt)?  place,TResult? Function( String query,  DateTime? searchedAt)?  query,}) {final _that = this;
switch (_that) {
case RecentPlace() when place != null:
return place(_that.placeId,_that.label,_that.secondaryText,_that.searchedAt);case RecentQuery() when query != null:
return query(_that.query,_that.searchedAt);case _:
  return null;

}
}

}

/// @nodoc


class RecentPlace implements RecentSearch {
  const RecentPlace({required this.placeId, required this.label, this.secondaryText = '', this.searchedAt});
  

 final  String placeId;
 final  String label;
@JsonKey() final  String secondaryText;
@override final  DateTime? searchedAt;

/// Create a copy of RecentSearch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecentPlaceCopyWith<RecentPlace> get copyWith => _$RecentPlaceCopyWithImpl<RecentPlace>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is RecentPlace&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.label, label) || other.label == label)&&(identical(other.secondaryText, secondaryText) || other.secondaryText == secondaryText)&&(identical(other.searchedAt, searchedAt) || other.searchedAt == searchedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,placeId,label,secondaryText,searchedAt);
}

@override
String toString() {
    return 'RecentSearch.place(placeId: $placeId, label: $label, secondaryText: $secondaryText, searchedAt: $searchedAt)';
}


}

/// @nodoc
abstract mixin class $RecentPlaceCopyWith<$Res> implements $RecentSearchCopyWith<$Res> {
  factory $RecentPlaceCopyWith(RecentPlace value, $Res Function(RecentPlace) _then) = _$RecentPlaceCopyWithImpl;
@override @useResult
$Res call({
 String placeId, String label, String secondaryText, DateTime? searchedAt
});




}
/// @nodoc
class _$RecentPlaceCopyWithImpl<$Res>
    implements $RecentPlaceCopyWith<$Res> {
  _$RecentPlaceCopyWithImpl(this._self, this._then);

  final RecentPlace _self;
  final $Res Function(RecentPlace) _then;

/// Create a copy of RecentSearch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? placeId = null,Object? label = null,Object? secondaryText = null,Object? searchedAt = freezed,}) {
  return _then(RecentPlace(
placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,secondaryText: null == secondaryText ? _self.secondaryText : secondaryText // ignore: cast_nullable_to_non_nullable
as String,searchedAt: freezed == searchedAt ? _self.searchedAt : searchedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc


class RecentQuery implements RecentSearch {
  const RecentQuery({required this.query, this.searchedAt});
  

 final  String query;
@override final  DateTime? searchedAt;

/// Create a copy of RecentSearch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecentQueryCopyWith<RecentQuery> get copyWith => _$RecentQueryCopyWithImpl<RecentQuery>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is RecentQuery&&(identical(other.query, query) || other.query == query)&&(identical(other.searchedAt, searchedAt) || other.searchedAt == searchedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,query,searchedAt);
}

@override
String toString() {
    return 'RecentSearch.query(query: $query, searchedAt: $searchedAt)';
}


}

/// @nodoc
abstract mixin class $RecentQueryCopyWith<$Res> implements $RecentSearchCopyWith<$Res> {
  factory $RecentQueryCopyWith(RecentQuery value, $Res Function(RecentQuery) _then) = _$RecentQueryCopyWithImpl;
@override @useResult
$Res call({
 String query, DateTime? searchedAt
});




}
/// @nodoc
class _$RecentQueryCopyWithImpl<$Res>
    implements $RecentQueryCopyWith<$Res> {
  _$RecentQueryCopyWithImpl(this._self, this._then);

  final RecentQuery _self;
  final $Res Function(RecentQuery) _then;

/// Create a copy of RecentSearch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? searchedAt = freezed,}) {
  return _then(RecentQuery(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,searchedAt: freezed == searchedAt ? _self.searchedAt : searchedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
