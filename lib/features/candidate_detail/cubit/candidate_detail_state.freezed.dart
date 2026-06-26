// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'candidate_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CandidateDetailState {

 CandidateDetailStatus get status; CandidateModel? get candidate; String? get errorMessage;
/// Create a copy of CandidateDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CandidateDetailStateCopyWith<CandidateDetailState> get copyWith => _$CandidateDetailStateCopyWithImpl<CandidateDetailState>(this as CandidateDetailState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CandidateDetailState&&(identical(other.status, status) || other.status == status)&&(identical(other.candidate, candidate) || other.candidate == candidate)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,candidate,errorMessage);

@override
String toString() {
  return 'CandidateDetailState(status: $status, candidate: $candidate, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $CandidateDetailStateCopyWith<$Res>  {
  factory $CandidateDetailStateCopyWith(CandidateDetailState value, $Res Function(CandidateDetailState) _then) = _$CandidateDetailStateCopyWithImpl;
@useResult
$Res call({
 CandidateDetailStatus status, CandidateModel? candidate, String? errorMessage
});




}
/// @nodoc
class _$CandidateDetailStateCopyWithImpl<$Res>
    implements $CandidateDetailStateCopyWith<$Res> {
  _$CandidateDetailStateCopyWithImpl(this._self, this._then);

  final CandidateDetailState _self;
  final $Res Function(CandidateDetailState) _then;

/// Create a copy of CandidateDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? candidate = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CandidateDetailStatus,candidate: freezed == candidate ? _self.candidate : candidate // ignore: cast_nullable_to_non_nullable
as CandidateModel?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CandidateDetailState].
extension CandidateDetailStatePatterns on CandidateDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CandidateDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CandidateDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CandidateDetailState value)  $default,){
final _that = this;
switch (_that) {
case _CandidateDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CandidateDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _CandidateDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CandidateDetailStatus status,  CandidateModel? candidate,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CandidateDetailState() when $default != null:
return $default(_that.status,_that.candidate,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CandidateDetailStatus status,  CandidateModel? candidate,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _CandidateDetailState():
return $default(_that.status,_that.candidate,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CandidateDetailStatus status,  CandidateModel? candidate,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _CandidateDetailState() when $default != null:
return $default(_that.status,_that.candidate,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _CandidateDetailState implements CandidateDetailState {
  const _CandidateDetailState({this.status = CandidateDetailStatus.initial, this.candidate, this.errorMessage});
  

@override@JsonKey() final  CandidateDetailStatus status;
@override final  CandidateModel? candidate;
@override final  String? errorMessage;

/// Create a copy of CandidateDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CandidateDetailStateCopyWith<_CandidateDetailState> get copyWith => __$CandidateDetailStateCopyWithImpl<_CandidateDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CandidateDetailState&&(identical(other.status, status) || other.status == status)&&(identical(other.candidate, candidate) || other.candidate == candidate)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,candidate,errorMessage);

@override
String toString() {
  return 'CandidateDetailState(status: $status, candidate: $candidate, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$CandidateDetailStateCopyWith<$Res> implements $CandidateDetailStateCopyWith<$Res> {
  factory _$CandidateDetailStateCopyWith(_CandidateDetailState value, $Res Function(_CandidateDetailState) _then) = __$CandidateDetailStateCopyWithImpl;
@override @useResult
$Res call({
 CandidateDetailStatus status, CandidateModel? candidate, String? errorMessage
});




}
/// @nodoc
class __$CandidateDetailStateCopyWithImpl<$Res>
    implements _$CandidateDetailStateCopyWith<$Res> {
  __$CandidateDetailStateCopyWithImpl(this._self, this._then);

  final _CandidateDetailState _self;
  final $Res Function(_CandidateDetailState) _then;

/// Create a copy of CandidateDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? candidate = freezed,Object? errorMessage = freezed,}) {
  return _then(_CandidateDetailState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CandidateDetailStatus,candidate: freezed == candidate ? _self.candidate : candidate // ignore: cast_nullable_to_non_nullable
as CandidateModel?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
