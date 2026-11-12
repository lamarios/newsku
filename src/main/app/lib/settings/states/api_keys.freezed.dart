// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_keys.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApiKeysSettingsState {

 bool get loading; List<ApiKey> get keys; dynamic get error; StackTrace? get stackTrace;
/// Create a copy of ApiKeysSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiKeysSettingsStateCopyWith<ApiKeysSettingsState> get copyWith => _$ApiKeysSettingsStateCopyWithImpl<ApiKeysSettingsState>(this as ApiKeysSettingsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ApiKeysSettingsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiKeysSettingsState&&(identical(other.loading, _this.loading) || other.loading == _this.loading)&&const DeepCollectionEquality().equals(other.keys, _this.keys)&&const DeepCollectionEquality().equals(other.error, _this.error)&&(identical(other.stackTrace, _this.stackTrace) || other.stackTrace == _this.stackTrace));
}


@override
int get hashCode {
  final _this = this as ApiKeysSettingsState;
  return Object.hash(runtimeType,_this.loading,const DeepCollectionEquality().hash(_this.keys),const DeepCollectionEquality().hash(_this.error),_this.stackTrace);
}

@override
String toString() {
  final _this = this as ApiKeysSettingsState;
  return 'ApiKeysSettingsState(loading: ${_this.loading}, keys: ${_this.keys}, error: ${_this.error}, stackTrace: ${_this.stackTrace})';
}


}

/// @nodoc
abstract mixin class $ApiKeysSettingsStateCopyWith<$Res>  {
  factory $ApiKeysSettingsStateCopyWith(ApiKeysSettingsState value, $Res Function(ApiKeysSettingsState) _then) = _$ApiKeysSettingsStateCopyWithImpl;
@useResult
$Res call({
 bool loading, List<ApiKey> keys, dynamic error, StackTrace? stackTrace
});




}
/// @nodoc
class _$ApiKeysSettingsStateCopyWithImpl<$Res>
    implements $ApiKeysSettingsStateCopyWith<$Res> {
  _$ApiKeysSettingsStateCopyWithImpl(this._self, this._then);

  final ApiKeysSettingsState _self;
  final $Res Function(ApiKeysSettingsState) _then;

/// Create a copy of ApiKeysSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loading = null,Object? keys = null,Object? error = freezed,Object? stackTrace = freezed,}) {
  return _then(ApiKeysSettingsState(
loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,keys: null == keys ? _self.keys : keys // ignore: cast_nullable_to_non_nullable
as List<ApiKey>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as dynamic,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}

}


/// Adds pattern-matching-related methods to [ApiKeysSettingsState].
extension ApiKeysSettingsStatePatterns on ApiKeysSettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApiKeysSettingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApiKeysSettingsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApiKeysSettingsState value)  $default,){
final _that = this;
switch (_that) {
case _ApiKeysSettingsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApiKeysSettingsState value)?  $default,){
final _that = this;
switch (_that) {
case _ApiKeysSettingsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool loading,  List<ApiKey> keys,  dynamic error,  StackTrace? stackTrace)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApiKeysSettingsState() when $default != null:
return $default(_that.loading,_that.keys,_that.error,_that.stackTrace);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool loading,  List<ApiKey> keys,  dynamic error,  StackTrace? stackTrace)  $default,) {final _that = this;
switch (_that) {
case _ApiKeysSettingsState():
return $default(_that.loading,_that.keys,_that.error,_that.stackTrace);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool loading,  List<ApiKey> keys,  dynamic error,  StackTrace? stackTrace)?  $default,) {final _that = this;
switch (_that) {
case _ApiKeysSettingsState() when $default != null:
return $default(_that.loading,_that.keys,_that.error,_that.stackTrace);case _:
  return null;

}
}

}

/// @nodoc


class _ApiKeysSettingsState implements ApiKeysSettingsState, WithError {
  const _ApiKeysSettingsState({this.loading = true,  List<ApiKey> keys = const [], this.error, this.stackTrace}): _keys = keys;
  

@override@JsonKey() final  bool loading;
 final  List<ApiKey> _keys;
@override@JsonKey() List<ApiKey> get keys {
  if (_keys is EqualUnmodifiableListView) return _keys;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_keys);
}

@override final  dynamic error;
@override final  StackTrace? stackTrace;

/// Create a copy of ApiKeysSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApiKeysSettingsStateCopyWith<_ApiKeysSettingsState> get copyWith => __$ApiKeysSettingsStateCopyWithImpl<_ApiKeysSettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApiKeysSettingsState&&(identical(other.loading, loading) || other.loading == loading)&&const DeepCollectionEquality().equals(other.keys, _keys)&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode {
    return Object.hash(runtimeType,loading,const DeepCollectionEquality().hash(_keys),const DeepCollectionEquality().hash(error),stackTrace);
}

@override
String toString() {
    return 'ApiKeysSettingsState(loading: $loading, keys: $keys, error: $error, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class _$ApiKeysSettingsStateCopyWith<$Res> implements $ApiKeysSettingsStateCopyWith<$Res> {
  factory _$ApiKeysSettingsStateCopyWith(_ApiKeysSettingsState value, $Res Function(_ApiKeysSettingsState) _then) = __$ApiKeysSettingsStateCopyWithImpl;
@override @useResult
$Res call({
 bool loading, List<ApiKey> keys, dynamic error, StackTrace? stackTrace
});




}
/// @nodoc
class __$ApiKeysSettingsStateCopyWithImpl<$Res>
    implements _$ApiKeysSettingsStateCopyWith<$Res> {
  __$ApiKeysSettingsStateCopyWithImpl(this._self, this._then);

  final _ApiKeysSettingsState _self;
  final $Res Function(_ApiKeysSettingsState) _then;

/// Create a copy of ApiKeysSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loading = null,Object? keys = null,Object? error = freezed,Object? stackTrace = freezed,}) {
  return _then(_ApiKeysSettingsState(
loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,keys: null == keys ? _self._keys : keys // ignore: cast_nullable_to_non_nullable
as List<ApiKey>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as dynamic,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

// dart format on
