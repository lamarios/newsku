// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserSettingsState {

 bool get loading; String get password; String get repeatPassword; String get email; List<EmailDigestFrequency> get digest; bool get ssoLinked; dynamic get error; StackTrace? get stackTrace;
/// Create a copy of UserSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSettingsStateCopyWith<UserSettingsState> get copyWith => _$UserSettingsStateCopyWithImpl<UserSettingsState>(this as UserSettingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSettingsState&&(identical(other.loading, loading) || other.loading == loading)&&(identical(other.password, password) || other.password == password)&&(identical(other.repeatPassword, repeatPassword) || other.repeatPassword == repeatPassword)&&(identical(other.email, email) || other.email == email)&&const DeepCollectionEquality().equals(other.digest, digest)&&(identical(other.ssoLinked, ssoLinked) || other.ssoLinked == ssoLinked)&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,loading,password,repeatPassword,email,const DeepCollectionEquality().hash(digest),ssoLinked,const DeepCollectionEquality().hash(error),stackTrace);

@override
String toString() {
  return 'UserSettingsState(loading: $loading, password: $password, repeatPassword: $repeatPassword, email: $email, digest: $digest, ssoLinked: $ssoLinked, error: $error, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $UserSettingsStateCopyWith<$Res>  {
  factory $UserSettingsStateCopyWith(UserSettingsState value, $Res Function(UserSettingsState) _then) = _$UserSettingsStateCopyWithImpl;
@useResult
$Res call({
 bool loading, String password, String repeatPassword, String email, List<EmailDigestFrequency> digest, bool ssoLinked, dynamic error, StackTrace? stackTrace
});




}
/// @nodoc
class _$UserSettingsStateCopyWithImpl<$Res>
    implements $UserSettingsStateCopyWith<$Res> {
  _$UserSettingsStateCopyWithImpl(this._self, this._then);

  final UserSettingsState _self;
  final $Res Function(UserSettingsState) _then;

/// Create a copy of UserSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loading = null,Object? password = null,Object? repeatPassword = null,Object? email = null,Object? digest = null,Object? ssoLinked = null,Object? error = freezed,Object? stackTrace = freezed,}) {
  return _then(_self.copyWith(
loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,repeatPassword: null == repeatPassword ? _self.repeatPassword : repeatPassword // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,digest: null == digest ? _self.digest : digest // ignore: cast_nullable_to_non_nullable
as List<EmailDigestFrequency>,ssoLinked: null == ssoLinked ? _self.ssoLinked : ssoLinked // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as dynamic,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserSettingsState].
extension UserSettingsStatePatterns on UserSettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSettingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSettingsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSettingsState value)  $default,){
final _that = this;
switch (_that) {
case _UserSettingsState():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSettingsState value)?  $default,){
final _that = this;
switch (_that) {
case _UserSettingsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool loading,  String password,  String repeatPassword,  String email,  List<EmailDigestFrequency> digest,  bool ssoLinked,  dynamic error,  StackTrace? stackTrace)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSettingsState() when $default != null:
return $default(_that.loading,_that.password,_that.repeatPassword,_that.email,_that.digest,_that.ssoLinked,_that.error,_that.stackTrace);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool loading,  String password,  String repeatPassword,  String email,  List<EmailDigestFrequency> digest,  bool ssoLinked,  dynamic error,  StackTrace? stackTrace)  $default,) {final _that = this;
switch (_that) {
case _UserSettingsState():
return $default(_that.loading,_that.password,_that.repeatPassword,_that.email,_that.digest,_that.ssoLinked,_that.error,_that.stackTrace);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool loading,  String password,  String repeatPassword,  String email,  List<EmailDigestFrequency> digest,  bool ssoLinked,  dynamic error,  StackTrace? stackTrace)?  $default,) {final _that = this;
switch (_that) {
case _UserSettingsState() when $default != null:
return $default(_that.loading,_that.password,_that.repeatPassword,_that.email,_that.digest,_that.ssoLinked,_that.error,_that.stackTrace);case _:
  return null;

}
}

}

/// @nodoc


class _UserSettingsState extends UserSettingsState implements WithError {
  const _UserSettingsState({this.loading = false, this.password = "", this.repeatPassword = "", this.email = "", final  List<EmailDigestFrequency> digest = const [], this.ssoLinked = false, this.error, this.stackTrace}): _digest = digest,super._();
  

@override@JsonKey() final  bool loading;
@override@JsonKey() final  String password;
@override@JsonKey() final  String repeatPassword;
@override@JsonKey() final  String email;
 final  List<EmailDigestFrequency> _digest;
@override@JsonKey() List<EmailDigestFrequency> get digest {
  if (_digest is EqualUnmodifiableListView) return _digest;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_digest);
}

@override@JsonKey() final  bool ssoLinked;
@override final  dynamic error;
@override final  StackTrace? stackTrace;

/// Create a copy of UserSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSettingsStateCopyWith<_UserSettingsState> get copyWith => __$UserSettingsStateCopyWithImpl<_UserSettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSettingsState&&(identical(other.loading, loading) || other.loading == loading)&&(identical(other.password, password) || other.password == password)&&(identical(other.repeatPassword, repeatPassword) || other.repeatPassword == repeatPassword)&&(identical(other.email, email) || other.email == email)&&const DeepCollectionEquality().equals(other._digest, _digest)&&(identical(other.ssoLinked, ssoLinked) || other.ssoLinked == ssoLinked)&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,loading,password,repeatPassword,email,const DeepCollectionEquality().hash(_digest),ssoLinked,const DeepCollectionEquality().hash(error),stackTrace);

@override
String toString() {
  return 'UserSettingsState(loading: $loading, password: $password, repeatPassword: $repeatPassword, email: $email, digest: $digest, ssoLinked: $ssoLinked, error: $error, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class _$UserSettingsStateCopyWith<$Res> implements $UserSettingsStateCopyWith<$Res> {
  factory _$UserSettingsStateCopyWith(_UserSettingsState value, $Res Function(_UserSettingsState) _then) = __$UserSettingsStateCopyWithImpl;
@override @useResult
$Res call({
 bool loading, String password, String repeatPassword, String email, List<EmailDigestFrequency> digest, bool ssoLinked, dynamic error, StackTrace? stackTrace
});




}
/// @nodoc
class __$UserSettingsStateCopyWithImpl<$Res>
    implements _$UserSettingsStateCopyWith<$Res> {
  __$UserSettingsStateCopyWithImpl(this._self, this._then);

  final _UserSettingsState _self;
  final $Res Function(_UserSettingsState) _then;

/// Create a copy of UserSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loading = null,Object? password = null,Object? repeatPassword = null,Object? email = null,Object? digest = null,Object? ssoLinked = null,Object? error = freezed,Object? stackTrace = freezed,}) {
  return _then(_UserSettingsState(
loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,repeatPassword: null == repeatPassword ? _self.repeatPassword : repeatPassword // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,digest: null == digest ? _self._digest : digest // ignore: cast_nullable_to_non_nullable
as List<EmailDigestFrequency>,ssoLinked: null == ssoLinked ? _self.ssoLinked : ssoLinked // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as dynamic,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

// dart format on
