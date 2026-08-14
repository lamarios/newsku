// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'newsku_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NewskuError {

 ErrorType get type; String? get uuid; String get message;@JsonKey(includeToJson: false, includeFromJson: false) StackTrace? get stackTrace;
/// Create a copy of NewskuError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewskuErrorCopyWith<NewskuError> get copyWith => _$NewskuErrorCopyWithImpl<NewskuError>(this as NewskuError, _$identity);

  /// Serializes this NewskuError to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewskuError&&(identical(other.type, type) || other.type == type)&&(identical(other.uuid, uuid) || other.uuid == uuid)&&(identical(other.message, message) || other.message == message)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,uuid,message,stackTrace);

@override
String toString() {
  return 'NewskuError(type: $type, uuid: $uuid, message: $message, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $NewskuErrorCopyWith<$Res>  {
  factory $NewskuErrorCopyWith(NewskuError value, $Res Function(NewskuError) _then) = _$NewskuErrorCopyWithImpl;
@useResult
$Res call({
 ErrorType type, String? uuid, String message,@JsonKey(includeToJson: false, includeFromJson: false) StackTrace? stackTrace
});




}
/// @nodoc
class _$NewskuErrorCopyWithImpl<$Res>
    implements $NewskuErrorCopyWith<$Res> {
  _$NewskuErrorCopyWithImpl(this._self, this._then);

  final NewskuError _self;
  final $Res Function(NewskuError) _then;

/// Create a copy of NewskuError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? uuid = freezed,Object? message = null,Object? stackTrace = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ErrorType,uuid: freezed == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String?,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}

}


/// Adds pattern-matching-related methods to [NewskuError].
extension NewskuErrorPatterns on NewskuError {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewskuError value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewskuError() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewskuError value)  $default,){
final _that = this;
switch (_that) {
case _NewskuError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewskuError value)?  $default,){
final _that = this;
switch (_that) {
case _NewskuError() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ErrorType type,  String? uuid,  String message, @JsonKey(includeToJson: false, includeFromJson: false)  StackTrace? stackTrace)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewskuError() when $default != null:
return $default(_that.type,_that.uuid,_that.message,_that.stackTrace);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ErrorType type,  String? uuid,  String message, @JsonKey(includeToJson: false, includeFromJson: false)  StackTrace? stackTrace)  $default,) {final _that = this;
switch (_that) {
case _NewskuError():
return $default(_that.type,_that.uuid,_that.message,_that.stackTrace);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ErrorType type,  String? uuid,  String message, @JsonKey(includeToJson: false, includeFromJson: false)  StackTrace? stackTrace)?  $default,) {final _that = this;
switch (_that) {
case _NewskuError() when $default != null:
return $default(_that.type,_that.uuid,_that.message,_that.stackTrace);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NewskuError extends NewskuError implements Error {
  const _NewskuError({required this.type, required this.uuid, this.message = "", @JsonKey(includeToJson: false, includeFromJson: false) this.stackTrace}): super._();
  factory _NewskuError.fromJson(Map<String, dynamic> json) => _$NewskuErrorFromJson(json);

@override final  ErrorType type;
@override final  String? uuid;
@override@JsonKey() final  String message;
@override@JsonKey(includeToJson: false, includeFromJson: false) final  StackTrace? stackTrace;

/// Create a copy of NewskuError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewskuErrorCopyWith<_NewskuError> get copyWith => __$NewskuErrorCopyWithImpl<_NewskuError>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NewskuErrorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewskuError&&(identical(other.type, type) || other.type == type)&&(identical(other.uuid, uuid) || other.uuid == uuid)&&(identical(other.message, message) || other.message == message)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,uuid,message,stackTrace);

@override
String toString() {
  return 'NewskuError(type: $type, uuid: $uuid, message: $message, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class _$NewskuErrorCopyWith<$Res> implements $NewskuErrorCopyWith<$Res> {
  factory _$NewskuErrorCopyWith(_NewskuError value, $Res Function(_NewskuError) _then) = __$NewskuErrorCopyWithImpl;
@override @useResult
$Res call({
 ErrorType type, String? uuid, String message,@JsonKey(includeToJson: false, includeFromJson: false) StackTrace? stackTrace
});




}
/// @nodoc
class __$NewskuErrorCopyWithImpl<$Res>
    implements _$NewskuErrorCopyWith<$Res> {
  __$NewskuErrorCopyWithImpl(this._self, this._then);

  final _NewskuError _self;
  final $Res Function(_NewskuError) _then;

/// Create a copy of NewskuError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? uuid = freezed,Object? message = null,Object? stackTrace = freezed,}) {
  return _then(_NewskuError(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ErrorType,uuid: freezed == uuid ? _self.uuid : uuid // ignore: cast_nullable_to_non_nullable
as String?,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

// dart format on
