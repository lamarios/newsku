// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'server_url.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ServerUrlState {

 String? get serverUrl; bool get loading; Config? get config; bool get error;
/// Create a copy of ServerUrlState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerUrlStateCopyWith<ServerUrlState> get copyWith => _$ServerUrlStateCopyWithImpl<ServerUrlState>(this as ServerUrlState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ServerUrlState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerUrlState&&(identical(other.serverUrl, _this.serverUrl) || other.serverUrl == _this.serverUrl)&&(identical(other.loading, _this.loading) || other.loading == _this.loading)&&(identical(other.config, _this.config) || other.config == _this.config)&&(identical(other.error, _this.error) || other.error == _this.error));
}


@override
int get hashCode {
  final _this = this as ServerUrlState;
  return Object.hash(runtimeType,_this.serverUrl,_this.loading,_this.config,_this.error);
}

@override
String toString() {
  final _this = this as ServerUrlState;
  return 'ServerUrlState(serverUrl: ${_this.serverUrl}, loading: ${_this.loading}, config: ${_this.config}, error: ${_this.error})';
}


}

/// @nodoc
abstract mixin class $ServerUrlStateCopyWith<$Res>  {
  factory $ServerUrlStateCopyWith(ServerUrlState value, $Res Function(ServerUrlState) _then) = _$ServerUrlStateCopyWithImpl;
@useResult
$Res call({
 String? serverUrl, bool loading, Config? config, bool error
});


$ConfigCopyWith<$Res>? get config;

}
/// @nodoc
class _$ServerUrlStateCopyWithImpl<$Res>
    implements $ServerUrlStateCopyWith<$Res> {
  _$ServerUrlStateCopyWithImpl(this._self, this._then);

  final ServerUrlState _self;
  final $Res Function(ServerUrlState) _then;

/// Create a copy of ServerUrlState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? serverUrl = freezed,Object? loading = null,Object? config = freezed,Object? error = null,}) {
  return _then(ServerUrlState(
serverUrl: freezed == serverUrl ? _self.serverUrl : serverUrl // ignore: cast_nullable_to_non_nullable
as String?,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,config: freezed == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as Config?,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ServerUrlState
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
}
}


/// Adds pattern-matching-related methods to [ServerUrlState].
extension ServerUrlStatePatterns on ServerUrlState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServerUrlState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServerUrlState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServerUrlState value)  $default,){
final _that = this;
switch (_that) {
case _ServerUrlState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServerUrlState value)?  $default,){
final _that = this;
switch (_that) {
case _ServerUrlState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? serverUrl,  bool loading,  Config? config,  bool error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServerUrlState() when $default != null:
return $default(_that.serverUrl,_that.loading,_that.config,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? serverUrl,  bool loading,  Config? config,  bool error)  $default,) {final _that = this;
switch (_that) {
case _ServerUrlState():
return $default(_that.serverUrl,_that.loading,_that.config,_that.error);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? serverUrl,  bool loading,  Config? config,  bool error)?  $default,) {final _that = this;
switch (_that) {
case _ServerUrlState() when $default != null:
return $default(_that.serverUrl,_that.loading,_that.config,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _ServerUrlState implements ServerUrlState {
  const _ServerUrlState({this.serverUrl, this.loading = false, this.config, this.error = false});
  

@override final  String? serverUrl;
@override@JsonKey() final  bool loading;
@override final  Config? config;
@override@JsonKey() final  bool error;

/// Create a copy of ServerUrlState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServerUrlStateCopyWith<_ServerUrlState> get copyWith => __$ServerUrlStateCopyWithImpl<_ServerUrlState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServerUrlState&&(identical(other.serverUrl, serverUrl) || other.serverUrl == serverUrl)&&(identical(other.loading, loading) || other.loading == loading)&&(identical(other.config, config) || other.config == config)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode {
    return Object.hash(runtimeType,serverUrl,loading,config,error);
}

@override
String toString() {
    return 'ServerUrlState(serverUrl: $serverUrl, loading: $loading, config: $config, error: $error)';
}


}

/// @nodoc
abstract mixin class _$ServerUrlStateCopyWith<$Res> implements $ServerUrlStateCopyWith<$Res> {
  factory _$ServerUrlStateCopyWith(_ServerUrlState value, $Res Function(_ServerUrlState) _then) = __$ServerUrlStateCopyWithImpl;
@override @useResult
$Res call({
 String? serverUrl, bool loading, Config? config, bool error
});


@override $ConfigCopyWith<$Res>? get config;

}
/// @nodoc
class __$ServerUrlStateCopyWithImpl<$Res>
    implements _$ServerUrlStateCopyWith<$Res> {
  __$ServerUrlStateCopyWithImpl(this._self, this._then);

  final _ServerUrlState _self;
  final $Res Function(_ServerUrlState) _then;

/// Create a copy of ServerUrlState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? serverUrl = freezed,Object? loading = null,Object? config = freezed,Object? error = null,}) {
  return _then(_ServerUrlState(
serverUrl: freezed == serverUrl ? _self.serverUrl : serverUrl // ignore: cast_nullable_to_non_nullable
as String?,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,config: freezed == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as Config?,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ServerUrlState
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
}
}

// dart format on
