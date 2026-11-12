// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'identity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$IdentityState implements DiagnosticableTreeMixin {

 String? get token; String? get serverUrl; Config? get config; User? get currentUser;
/// Create a copy of IdentityState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IdentityStateCopyWith<IdentityState> get copyWith => _$IdentityStateCopyWithImpl<IdentityState>(this as IdentityState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  final _this = this as IdentityState;
  properties
    ..add(DiagnosticsProperty('type', 'IdentityState'))
    ..add(DiagnosticsProperty('token', _this.token))..add(DiagnosticsProperty('serverUrl', _this.serverUrl))..add(DiagnosticsProperty('config', _this.config))..add(DiagnosticsProperty('currentUser', _this.currentUser));
}

@override
bool operator ==(Object other) {
  final _this = this as IdentityState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IdentityState&&(identical(other.token, _this.token) || other.token == _this.token)&&(identical(other.serverUrl, _this.serverUrl) || other.serverUrl == _this.serverUrl)&&(identical(other.config, _this.config) || other.config == _this.config)&&(identical(other.currentUser, _this.currentUser) || other.currentUser == _this.currentUser));
}


@override
int get hashCode {
  final _this = this as IdentityState;
  return Object.hash(runtimeType,_this.token,_this.serverUrl,_this.config,_this.currentUser);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  final _this = this as IdentityState;
  return 'IdentityState(token: ${_this.token}, serverUrl: ${_this.serverUrl}, config: ${_this.config}, currentUser: ${_this.currentUser})';
}


}

/// @nodoc
abstract mixin class $IdentityStateCopyWith<$Res>  {
  factory $IdentityStateCopyWith(IdentityState value, $Res Function(IdentityState) _then) = _$IdentityStateCopyWithImpl;
@useResult
$Res call({
 String? token, String? serverUrl, Config? config, User? currentUser
});


$ConfigCopyWith<$Res>? get config;$UserCopyWith<$Res>? get currentUser;

}
/// @nodoc
class _$IdentityStateCopyWithImpl<$Res>
    implements $IdentityStateCopyWith<$Res> {
  _$IdentityStateCopyWithImpl(this._self, this._then);

  final IdentityState _self;
  final $Res Function(IdentityState) _then;

/// Create a copy of IdentityState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? token = freezed,Object? serverUrl = freezed,Object? config = freezed,Object? currentUser = freezed,}) {
  return _then(IdentityState(
token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,serverUrl: freezed == serverUrl ? _self.serverUrl : serverUrl // ignore: cast_nullable_to_non_nullable
as String?,config: freezed == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as Config?,currentUser: freezed == currentUser ? _self.currentUser : currentUser // ignore: cast_nullable_to_non_nullable
as User?,
  ));
}
/// Create a copy of IdentityState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConfigCopyWith<$Res>? get config {
    if (_self.config == null) {
    return null;
  }

  return $ConfigCopyWith<$Res>(_self.config!, (value) {
    return _then(_self.copyWith(config: value));
  });
}/// Create a copy of IdentityState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get currentUser {
    if (_self.currentUser == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.currentUser!, (value) {
    return _then(_self.copyWith(currentUser: value));
  });
}
}


/// Adds pattern-matching-related methods to [IdentityState].
extension IdentityStatePatterns on IdentityState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IdentityState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IdentityState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IdentityState value)  $default,){
final _that = this;
switch (_that) {
case _IdentityState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IdentityState value)?  $default,){
final _that = this;
switch (_that) {
case _IdentityState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? token,  String? serverUrl,  Config? config,  User? currentUser)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IdentityState() when $default != null:
return $default(_that.token,_that.serverUrl,_that.config,_that.currentUser);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? token,  String? serverUrl,  Config? config,  User? currentUser)  $default,) {final _that = this;
switch (_that) {
case _IdentityState():
return $default(_that.token,_that.serverUrl,_that.config,_that.currentUser);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? token,  String? serverUrl,  Config? config,  User? currentUser)?  $default,) {final _that = this;
switch (_that) {
case _IdentityState() when $default != null:
return $default(_that.token,_that.serverUrl,_that.config,_that.currentUser);case _:
  return null;

}
}

}

/// @nodoc


class _IdentityState extends IdentityState with DiagnosticableTreeMixin {
  const _IdentityState({this.token, this.serverUrl, this.config, this.currentUser}): super._();
  

@override final  String? token;
@override final  String? serverUrl;
@override final  Config? config;
@override final  User? currentUser;

/// Create a copy of IdentityState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IdentityStateCopyWith<_IdentityState> get copyWith => __$IdentityStateCopyWithImpl<_IdentityState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
    ..add(DiagnosticsProperty('type', 'IdentityState'))
    ..add(DiagnosticsProperty('token', token))..add(DiagnosticsProperty('serverUrl', serverUrl))..add(DiagnosticsProperty('config', config))..add(DiagnosticsProperty('currentUser', currentUser));
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _IdentityState&&(identical(other.token, token) || other.token == token)&&(identical(other.serverUrl, serverUrl) || other.serverUrl == serverUrl)&&(identical(other.config, config) || other.config == config)&&(identical(other.currentUser, currentUser) || other.currentUser == currentUser));
}


@override
int get hashCode {
    return Object.hash(runtimeType,token,serverUrl,config,currentUser);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    return 'IdentityState(token: $token, serverUrl: $serverUrl, config: $config, currentUser: $currentUser)';
}


}

/// @nodoc
abstract mixin class _$IdentityStateCopyWith<$Res> implements $IdentityStateCopyWith<$Res> {
  factory _$IdentityStateCopyWith(_IdentityState value, $Res Function(_IdentityState) _then) = __$IdentityStateCopyWithImpl;
@override @useResult
$Res call({
 String? token, String? serverUrl, Config? config, User? currentUser
});


@override $ConfigCopyWith<$Res>? get config;@override $UserCopyWith<$Res>? get currentUser;

}
/// @nodoc
class __$IdentityStateCopyWithImpl<$Res>
    implements _$IdentityStateCopyWith<$Res> {
  __$IdentityStateCopyWithImpl(this._self, this._then);

  final _IdentityState _self;
  final $Res Function(_IdentityState) _then;

/// Create a copy of IdentityState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? token = freezed,Object? serverUrl = freezed,Object? config = freezed,Object? currentUser = freezed,}) {
  return _then(_IdentityState(
token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,serverUrl: freezed == serverUrl ? _self.serverUrl : serverUrl // ignore: cast_nullable_to_non_nullable
as String?,config: freezed == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as Config?,currentUser: freezed == currentUser ? _self.currentUser : currentUser // ignore: cast_nullable_to_non_nullable
as User?,
  ));
}

/// Create a copy of IdentityState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConfigCopyWith<$Res>? get config {
    if (_self.config == null) {
    return null;
  }

  return $ConfigCopyWith<$Res>(_self.config!, (value) {
    return _then(_self.copyWith(config: value));
  });
}/// Create a copy of IdentityState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get currentUser {
    if (_self.currentUser == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.currentUser!, (value) {
    return _then(_self.copyWith(currentUser: value));
  });
}
}

// dart format on
