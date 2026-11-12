// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'general.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GeneralSettingsState {

 User? get user; bool get loading; dynamic get error; StackTrace? get stackTrace; String get password; String get repeatPassword;
/// Create a copy of GeneralSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeneralSettingsStateCopyWith<GeneralSettingsState> get copyWith => _$GeneralSettingsStateCopyWithImpl<GeneralSettingsState>(this as GeneralSettingsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GeneralSettingsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeneralSettingsState&&(identical(other.user, _this.user) || other.user == _this.user)&&(identical(other.loading, _this.loading) || other.loading == _this.loading)&&const DeepCollectionEquality().equals(other.error, _this.error)&&(identical(other.stackTrace, _this.stackTrace) || other.stackTrace == _this.stackTrace)&&(identical(other.password, _this.password) || other.password == _this.password)&&(identical(other.repeatPassword, _this.repeatPassword) || other.repeatPassword == _this.repeatPassword));
}


@override
int get hashCode {
  final _this = this as GeneralSettingsState;
  return Object.hash(runtimeType,_this.user,_this.loading,const DeepCollectionEquality().hash(_this.error),_this.stackTrace,_this.password,_this.repeatPassword);
}

@override
String toString() {
  final _this = this as GeneralSettingsState;
  return 'GeneralSettingsState(user: ${_this.user}, loading: ${_this.loading}, error: ${_this.error}, stackTrace: ${_this.stackTrace}, password: ${_this.password}, repeatPassword: ${_this.repeatPassword})';
}


}

/// @nodoc
abstract mixin class $GeneralSettingsStateCopyWith<$Res>  {
  factory $GeneralSettingsStateCopyWith(GeneralSettingsState value, $Res Function(GeneralSettingsState) _then) = _$GeneralSettingsStateCopyWithImpl;
@useResult
$Res call({
 User? user, bool loading, dynamic error, StackTrace? stackTrace, String password, String repeatPassword
});


$UserCopyWith<$Res>? get user;

}
/// @nodoc
class _$GeneralSettingsStateCopyWithImpl<$Res>
    implements $GeneralSettingsStateCopyWith<$Res> {
  _$GeneralSettingsStateCopyWithImpl(this._self, this._then);

  final GeneralSettingsState _self;
  final $Res Function(GeneralSettingsState) _then;

/// Create a copy of GeneralSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = freezed,Object? loading = null,Object? error = freezed,Object? stackTrace = freezed,Object? password = null,Object? repeatPassword = null,}) {
  return _then(GeneralSettingsState(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as dynamic,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,repeatPassword: null == repeatPassword ? _self.repeatPassword : repeatPassword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of GeneralSettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [GeneralSettingsState].
extension GeneralSettingsStatePatterns on GeneralSettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GeneralSettingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GeneralSettingsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GeneralSettingsState value)  $default,){
final _that = this;
switch (_that) {
case _GeneralSettingsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GeneralSettingsState value)?  $default,){
final _that = this;
switch (_that) {
case _GeneralSettingsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( User? user,  bool loading,  dynamic error,  StackTrace? stackTrace,  String password,  String repeatPassword)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GeneralSettingsState() when $default != null:
return $default(_that.user,_that.loading,_that.error,_that.stackTrace,_that.password,_that.repeatPassword);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( User? user,  bool loading,  dynamic error,  StackTrace? stackTrace,  String password,  String repeatPassword)  $default,) {final _that = this;
switch (_that) {
case _GeneralSettingsState():
return $default(_that.user,_that.loading,_that.error,_that.stackTrace,_that.password,_that.repeatPassword);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( User? user,  bool loading,  dynamic error,  StackTrace? stackTrace,  String password,  String repeatPassword)?  $default,) {final _that = this;
switch (_that) {
case _GeneralSettingsState() when $default != null:
return $default(_that.user,_that.loading,_that.error,_that.stackTrace,_that.password,_that.repeatPassword);case _:
  return null;

}
}

}

/// @nodoc


class _GeneralSettingsState implements GeneralSettingsState, WithError {
  const _GeneralSettingsState({this.user, this.loading = true, this.error, this.stackTrace, this.password = '', this.repeatPassword = ''});
  

@override final  User? user;
@override@JsonKey() final  bool loading;
@override final  dynamic error;
@override final  StackTrace? stackTrace;
@override@JsonKey() final  String password;
@override@JsonKey() final  String repeatPassword;

/// Create a copy of GeneralSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GeneralSettingsStateCopyWith<_GeneralSettingsState> get copyWith => __$GeneralSettingsStateCopyWithImpl<_GeneralSettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeneralSettingsState&&(identical(other.user, user) || other.user == user)&&(identical(other.loading, loading) || other.loading == loading)&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace)&&(identical(other.password, password) || other.password == password)&&(identical(other.repeatPassword, repeatPassword) || other.repeatPassword == repeatPassword));
}


@override
int get hashCode {
    return Object.hash(runtimeType,user,loading,const DeepCollectionEquality().hash(error),stackTrace,password,repeatPassword);
}

@override
String toString() {
    return 'GeneralSettingsState(user: $user, loading: $loading, error: $error, stackTrace: $stackTrace, password: $password, repeatPassword: $repeatPassword)';
}


}

/// @nodoc
abstract mixin class _$GeneralSettingsStateCopyWith<$Res> implements $GeneralSettingsStateCopyWith<$Res> {
  factory _$GeneralSettingsStateCopyWith(_GeneralSettingsState value, $Res Function(_GeneralSettingsState) _then) = __$GeneralSettingsStateCopyWithImpl;
@override @useResult
$Res call({
 User? user, bool loading, dynamic error, StackTrace? stackTrace, String password, String repeatPassword
});


@override $UserCopyWith<$Res>? get user;

}
/// @nodoc
class __$GeneralSettingsStateCopyWithImpl<$Res>
    implements _$GeneralSettingsStateCopyWith<$Res> {
  __$GeneralSettingsStateCopyWithImpl(this._self, this._then);

  final _GeneralSettingsState _self;
  final $Res Function(_GeneralSettingsState) _then;

/// Create a copy of GeneralSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = freezed,Object? loading = null,Object? error = freezed,Object? stackTrace = freezed,Object? password = null,Object? repeatPassword = null,}) {
  return _then(_GeneralSettingsState(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as dynamic,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,repeatPassword: null == repeatPassword ? _self.repeatPassword : repeatPassword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of GeneralSettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
