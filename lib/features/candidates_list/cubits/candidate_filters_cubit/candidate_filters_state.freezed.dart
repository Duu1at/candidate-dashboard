// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'candidate_filters_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CandidateFiltersState {

 String get searchQuery; String? get verdictFilter; SortOption get sortBy;
/// Create a copy of CandidateFiltersState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CandidateFiltersStateCopyWith<CandidateFiltersState> get copyWith => _$CandidateFiltersStateCopyWithImpl<CandidateFiltersState>(this as CandidateFiltersState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CandidateFiltersState&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.verdictFilter, verdictFilter) || other.verdictFilter == verdictFilter)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy));
}


@override
int get hashCode => Object.hash(runtimeType,searchQuery,verdictFilter,sortBy);

@override
String toString() {
  return 'CandidateFiltersState(searchQuery: $searchQuery, verdictFilter: $verdictFilter, sortBy: $sortBy)';
}


}

/// @nodoc
abstract mixin class $CandidateFiltersStateCopyWith<$Res>  {
  factory $CandidateFiltersStateCopyWith(CandidateFiltersState value, $Res Function(CandidateFiltersState) _then) = _$CandidateFiltersStateCopyWithImpl;
@useResult
$Res call({
 String searchQuery, String? verdictFilter, SortOption sortBy
});




}
/// @nodoc
class _$CandidateFiltersStateCopyWithImpl<$Res>
    implements $CandidateFiltersStateCopyWith<$Res> {
  _$CandidateFiltersStateCopyWithImpl(this._self, this._then);

  final CandidateFiltersState _self;
  final $Res Function(CandidateFiltersState) _then;

/// Create a copy of CandidateFiltersState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? searchQuery = null,Object? verdictFilter = freezed,Object? sortBy = null,}) {
  return _then(_self.copyWith(
searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,verdictFilter: freezed == verdictFilter ? _self.verdictFilter : verdictFilter // ignore: cast_nullable_to_non_nullable
as String?,sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as SortOption,
  ));
}

}


/// Adds pattern-matching-related methods to [CandidateFiltersState].
extension CandidateFiltersStatePatterns on CandidateFiltersState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CandidateFiltersState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CandidateFiltersState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CandidateFiltersState value)  $default,){
final _that = this;
switch (_that) {
case _CandidateFiltersState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CandidateFiltersState value)?  $default,){
final _that = this;
switch (_that) {
case _CandidateFiltersState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String searchQuery,  String? verdictFilter,  SortOption sortBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CandidateFiltersState() when $default != null:
return $default(_that.searchQuery,_that.verdictFilter,_that.sortBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String searchQuery,  String? verdictFilter,  SortOption sortBy)  $default,) {final _that = this;
switch (_that) {
case _CandidateFiltersState():
return $default(_that.searchQuery,_that.verdictFilter,_that.sortBy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String searchQuery,  String? verdictFilter,  SortOption sortBy)?  $default,) {final _that = this;
switch (_that) {
case _CandidateFiltersState() when $default != null:
return $default(_that.searchQuery,_that.verdictFilter,_that.sortBy);case _:
  return null;

}
}

}

/// @nodoc


class _CandidateFiltersState implements CandidateFiltersState {
  const _CandidateFiltersState({this.searchQuery = '', this.verdictFilter, this.sortBy = SortOption.dateAdded});
  

@override@JsonKey() final  String searchQuery;
@override final  String? verdictFilter;
@override@JsonKey() final  SortOption sortBy;

/// Create a copy of CandidateFiltersState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CandidateFiltersStateCopyWith<_CandidateFiltersState> get copyWith => __$CandidateFiltersStateCopyWithImpl<_CandidateFiltersState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CandidateFiltersState&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.verdictFilter, verdictFilter) || other.verdictFilter == verdictFilter)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy));
}


@override
int get hashCode => Object.hash(runtimeType,searchQuery,verdictFilter,sortBy);

@override
String toString() {
  return 'CandidateFiltersState(searchQuery: $searchQuery, verdictFilter: $verdictFilter, sortBy: $sortBy)';
}


}

/// @nodoc
abstract mixin class _$CandidateFiltersStateCopyWith<$Res> implements $CandidateFiltersStateCopyWith<$Res> {
  factory _$CandidateFiltersStateCopyWith(_CandidateFiltersState value, $Res Function(_CandidateFiltersState) _then) = __$CandidateFiltersStateCopyWithImpl;
@override @useResult
$Res call({
 String searchQuery, String? verdictFilter, SortOption sortBy
});




}
/// @nodoc
class __$CandidateFiltersStateCopyWithImpl<$Res>
    implements _$CandidateFiltersStateCopyWith<$Res> {
  __$CandidateFiltersStateCopyWithImpl(this._self, this._then);

  final _CandidateFiltersState _self;
  final $Res Function(_CandidateFiltersState) _then;

/// Create a copy of CandidateFiltersState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? searchQuery = null,Object? verdictFilter = freezed,Object? sortBy = null,}) {
  return _then(_CandidateFiltersState(
searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,verdictFilter: freezed == verdictFilter ? _self.verdictFilter : verdictFilter // ignore: cast_nullable_to_non_nullable
as String?,sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as SortOption,
  ));
}


}

// dart format on
