// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'candidate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Candidate {

 String get id; String get name; String get position;@JsonKey(name: 'pos_label') String get posLabel; String get file; String get email; String get phone; String get city; String get tg;@JsonKey(fromJson: _expFromJson, toJson: _expToJson) List<List<String>> get exp;@JsonKey(name: 'total_exp') String get totalExp; String get stack; String get edu; String get verdict; String get vc;@JsonKey(fromJson: _expFromJson, toJson: _expToJson) List<List<String>> get criteria; String get summary; List<String> get questions; String get status;@JsonKey(name: 'date_added') String? get dateAdded;
/// Create a copy of Candidate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CandidateCopyWith<Candidate> get copyWith => _$CandidateCopyWithImpl<Candidate>(this as Candidate, _$identity);

  /// Serializes this Candidate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Candidate&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.position, position) || other.position == position)&&(identical(other.posLabel, posLabel) || other.posLabel == posLabel)&&(identical(other.file, file) || other.file == file)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.city, city) || other.city == city)&&(identical(other.tg, tg) || other.tg == tg)&&const DeepCollectionEquality().equals(other.exp, exp)&&(identical(other.totalExp, totalExp) || other.totalExp == totalExp)&&(identical(other.stack, stack) || other.stack == stack)&&(identical(other.edu, edu) || other.edu == edu)&&(identical(other.verdict, verdict) || other.verdict == verdict)&&(identical(other.vc, vc) || other.vc == vc)&&const DeepCollectionEquality().equals(other.criteria, criteria)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.questions, questions)&&(identical(other.status, status) || other.status == status)&&(identical(other.dateAdded, dateAdded) || other.dateAdded == dateAdded));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,position,posLabel,file,email,phone,city,tg,const DeepCollectionEquality().hash(exp),totalExp,stack,edu,verdict,vc,const DeepCollectionEquality().hash(criteria),summary,const DeepCollectionEquality().hash(questions),status,dateAdded]);

@override
String toString() {
  return 'Candidate(id: $id, name: $name, position: $position, posLabel: $posLabel, file: $file, email: $email, phone: $phone, city: $city, tg: $tg, exp: $exp, totalExp: $totalExp, stack: $stack, edu: $edu, verdict: $verdict, vc: $vc, criteria: $criteria, summary: $summary, questions: $questions, status: $status, dateAdded: $dateAdded)';
}


}

/// @nodoc
abstract mixin class $CandidateCopyWith<$Res>  {
  factory $CandidateCopyWith(Candidate value, $Res Function(Candidate) _then) = _$CandidateCopyWithImpl;
@useResult
$Res call({
 String id, String name, String position,@JsonKey(name: 'pos_label') String posLabel, String file, String email, String phone, String city, String tg,@JsonKey(fromJson: _expFromJson, toJson: _expToJson) List<List<String>> exp,@JsonKey(name: 'total_exp') String totalExp, String stack, String edu, String verdict, String vc,@JsonKey(fromJson: _expFromJson, toJson: _expToJson) List<List<String>> criteria, String summary, List<String> questions, String status,@JsonKey(name: 'date_added') String? dateAdded
});




}
/// @nodoc
class _$CandidateCopyWithImpl<$Res>
    implements $CandidateCopyWith<$Res> {
  _$CandidateCopyWithImpl(this._self, this._then);

  final Candidate _self;
  final $Res Function(Candidate) _then;

/// Create a copy of Candidate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? position = null,Object? posLabel = null,Object? file = null,Object? email = null,Object? phone = null,Object? city = null,Object? tg = null,Object? exp = null,Object? totalExp = null,Object? stack = null,Object? edu = null,Object? verdict = null,Object? vc = null,Object? criteria = null,Object? summary = null,Object? questions = null,Object? status = null,Object? dateAdded = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,posLabel: null == posLabel ? _self.posLabel : posLabel // ignore: cast_nullable_to_non_nullable
as String,file: null == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,tg: null == tg ? _self.tg : tg // ignore: cast_nullable_to_non_nullable
as String,exp: null == exp ? _self.exp : exp // ignore: cast_nullable_to_non_nullable
as List<List<String>>,totalExp: null == totalExp ? _self.totalExp : totalExp // ignore: cast_nullable_to_non_nullable
as String,stack: null == stack ? _self.stack : stack // ignore: cast_nullable_to_non_nullable
as String,edu: null == edu ? _self.edu : edu // ignore: cast_nullable_to_non_nullable
as String,verdict: null == verdict ? _self.verdict : verdict // ignore: cast_nullable_to_non_nullable
as String,vc: null == vc ? _self.vc : vc // ignore: cast_nullable_to_non_nullable
as String,criteria: null == criteria ? _self.criteria : criteria // ignore: cast_nullable_to_non_nullable
as List<List<String>>,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,dateAdded: freezed == dateAdded ? _self.dateAdded : dateAdded // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Candidate].
extension CandidatePatterns on Candidate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Candidate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Candidate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Candidate value)  $default,){
final _that = this;
switch (_that) {
case _Candidate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Candidate value)?  $default,){
final _that = this;
switch (_that) {
case _Candidate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String position, @JsonKey(name: 'pos_label')  String posLabel,  String file,  String email,  String phone,  String city,  String tg, @JsonKey(fromJson: _expFromJson, toJson: _expToJson)  List<List<String>> exp, @JsonKey(name: 'total_exp')  String totalExp,  String stack,  String edu,  String verdict,  String vc, @JsonKey(fromJson: _expFromJson, toJson: _expToJson)  List<List<String>> criteria,  String summary,  List<String> questions,  String status, @JsonKey(name: 'date_added')  String? dateAdded)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Candidate() when $default != null:
return $default(_that.id,_that.name,_that.position,_that.posLabel,_that.file,_that.email,_that.phone,_that.city,_that.tg,_that.exp,_that.totalExp,_that.stack,_that.edu,_that.verdict,_that.vc,_that.criteria,_that.summary,_that.questions,_that.status,_that.dateAdded);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String position, @JsonKey(name: 'pos_label')  String posLabel,  String file,  String email,  String phone,  String city,  String tg, @JsonKey(fromJson: _expFromJson, toJson: _expToJson)  List<List<String>> exp, @JsonKey(name: 'total_exp')  String totalExp,  String stack,  String edu,  String verdict,  String vc, @JsonKey(fromJson: _expFromJson, toJson: _expToJson)  List<List<String>> criteria,  String summary,  List<String> questions,  String status, @JsonKey(name: 'date_added')  String? dateAdded)  $default,) {final _that = this;
switch (_that) {
case _Candidate():
return $default(_that.id,_that.name,_that.position,_that.posLabel,_that.file,_that.email,_that.phone,_that.city,_that.tg,_that.exp,_that.totalExp,_that.stack,_that.edu,_that.verdict,_that.vc,_that.criteria,_that.summary,_that.questions,_that.status,_that.dateAdded);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String position, @JsonKey(name: 'pos_label')  String posLabel,  String file,  String email,  String phone,  String city,  String tg, @JsonKey(fromJson: _expFromJson, toJson: _expToJson)  List<List<String>> exp, @JsonKey(name: 'total_exp')  String totalExp,  String stack,  String edu,  String verdict,  String vc, @JsonKey(fromJson: _expFromJson, toJson: _expToJson)  List<List<String>> criteria,  String summary,  List<String> questions,  String status, @JsonKey(name: 'date_added')  String? dateAdded)?  $default,) {final _that = this;
switch (_that) {
case _Candidate() when $default != null:
return $default(_that.id,_that.name,_that.position,_that.posLabel,_that.file,_that.email,_that.phone,_that.city,_that.tg,_that.exp,_that.totalExp,_that.stack,_that.edu,_that.verdict,_that.vc,_that.criteria,_that.summary,_that.questions,_that.status,_that.dateAdded);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Candidate implements Candidate {
  const _Candidate({required this.id, required this.name, required this.position, @JsonKey(name: 'pos_label') required this.posLabel, required this.file, required this.email, required this.phone, required this.city, required this.tg, @JsonKey(fromJson: _expFromJson, toJson: _expToJson) required final  List<List<String>> exp, @JsonKey(name: 'total_exp') required this.totalExp, required this.stack, required this.edu, required this.verdict, required this.vc, @JsonKey(fromJson: _expFromJson, toJson: _expToJson) required final  List<List<String>> criteria, required this.summary, required final  List<String> questions, this.status = 'new', @JsonKey(name: 'date_added') this.dateAdded}): _exp = exp,_criteria = criteria,_questions = questions;
  factory _Candidate.fromJson(Map<String, dynamic> json) => _$CandidateFromJson(json);

@override final  String id;
@override final  String name;
@override final  String position;
@override@JsonKey(name: 'pos_label') final  String posLabel;
@override final  String file;
@override final  String email;
@override final  String phone;
@override final  String city;
@override final  String tg;
 final  List<List<String>> _exp;
@override@JsonKey(fromJson: _expFromJson, toJson: _expToJson) List<List<String>> get exp {
  if (_exp is EqualUnmodifiableListView) return _exp;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exp);
}

@override@JsonKey(name: 'total_exp') final  String totalExp;
@override final  String stack;
@override final  String edu;
@override final  String verdict;
@override final  String vc;
 final  List<List<String>> _criteria;
@override@JsonKey(fromJson: _expFromJson, toJson: _expToJson) List<List<String>> get criteria {
  if (_criteria is EqualUnmodifiableListView) return _criteria;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_criteria);
}

@override final  String summary;
 final  List<String> _questions;
@override List<String> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}

@override@JsonKey() final  String status;
@override@JsonKey(name: 'date_added') final  String? dateAdded;

/// Create a copy of Candidate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CandidateCopyWith<_Candidate> get copyWith => __$CandidateCopyWithImpl<_Candidate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CandidateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Candidate&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.position, position) || other.position == position)&&(identical(other.posLabel, posLabel) || other.posLabel == posLabel)&&(identical(other.file, file) || other.file == file)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.city, city) || other.city == city)&&(identical(other.tg, tg) || other.tg == tg)&&const DeepCollectionEquality().equals(other._exp, _exp)&&(identical(other.totalExp, totalExp) || other.totalExp == totalExp)&&(identical(other.stack, stack) || other.stack == stack)&&(identical(other.edu, edu) || other.edu == edu)&&(identical(other.verdict, verdict) || other.verdict == verdict)&&(identical(other.vc, vc) || other.vc == vc)&&const DeepCollectionEquality().equals(other._criteria, _criteria)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other._questions, _questions)&&(identical(other.status, status) || other.status == status)&&(identical(other.dateAdded, dateAdded) || other.dateAdded == dateAdded));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,position,posLabel,file,email,phone,city,tg,const DeepCollectionEquality().hash(_exp),totalExp,stack,edu,verdict,vc,const DeepCollectionEquality().hash(_criteria),summary,const DeepCollectionEquality().hash(_questions),status,dateAdded]);

@override
String toString() {
  return 'Candidate(id: $id, name: $name, position: $position, posLabel: $posLabel, file: $file, email: $email, phone: $phone, city: $city, tg: $tg, exp: $exp, totalExp: $totalExp, stack: $stack, edu: $edu, verdict: $verdict, vc: $vc, criteria: $criteria, summary: $summary, questions: $questions, status: $status, dateAdded: $dateAdded)';
}


}

/// @nodoc
abstract mixin class _$CandidateCopyWith<$Res> implements $CandidateCopyWith<$Res> {
  factory _$CandidateCopyWith(_Candidate value, $Res Function(_Candidate) _then) = __$CandidateCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String position,@JsonKey(name: 'pos_label') String posLabel, String file, String email, String phone, String city, String tg,@JsonKey(fromJson: _expFromJson, toJson: _expToJson) List<List<String>> exp,@JsonKey(name: 'total_exp') String totalExp, String stack, String edu, String verdict, String vc,@JsonKey(fromJson: _expFromJson, toJson: _expToJson) List<List<String>> criteria, String summary, List<String> questions, String status,@JsonKey(name: 'date_added') String? dateAdded
});




}
/// @nodoc
class __$CandidateCopyWithImpl<$Res>
    implements _$CandidateCopyWith<$Res> {
  __$CandidateCopyWithImpl(this._self, this._then);

  final _Candidate _self;
  final $Res Function(_Candidate) _then;

/// Create a copy of Candidate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? position = null,Object? posLabel = null,Object? file = null,Object? email = null,Object? phone = null,Object? city = null,Object? tg = null,Object? exp = null,Object? totalExp = null,Object? stack = null,Object? edu = null,Object? verdict = null,Object? vc = null,Object? criteria = null,Object? summary = null,Object? questions = null,Object? status = null,Object? dateAdded = freezed,}) {
  return _then(_Candidate(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,posLabel: null == posLabel ? _self.posLabel : posLabel // ignore: cast_nullable_to_non_nullable
as String,file: null == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,tg: null == tg ? _self.tg : tg // ignore: cast_nullable_to_non_nullable
as String,exp: null == exp ? _self._exp : exp // ignore: cast_nullable_to_non_nullable
as List<List<String>>,totalExp: null == totalExp ? _self.totalExp : totalExp // ignore: cast_nullable_to_non_nullable
as String,stack: null == stack ? _self.stack : stack // ignore: cast_nullable_to_non_nullable
as String,edu: null == edu ? _self.edu : edu // ignore: cast_nullable_to_non_nullable
as String,verdict: null == verdict ? _self.verdict : verdict // ignore: cast_nullable_to_non_nullable
as String,vc: null == vc ? _self.vc : vc // ignore: cast_nullable_to_non_nullable
as String,criteria: null == criteria ? _self._criteria : criteria // ignore: cast_nullable_to_non_nullable
as List<List<String>>,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,dateAdded: freezed == dateAdded ? _self.dateAdded : dateAdded // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
