// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_key.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ApiKey {

 String get id; String get name; int get timeCreated; int? get expiresAt; int? get lastUsed; bool get expired;
/// Create a copy of ApiKey
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiKeyCopyWith<ApiKey> get copyWith => _$ApiKeyCopyWithImpl<ApiKey>(this as ApiKey, _$identity);

  /// Serializes this ApiKey to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ApiKey;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiKey&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.timeCreated, _this.timeCreated) || other.timeCreated == _this.timeCreated)&&(identical(other.expiresAt, _this.expiresAt) || other.expiresAt == _this.expiresAt)&&(identical(other.lastUsed, _this.lastUsed) || other.lastUsed == _this.lastUsed)&&(identical(other.expired, _this.expired) || other.expired == _this.expired));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ApiKey;
  return Object.hash(runtimeType,_this.id,_this.name,_this.timeCreated,_this.expiresAt,_this.lastUsed,_this.expired);
}

@override
String toString() {
  final _this = this as ApiKey;
  return 'ApiKey(id: ${_this.id}, name: ${_this.name}, timeCreated: ${_this.timeCreated}, expiresAt: ${_this.expiresAt}, lastUsed: ${_this.lastUsed}, expired: ${_this.expired})';
}


}

/// @nodoc
abstract mixin class $ApiKeyCopyWith<$Res>  {
  factory $ApiKeyCopyWith(ApiKey value, $Res Function(ApiKey) _then) = _$ApiKeyCopyWithImpl;
@useResult
$Res call({
 String id, String name, int timeCreated, int? expiresAt, int? lastUsed, bool expired
});




}
/// @nodoc
class _$ApiKeyCopyWithImpl<$Res>
    implements $ApiKeyCopyWith<$Res> {
  _$ApiKeyCopyWithImpl(this._self, this._then);

  final ApiKey _self;
  final $Res Function(ApiKey) _then;

/// Create a copy of ApiKey
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? timeCreated = null,Object? expiresAt = freezed,Object? lastUsed = freezed,Object? expired = null,}) {
  return _then(ApiKey(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,timeCreated: null == timeCreated ? _self.timeCreated : timeCreated // ignore: cast_nullable_to_non_nullable
as int,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as int?,lastUsed: freezed == lastUsed ? _self.lastUsed : lastUsed // ignore: cast_nullable_to_non_nullable
as int?,expired: null == expired ? _self.expired : expired // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ApiKey].
extension ApiKeyPatterns on ApiKey {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApiKey value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApiKey() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApiKey value)  $default,){
final _that = this;
switch (_that) {
case _ApiKey():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApiKey value)?  $default,){
final _that = this;
switch (_that) {
case _ApiKey() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int timeCreated,  int? expiresAt,  int? lastUsed,  bool expired)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApiKey() when $default != null:
return $default(_that.id,_that.name,_that.timeCreated,_that.expiresAt,_that.lastUsed,_that.expired);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int timeCreated,  int? expiresAt,  int? lastUsed,  bool expired)  $default,) {final _that = this;
switch (_that) {
case _ApiKey():
return $default(_that.id,_that.name,_that.timeCreated,_that.expiresAt,_that.lastUsed,_that.expired);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int timeCreated,  int? expiresAt,  int? lastUsed,  bool expired)?  $default,) {final _that = this;
switch (_that) {
case _ApiKey() when $default != null:
return $default(_that.id,_that.name,_that.timeCreated,_that.expiresAt,_that.lastUsed,_that.expired);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApiKey implements ApiKey {
  const _ApiKey({required this.id, required this.name, required this.timeCreated, this.expiresAt, this.lastUsed, this.expired = false});
  factory _ApiKey.fromJson(Map<String, dynamic> json) => _$ApiKeyFromJson(json);

@override final  String id;
@override final  String name;
@override final  int timeCreated;
@override final  int? expiresAt;
@override final  int? lastUsed;
@override@JsonKey() final  bool expired;

/// Create a copy of ApiKey
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApiKeyCopyWith<_ApiKey> get copyWith => __$ApiKeyCopyWithImpl<_ApiKey>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApiKeyToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApiKey&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.timeCreated, timeCreated) || other.timeCreated == timeCreated)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.lastUsed, lastUsed) || other.lastUsed == lastUsed)&&(identical(other.expired, expired) || other.expired == expired));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,timeCreated,expiresAt,lastUsed,expired);
}

@override
String toString() {
    return 'ApiKey(id: $id, name: $name, timeCreated: $timeCreated, expiresAt: $expiresAt, lastUsed: $lastUsed, expired: $expired)';
}


}

/// @nodoc
abstract mixin class _$ApiKeyCopyWith<$Res> implements $ApiKeyCopyWith<$Res> {
  factory _$ApiKeyCopyWith(_ApiKey value, $Res Function(_ApiKey) _then) = __$ApiKeyCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int timeCreated, int? expiresAt, int? lastUsed, bool expired
});




}
/// @nodoc
class __$ApiKeyCopyWithImpl<$Res>
    implements _$ApiKeyCopyWith<$Res> {
  __$ApiKeyCopyWithImpl(this._self, this._then);

  final _ApiKey _self;
  final $Res Function(_ApiKey) _then;

/// Create a copy of ApiKey
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? timeCreated = null,Object? expiresAt = freezed,Object? lastUsed = freezed,Object? expired = null,}) {
  return _then(_ApiKey(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,timeCreated: null == timeCreated ? _self.timeCreated : timeCreated // ignore: cast_nullable_to_non_nullable
as int,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as int?,lastUsed: freezed == lastUsed ? _self.lastUsed : lastUsed // ignore: cast_nullable_to_non_nullable
as int?,expired: null == expired ? _self.expired : expired // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$CreatedApiKey {

 ApiKey get apiKey; String get key;
/// Create a copy of CreatedApiKey
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatedApiKeyCopyWith<CreatedApiKey> get copyWith => _$CreatedApiKeyCopyWithImpl<CreatedApiKey>(this as CreatedApiKey, _$identity);

  /// Serializes this CreatedApiKey to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CreatedApiKey;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatedApiKey&&(identical(other.apiKey, _this.apiKey) || other.apiKey == _this.apiKey)&&(identical(other.key, _this.key) || other.key == _this.key));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CreatedApiKey;
  return Object.hash(runtimeType,_this.apiKey,_this.key);
}

@override
String toString() {
  final _this = this as CreatedApiKey;
  return 'CreatedApiKey(apiKey: ${_this.apiKey}, key: ${_this.key})';
}


}

/// @nodoc
abstract mixin class $CreatedApiKeyCopyWith<$Res>  {
  factory $CreatedApiKeyCopyWith(CreatedApiKey value, $Res Function(CreatedApiKey) _then) = _$CreatedApiKeyCopyWithImpl;
@useResult
$Res call({
 ApiKey apiKey, String key
});


$ApiKeyCopyWith<$Res> get apiKey;

}
/// @nodoc
class _$CreatedApiKeyCopyWithImpl<$Res>
    implements $CreatedApiKeyCopyWith<$Res> {
  _$CreatedApiKeyCopyWithImpl(this._self, this._then);

  final CreatedApiKey _self;
  final $Res Function(CreatedApiKey) _then;

/// Create a copy of CreatedApiKey
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? apiKey = null,Object? key = null,}) {
  return _then(CreatedApiKey(
apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as ApiKey,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of CreatedApiKey
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiKeyCopyWith<$Res> get apiKey {
  
  return $ApiKeyCopyWith<$Res>(_self.apiKey, (value) {
    return _then(_self.copyWith(apiKey: value));
  });
}
}


/// Adds pattern-matching-related methods to [CreatedApiKey].
extension CreatedApiKeyPatterns on CreatedApiKey {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatedApiKey value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatedApiKey() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatedApiKey value)  $default,){
final _that = this;
switch (_that) {
case _CreatedApiKey():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatedApiKey value)?  $default,){
final _that = this;
switch (_that) {
case _CreatedApiKey() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ApiKey apiKey,  String key)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatedApiKey() when $default != null:
return $default(_that.apiKey,_that.key);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ApiKey apiKey,  String key)  $default,) {final _that = this;
switch (_that) {
case _CreatedApiKey():
return $default(_that.apiKey,_that.key);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ApiKey apiKey,  String key)?  $default,) {final _that = this;
switch (_that) {
case _CreatedApiKey() when $default != null:
return $default(_that.apiKey,_that.key);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreatedApiKey implements CreatedApiKey {
  const _CreatedApiKey({required this.apiKey, required this.key});
  factory _CreatedApiKey.fromJson(Map<String, dynamic> json) => _$CreatedApiKeyFromJson(json);

@override final  ApiKey apiKey;
@override final  String key;

/// Create a copy of CreatedApiKey
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatedApiKeyCopyWith<_CreatedApiKey> get copyWith => __$CreatedApiKeyCopyWithImpl<_CreatedApiKey>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreatedApiKeyToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatedApiKey&&(identical(other.apiKey, apiKey) || other.apiKey == apiKey)&&(identical(other.key, key) || other.key == key));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,apiKey,key);
}

@override
String toString() {
    return 'CreatedApiKey(apiKey: $apiKey, key: $key)';
}


}

/// @nodoc
abstract mixin class _$CreatedApiKeyCopyWith<$Res> implements $CreatedApiKeyCopyWith<$Res> {
  factory _$CreatedApiKeyCopyWith(_CreatedApiKey value, $Res Function(_CreatedApiKey) _then) = __$CreatedApiKeyCopyWithImpl;
@override @useResult
$Res call({
 ApiKey apiKey, String key
});


@override $ApiKeyCopyWith<$Res> get apiKey;

}
/// @nodoc
class __$CreatedApiKeyCopyWithImpl<$Res>
    implements _$CreatedApiKeyCopyWith<$Res> {
  __$CreatedApiKeyCopyWithImpl(this._self, this._then);

  final _CreatedApiKey _self;
  final $Res Function(_CreatedApiKey) _then;

/// Create a copy of CreatedApiKey
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? apiKey = null,Object? key = null,}) {
  return _then(_CreatedApiKey(
apiKey: null == apiKey ? _self.apiKey : apiKey // ignore: cast_nullable_to_non_nullable
as ApiKey,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of CreatedApiKey
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiKeyCopyWith<$Res> get apiKey {
  
  return $ApiKeyCopyWith<$Res>(_self.apiKey, (value) {
    return _then(_self.copyWith(apiKey: value));
  });
}
}

// dart format on
