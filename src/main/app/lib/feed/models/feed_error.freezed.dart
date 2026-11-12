// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeedError {

 String get id; String? get url; int get timeCreated; String? get error; String get message;
/// Create a copy of FeedError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedErrorCopyWith<FeedError> get copyWith => _$FeedErrorCopyWithImpl<FeedError>(this as FeedError, _$identity);

  /// Serializes this FeedError to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FeedError;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedError&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.url, _this.url) || other.url == _this.url)&&(identical(other.timeCreated, _this.timeCreated) || other.timeCreated == _this.timeCreated)&&(identical(other.error, _this.error) || other.error == _this.error)&&(identical(other.message, _this.message) || other.message == _this.message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FeedError;
  return Object.hash(runtimeType,_this.id,_this.url,_this.timeCreated,_this.error,_this.message);
}

@override
String toString() {
  final _this = this as FeedError;
  return 'FeedError(id: ${_this.id}, url: ${_this.url}, timeCreated: ${_this.timeCreated}, error: ${_this.error}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $FeedErrorCopyWith<$Res>  {
  factory $FeedErrorCopyWith(FeedError value, $Res Function(FeedError) _then) = _$FeedErrorCopyWithImpl;
@useResult
$Res call({
 String id, String? url, int timeCreated, String? error, String message
});




}
/// @nodoc
class _$FeedErrorCopyWithImpl<$Res>
    implements $FeedErrorCopyWith<$Res> {
  _$FeedErrorCopyWithImpl(this._self, this._then);

  final FeedError _self;
  final $Res Function(FeedError) _then;

/// Create a copy of FeedError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? url = freezed,Object? timeCreated = null,Object? error = freezed,Object? message = null,}) {
  return _then(FeedError(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,timeCreated: null == timeCreated ? _self.timeCreated : timeCreated // ignore: cast_nullable_to_non_nullable
as int,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedError].
extension FeedErrorPatterns on FeedError {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedError value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedError() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedError value)  $default,){
final _that = this;
switch (_that) {
case _FeedError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedError value)?  $default,){
final _that = this;
switch (_that) {
case _FeedError() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? url,  int timeCreated,  String? error,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedError() when $default != null:
return $default(_that.id,_that.url,_that.timeCreated,_that.error,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? url,  int timeCreated,  String? error,  String message)  $default,) {final _that = this;
switch (_that) {
case _FeedError():
return $default(_that.id,_that.url,_that.timeCreated,_that.error,_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? url,  int timeCreated,  String? error,  String message)?  $default,) {final _that = this;
switch (_that) {
case _FeedError() when $default != null:
return $default(_that.id,_that.url,_that.timeCreated,_that.error,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedError implements FeedError {
  const _FeedError({required this.id, this.url, required this.timeCreated, this.error, required this.message});
  factory _FeedError.fromJson(Map<String, dynamic> json) => _$FeedErrorFromJson(json);

@override final  String id;
@override final  String? url;
@override final  int timeCreated;
@override final  String? error;
@override final  String message;

/// Create a copy of FeedError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedErrorCopyWith<_FeedError> get copyWith => __$FeedErrorCopyWithImpl<_FeedError>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedErrorToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedError&&(identical(other.id, id) || other.id == id)&&(identical(other.url, url) || other.url == url)&&(identical(other.timeCreated, timeCreated) || other.timeCreated == timeCreated)&&(identical(other.error, error) || other.error == error)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,url,timeCreated,error,message);
}

@override
String toString() {
    return 'FeedError(id: $id, url: $url, timeCreated: $timeCreated, error: $error, message: $message)';
}


}

/// @nodoc
abstract mixin class _$FeedErrorCopyWith<$Res> implements $FeedErrorCopyWith<$Res> {
  factory _$FeedErrorCopyWith(_FeedError value, $Res Function(_FeedError) _then) = __$FeedErrorCopyWithImpl;
@override @useResult
$Res call({
 String id, String? url, int timeCreated, String? error, String message
});




}
/// @nodoc
class __$FeedErrorCopyWithImpl<$Res>
    implements _$FeedErrorCopyWith<$Res> {
  __$FeedErrorCopyWithImpl(this._self, this._then);

  final _FeedError _self;
  final $Res Function(_FeedError) _then;

/// Create a copy of FeedError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? url = freezed,Object? timeCreated = null,Object? error = freezed,Object? message = null,}) {
  return _then(_FeedError(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,timeCreated: null == timeCreated ? _self.timeCreated : timeCreated // ignore: cast_nullable_to_non_nullable
as int,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
