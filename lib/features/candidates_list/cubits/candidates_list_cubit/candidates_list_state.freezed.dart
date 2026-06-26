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

 CandidatesListStatus get status; List<CandidateModel> get items; int get currentPage; int get totalItems; bool get isOffline; String? get errorMessage;
/// Create a copy of CandidatesListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CandidatesListStateCopyWith<CandidatesListState> get copyWith => _$CandidatesListStateCopyWithImpl<CandidatesListState>(this as CandidatesListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CandidatesListState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalItems, totalItems) || other.totalItems == totalItems)&&(identical(other.isOffline, isOffline) || other.isOffline == isOffline)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(items),currentPage,totalItems,isOffline,errorMessage);

@override
String toString() {
  return 'CandidatesListState(status: $status, items: $items, currentPage: $currentPage, totalItems: $totalItems, isOffline: $isOffline, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $CandidatesListStateCopyWith<$Res>  {
  factory $CandidatesListStateCopyWith(CandidatesListState value, $Res Function(CandidatesListState) _then) = _$CandidatesListStateCopyWithImpl;
@useResult
$Res call({
 CandidatesListStatus status, List<CandidateModel> items, int currentPage, int totalItems, bool isOffline, String? errorMessage
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
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? items = null,Object? currentPage = null,Object? totalItems = null,Object? isOffline = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CandidatesListStatus,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<CandidateModel>,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalItems: null == totalItems ? _self.totalItems : totalItems // ignore: cast_nullable_to_non_nullable
as int,isOffline: null == isOffline ? _self.isOffline : isOffline // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CandidatesListStatus status,  List<CandidateModel> items,  int currentPage,  int totalItems,  bool isOffline,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CandidatesListState() when $default != null:
return $default(_that.status,_that.items,_that.currentPage,_that.totalItems,_that.isOffline,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CandidatesListStatus status,  List<CandidateModel> items,  int currentPage,  int totalItems,  bool isOffline,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _CandidatesListState():
return $default(_that.status,_that.items,_that.currentPage,_that.totalItems,_that.isOffline,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CandidatesListStatus status,  List<CandidateModel> items,  int currentPage,  int totalItems,  bool isOffline,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _CandidatesListState() when $default != null:
return $default(_that.status,_that.items,_that.currentPage,_that.totalItems,_that.isOffline,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _CandidatesListState extends CandidatesListState {
  const _CandidatesListState({this.status = CandidatesListStatus.initial, final  List<CandidateModel> items = const [], this.currentPage = 1, this.totalItems = 0, this.isOffline = false, this.errorMessage}): _items = items,super._();
  

@override@JsonKey() final  CandidatesListStatus status;
 final  List<CandidateModel> _items;
@override@JsonKey() List<CandidateModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  int currentPage;
@override@JsonKey() final  int totalItems;
@override@JsonKey() final  bool isOffline;
@override final  String? errorMessage;

/// Create a copy of CandidatesListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CandidatesListStateCopyWith<_CandidatesListState> get copyWith => __$CandidatesListStateCopyWithImpl<_CandidatesListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CandidatesListState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalItems, totalItems) || other.totalItems == totalItems)&&(identical(other.isOffline, isOffline) || other.isOffline == isOffline)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_items),currentPage,totalItems,isOffline,errorMessage);

@override
String toString() {
  return 'CandidatesListState(status: $status, items: $items, currentPage: $currentPage, totalItems: $totalItems, isOffline: $isOffline, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$CandidatesListStateCopyWith<$Res> implements $CandidatesListStateCopyWith<$Res> {
  factory _$CandidatesListStateCopyWith(_CandidatesListState value, $Res Function(_CandidatesListState) _then) = __$CandidatesListStateCopyWithImpl;
@override @useResult
$Res call({
 CandidatesListStatus status, List<CandidateModel> items, int currentPage, int totalItems, bool isOffline, String? errorMessage
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
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? items = null,Object? currentPage = null,Object? totalItems = null,Object? isOffline = null,Object? errorMessage = freezed,}) {
  return _then(_CandidatesListState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CandidatesListStatus,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CandidateModel>,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalItems: null == totalItems ? _self.totalItems : totalItems // ignore: cast_nullable_to_non_nullable
as int,isOffline: null == isOffline ? _self.isOffline : isOffline // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
