// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_import.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
FeedToImport _$FeedToImportFromJson(
  Map<String, dynamic> json
) {
    return _FeedImport.fromJson(
      json
    );
}

/// @nodoc
mixin _$FeedToImport {

 String get url; FeedCategory? get feedCategory;
/// Create a copy of FeedToImport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedToImportCopyWith<FeedToImport> get copyWith => _$FeedToImportCopyWithImpl<FeedToImport>(this as FeedToImport, _$identity);

  /// Serializes this FeedToImport to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedToImport&&(identical(other.url, url) || other.url == url)&&(identical(other.feedCategory, feedCategory) || other.feedCategory == feedCategory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,feedCategory);

@override
String toString() {
  return 'FeedToImport(url: $url, feedCategory: $feedCategory)';
}


}

/// @nodoc
abstract mixin class $FeedToImportCopyWith<$Res>  {
  factory $FeedToImportCopyWith(FeedToImport value, $Res Function(FeedToImport) _then) = _$FeedToImportCopyWithImpl;
@useResult
$Res call({
 String url, FeedCategory? feedCategory
});


$FeedCategoryCopyWith<$Res>? get feedCategory;

}
/// @nodoc
class _$FeedToImportCopyWithImpl<$Res>
    implements $FeedToImportCopyWith<$Res> {
  _$FeedToImportCopyWithImpl(this._self, this._then);

  final FeedToImport _self;
  final $Res Function(FeedToImport) _then;

/// Create a copy of FeedToImport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? feedCategory = freezed,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,feedCategory: freezed == feedCategory ? _self.feedCategory : feedCategory // ignore: cast_nullable_to_non_nullable
as FeedCategory?,
  ));
}
/// Create a copy of FeedToImport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeedCategoryCopyWith<$Res>? get feedCategory {
    if (_self.feedCategory == null) {
    return null;
  }

  return $FeedCategoryCopyWith<$Res>(_self.feedCategory!, (value) {
    return _then(_self.copyWith(feedCategory: value));
  });
}
}


/// Adds pattern-matching-related methods to [FeedToImport].
extension FeedToImportPatterns on FeedToImport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedImport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedImport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedImport value)  $default,){
final _that = this;
switch (_that) {
case _FeedImport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedImport value)?  $default,){
final _that = this;
switch (_that) {
case _FeedImport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  FeedCategory? feedCategory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedImport() when $default != null:
return $default(_that.url,_that.feedCategory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  FeedCategory? feedCategory)  $default,) {final _that = this;
switch (_that) {
case _FeedImport():
return $default(_that.url,_that.feedCategory);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  FeedCategory? feedCategory)?  $default,) {final _that = this;
switch (_that) {
case _FeedImport() when $default != null:
return $default(_that.url,_that.feedCategory);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedImport implements FeedToImport {
  const _FeedImport({required this.url, this.feedCategory});
  factory _FeedImport.fromJson(Map<String, dynamic> json) => _$FeedImportFromJson(json);

@override final  String url;
@override final  FeedCategory? feedCategory;

/// Create a copy of FeedToImport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedImportCopyWith<_FeedImport> get copyWith => __$FeedImportCopyWithImpl<_FeedImport>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedImportToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedImport&&(identical(other.url, url) || other.url == url)&&(identical(other.feedCategory, feedCategory) || other.feedCategory == feedCategory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,feedCategory);

@override
String toString() {
  return 'FeedToImport(url: $url, feedCategory: $feedCategory)';
}


}

/// @nodoc
abstract mixin class _$FeedImportCopyWith<$Res> implements $FeedToImportCopyWith<$Res> {
  factory _$FeedImportCopyWith(_FeedImport value, $Res Function(_FeedImport) _then) = __$FeedImportCopyWithImpl;
@override @useResult
$Res call({
 String url, FeedCategory? feedCategory
});


@override $FeedCategoryCopyWith<$Res>? get feedCategory;

}
/// @nodoc
class __$FeedImportCopyWithImpl<$Res>
    implements _$FeedImportCopyWith<$Res> {
  __$FeedImportCopyWithImpl(this._self, this._then);

  final _FeedImport _self;
  final $Res Function(_FeedImport) _then;

/// Create a copy of FeedToImport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? feedCategory = freezed,}) {
  return _then(_FeedImport(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,feedCategory: freezed == feedCategory ? _self.feedCategory : feedCategory // ignore: cast_nullable_to_non_nullable
as FeedCategory?,
  ));
}

/// Create a copy of FeedToImport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FeedCategoryCopyWith<$Res>? get feedCategory {
    if (_self.feedCategory == null) {
    return null;
  }

  return $FeedCategoryCopyWith<$Res>(_self.feedCategory!, (value) {
    return _then(_self.copyWith(feedCategory: value));
  });
}
}

// dart format on
