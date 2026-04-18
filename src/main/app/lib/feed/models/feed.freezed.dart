// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Feed {

  String? get id;

  String? get name;

  String? get description;

  String? get url;

  String? get itemPreference;

  String? get image;

  FeedCategory? get category;

  int get lastRefreshErrors;
/// Create a copy of Feed
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedCopyWith<Feed> get copyWith => _$FeedCopyWithImpl<Feed>(this as Feed, _$identity);

  /// Serializes this Feed to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType && other is Feed && (identical(other.id, id) || other.id == id) && (identical(other.name, name) || other.name == name) &&
      (identical(other.description, description) || other.description == description) && (identical(other.url, url) || other.url == url) &&
      (identical(other.itemPreference, itemPreference) || other.itemPreference == itemPreference) && (identical(other.image, image) || other.image == image) &&
      (identical(other.category, category) || other.category == category) && (identical(other.lastRefreshErrors, lastRefreshErrors) || other.lastRefreshErrors == lastRefreshErrors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode =>
    Object.hash(
        runtimeType,
        id,
        name,
        description,
        url,
        itemPreference,
        image,
        category,
        lastRefreshErrors);

@override
String toString() {
  return 'Feed(id: $id, name: $name, description: $description, url: $url, itemPreference: $itemPreference, image: $image, category: $category, lastRefreshErrors: $lastRefreshErrors)';
}


}

/// @nodoc
abstract mixin class $FeedCopyWith<$Res>  {
  factory $FeedCopyWith(Feed value, $Res Function(Feed) _then) = _$FeedCopyWithImpl;
@useResult
$Res call({
  String? id, String? name, String? description, String? url, String? itemPreference, String? image, FeedCategory? category, int lastRefreshErrors
});


  $FeedCategoryCopyWith<$Res>? get category;

}
/// @nodoc
class _$FeedCopyWithImpl<$Res>
    implements $FeedCopyWith<$Res> {
  _$FeedCopyWithImpl(this._self, this._then);

  final Feed _self;
  final $Res Function(Feed) _then;

/// Create a copy of Feed
/// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call(
      {Object? id = freezed, Object? name = freezed, Object? description = freezed, Object? url = freezed, Object? itemPreference = freezed, Object? image = freezed, Object? category = freezed, Object? lastRefreshErrors = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,itemPreference: freezed == itemPreference ? _self.itemPreference : itemPreference // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
  as String?,
    category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
    as FeedCategory?,
    lastRefreshErrors: null == lastRefreshErrors ? _self.lastRefreshErrors : lastRefreshErrors // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

  /// Create a copy of Feed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FeedCategoryCopyWith<$Res>? get category {
    if (_self.category == null) {
      return null;
    }

    return $FeedCategoryCopyWith<$Res>(_self.category!, (value) {
      return _then(_self.copyWith(category: value));
    });
  }
}


/// Adds pattern-matching-related methods to [Feed].
extension FeedPatterns on Feed {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Feed value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Feed() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Feed value)  $default,){
final _that = this;
switch (_that) {
case _Feed():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Feed value)?  $default,){
final _that = this;
switch (_that) {
case _Feed() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id, String? name, String? description, String? url, String? itemPreference, String? image, FeedCategory? category, int lastRefreshErrors)? $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Feed() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.url,_that.itemPreference,_that.image,_that.category,_that.lastRefreshErrors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id, String? name, String? description, String? url, String? itemPreference, String? image, FeedCategory? category, int lastRefreshErrors) $default,) {final _that = this;
switch (_that) {
case _Feed():
return $default(_that.id,_that.name,_that.description,_that.url,_that.itemPreference,_that.image,_that.category,_that.lastRefreshErrors);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id, String? name, String? description, String? url, String? itemPreference, String? image, FeedCategory? category, int lastRefreshErrors)? $default,) {final _that = this;
switch (_that) {
case _Feed() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.url,_that.itemPreference,_that.image,_that.category,_that.lastRefreshErrors);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Feed implements Feed {
  const _Feed({this.id, this.name, this.description, this.url, this.itemPreference, this.image, this.category, this.lastRefreshErrors = 0});
  factory _Feed.fromJson(Map<String, dynamic> json) => _$FeedFromJson(json);

@override final  String? id;
@override final  String? name;
@override final  String? description;
@override final  String? url;
@override final  String? itemPreference;
@override final  String? image;
  @override final FeedCategory? category;
@override@JsonKey() final  int lastRefreshErrors;

/// Create a copy of Feed
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedCopyWith<_Feed> get copyWith => __$FeedCopyWithImpl<_Feed>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType && other is _Feed && (identical(other.id, id) || other.id == id) && (identical(other.name, name) || other.name == name) &&
      (identical(other.description, description) || other.description == description) && (identical(other.url, url) || other.url == url) &&
      (identical(other.itemPreference, itemPreference) || other.itemPreference == itemPreference) && (identical(other.image, image) || other.image == image) &&
      (identical(other.category, category) || other.category == category) && (identical(other.lastRefreshErrors, lastRefreshErrors) || other.lastRefreshErrors == lastRefreshErrors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode =>
    Object.hash(
        runtimeType,
        id,
        name,
        description,
        url,
        itemPreference,
        image,
        category,
        lastRefreshErrors);

@override
String toString() {
  return 'Feed(id: $id, name: $name, description: $description, url: $url, itemPreference: $itemPreference, image: $image, category: $category, lastRefreshErrors: $lastRefreshErrors)';
}


}

/// @nodoc
abstract mixin class _$FeedCopyWith<$Res> implements $FeedCopyWith<$Res> {
  factory _$FeedCopyWith(_Feed value, $Res Function(_Feed) _then) = __$FeedCopyWithImpl;
@override @useResult
$Res call({
  String? id, String? name, String? description, String? url, String? itemPreference, String? image, FeedCategory? category, int lastRefreshErrors
});


  @override $FeedCategoryCopyWith<$Res>? get category;

}
/// @nodoc
class __$FeedCopyWithImpl<$Res>
    implements _$FeedCopyWith<$Res> {
  __$FeedCopyWithImpl(this._self, this._then);

  final _Feed _self;
  final $Res Function(_Feed) _then;

/// Create a copy of Feed
/// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call(
      {Object? id = freezed, Object? name = freezed, Object? description = freezed, Object? url = freezed, Object? itemPreference = freezed, Object? image = freezed, Object? category = freezed, Object? lastRefreshErrors = null,}) {
  return _then(_Feed(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,itemPreference: freezed == itemPreference ? _self.itemPreference : itemPreference // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
  as String?,
    category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
    as FeedCategory?,
    lastRefreshErrors: null == lastRefreshErrors ? _self.lastRefreshErrors : lastRefreshErrors // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

  /// Create a copy of Feed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FeedCategoryCopyWith<$Res>? get category {
    if (_self.category == null) {
      return null;
    }

    return $FeedCategoryCopyWith<$Res>(_self.category!, (value) {
      return _then(_self.copyWith(category: value));
    });
  }
}

// dart format on
