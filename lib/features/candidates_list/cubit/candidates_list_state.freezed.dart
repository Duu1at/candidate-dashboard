// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'candidates_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CandidatesListState {

 CandidatesListStatus get status; List<Candidate> get allCandidates; List<Candidate> get filteredCandidates; List<Candidate> get displayedCandidates; String get searchQuery; String? get verdictFilter; SortOption get sortBy; int get currentPage; bool get hasMore; bool get isOffline; String? get errorMessage;
/// Create a copy of CandidatesListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CandidatesListStateCopyWith<CandidatesListState> get copyWith => _$CandidatesListStateCopyWithImpl<CandidatesListState>(this as CandidatesListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CandidatesListState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.allCandidates, allCandidates)&&const DeepCollectionEquality().equals(other.filteredCandidates, filteredCandidates)&&const DeepCollectionEquality().equals(other.displayedCandidates, displayedCandidates)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.verdictFilter, verdictFilter) || other.verdictFilter == verdictFilter)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isOffline, isOffline) || other.isOffline == isOffline)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(allCandidates),const DeepCollectionEquality().hash(filteredCandidates),const DeepCollectionEquality().hash(displayedCandidates),searchQuery,verdictFilter,sortBy,currentPage,hasMore,isOffline,errorMessage);

@override
String toString() {
  return 'CandidatesListState(status: $status, allCandidates: $allCandidates, filteredCandidates: $filteredCandidates, displayedCandidates: $displayedCandidates, searchQuery: $searchQuery, verdictFilter: $verdictFilter, sortBy: $sortBy, currentPage: $currentPage, hasMore: $hasMore, isOffline: $isOffline, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $CandidatesListStateCopyWith<$Res>  {
  factory $CandidatesListStateCopyWith(CandidatesListState value, $Res Function(CandidatesListState) _then) = _$CandidatesListStateCopyWithImpl;
@useResult
$Res call({
 CandidatesListStatus status, List<Candidate> allCandidates, List<Candidate> filteredCandidates, List<Candidate> displayedCandidates, String searchQuery, String? verdictFilter, SortOption sortBy, int currentPage, bool hasMore, bool isOffline, String? errorMessage
});




}
/// @nodoc
class _$CandidatesListStateCopyWithImpl<$Res>
    implements $CandidatesListStateCopyWith<$Res> {
  _$CandidatesListStateCopyWithImpl(this._self, this._then);

  final CandidatesListState _self;
  final $Res Function(CandidatesListState) _then;

/// Create a copy of CandidatesListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? allCandidates = null,Object? filteredCandidates = null,Object? displayedCandidates = null,Object? searchQuery = null,Object? verdictFilter = freezed,Object? sortBy = null,Object? currentPage = null,Object? hasMore = null,Object? isOffline = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CandidatesListStatus,allCandidates: null == allCandidates ? _self.allCandidates : allCandidates // ignore: cast_nullable_to_non_nullable
as List<Candidate>,filteredCandidates: null == filteredCandidates ? _self.filteredCandidates : filteredCandidates // ignore: cast_nullable_to_non_nullable
as List<Candidate>,displayedCandidates: null == displayedCandidates ? _self.displayedCandidates : displayedCandidates // ignore: cast_nullable_to_non_nullable
as List<Candidate>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,verdictFilter: freezed == verdictFilter ? _self.verdictFilter : verdictFilter // ignore: cast_nullable_to_non_nullable
as String?,sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as SortOption,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isOffline: null == isOffline ? _self.isOffline : isOffline // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CandidatesListState].
extension CandidatesListStatePatterns on CandidatesListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CandidatesListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CandidatesListState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CandidatesListState value)  $default,){
final _that = this;
switch (_that) {
case _CandidatesListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CandidatesListState value)?  $default,){
final _that = this;
switch (_that) {
case _CandidatesListState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CandidatesListStatus status,  List<Candidate> allCandidates,  List<Candidate> filteredCandidates,  List<Candidate> displayedCandidates,  String searchQuery,  String? verdictFilter,  SortOption sortBy,  int currentPage,  bool hasMore,  bool isOffline,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CandidatesListState() when $default != null:
return $default(_that.status,_that.allCandidates,_that.filteredCandidates,_that.displayedCandidates,_that.searchQuery,_that.verdictFilter,_that.sortBy,_that.currentPage,_that.hasMore,_that.isOffline,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CandidatesListStatus status,  List<Candidate> allCandidates,  List<Candidate> filteredCandidates,  List<Candidate> displayedCandidates,  String searchQuery,  String? verdictFilter,  SortOption sortBy,  int currentPage,  bool hasMore,  bool isOffline,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _CandidatesListState():
return $default(_that.status,_that.allCandidates,_that.filteredCandidates,_that.displayedCandidates,_that.searchQuery,_that.verdictFilter,_that.sortBy,_that.currentPage,_that.hasMore,_that.isOffline,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CandidatesListStatus status,  List<Candidate> allCandidates,  List<Candidate> filteredCandidates,  List<Candidate> displayedCandidates,  String searchQuery,  String? verdictFilter,  SortOption sortBy,  int currentPage,  bool hasMore,  bool isOffline,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _CandidatesListState() when $default != null:
return $default(_that.status,_that.allCandidates,_that.filteredCandidates,_that.displayedCandidates,_that.searchQuery,_that.verdictFilter,_that.sortBy,_that.currentPage,_that.hasMore,_that.isOffline,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _CandidatesListState implements CandidatesListState {
  const _CandidatesListState({this.status = CandidatesListStatus.initial, final  List<Candidate> allCandidates = const [], final  List<Candidate> filteredCandidates = const [], final  List<Candidate> displayedCandidates = const [], this.searchQuery = '', this.verdictFilter, this.sortBy = SortOption.dateAdded, this.currentPage = 1, this.hasMore = false, this.isOffline = false, this.errorMessage}): _allCandidates = allCandidates,_filteredCandidates = filteredCandidates,_displayedCandidates = displayedCandidates;
  

@override@JsonKey() final  CandidatesListStatus status;
 final  List<Candidate> _allCandidates;
@override@JsonKey() List<Candidate> get allCandidates {
  if (_allCandidates is EqualUnmodifiableListView) return _allCandidates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allCandidates);
}

 final  List<Candidate> _filteredCandidates;
@override@JsonKey() List<Candidate> get filteredCandidates {
  if (_filteredCandidates is EqualUnmodifiableListView) return _filteredCandidates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filteredCandidates);
}

 final  List<Candidate> _displayedCandidates;
@override@JsonKey() List<Candidate> get displayedCandidates {
  if (_displayedCandidates is EqualUnmodifiableListView) return _displayedCandidates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_displayedCandidates);
}

@override@JsonKey() final  String searchQuery;
@override final  String? verdictFilter;
@override@JsonKey() final  SortOption sortBy;
@override@JsonKey() final  int currentPage;
@override@JsonKey() final  bool hasMore;
@override@JsonKey() final  bool isOffline;
@override final  String? errorMessage;

/// Create a copy of CandidatesListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CandidatesListStateCopyWith<_CandidatesListState> get copyWith => __$CandidatesListStateCopyWithImpl<_CandidatesListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CandidatesListState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._allCandidates, _allCandidates)&&const DeepCollectionEquality().equals(other._filteredCandidates, _filteredCandidates)&&const DeepCollectionEquality().equals(other._displayedCandidates, _displayedCandidates)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.verdictFilter, verdictFilter) || other.verdictFilter == verdictFilter)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isOffline, isOffline) || other.isOffline == isOffline)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_allCandidates),const DeepCollectionEquality().hash(_filteredCandidates),const DeepCollectionEquality().hash(_displayedCandidates),searchQuery,verdictFilter,sortBy,currentPage,hasMore,isOffline,errorMessage);

@override
String toString() {
  return 'CandidatesListState(status: $status, allCandidates: $allCandidates, filteredCandidates: $filteredCandidates, displayedCandidates: $displayedCandidates, searchQuery: $searchQuery, verdictFilter: $verdictFilter, sortBy: $sortBy, currentPage: $currentPage, hasMore: $hasMore, isOffline: $isOffline, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$CandidatesListStateCopyWith<$Res> implements $CandidatesListStateCopyWith<$Res> {
  factory _$CandidatesListStateCopyWith(_CandidatesListState value, $Res Function(_CandidatesListState) _then) = __$CandidatesListStateCopyWithImpl;
@override @useResult
$Res call({
 CandidatesListStatus status, List<Candidate> allCandidates, List<Candidate> filteredCandidates, List<Candidate> displayedCandidates, String searchQuery, String? verdictFilter, SortOption sortBy, int currentPage, bool hasMore, bool isOffline, String? errorMessage
});




}
/// @nodoc
class __$CandidatesListStateCopyWithImpl<$Res>
    implements _$CandidatesListStateCopyWith<$Res> {
  __$CandidatesListStateCopyWithImpl(this._self, this._then);

  final _CandidatesListState _self;
  final $Res Function(_CandidatesListState) _then;

/// Create a copy of CandidatesListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? allCandidates = null,Object? filteredCandidates = null,Object? displayedCandidates = null,Object? searchQuery = null,Object? verdictFilter = freezed,Object? sortBy = null,Object? currentPage = null,Object? hasMore = null,Object? isOffline = null,Object? errorMessage = freezed,}) {
  return _then(_CandidatesListState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CandidatesListStatus,allCandidates: null == allCandidates ? _self._allCandidates : allCandidates // ignore: cast_nullable_to_non_nullable
as List<Candidate>,filteredCandidates: null == filteredCandidates ? _self._filteredCandidates : filteredCandidates // ignore: cast_nullable_to_non_nullable
as List<Candidate>,displayedCandidates: null == displayedCandidates ? _self._displayedCandidates : displayedCandidates // ignore: cast_nullable_to_non_nullable
as List<Candidate>,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,verdictFilter: freezed == verdictFilter ? _self.verdictFilter : verdictFilter // ignore: cast_nullable_to_non_nullable
as String?,sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as SortOption,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isOffline: null == isOffline ? _self.isOffline : isOffline // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
