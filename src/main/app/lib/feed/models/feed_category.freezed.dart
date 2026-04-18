// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeedCategory {

  String? get id;

  String get name;

  /// Create a copy of FeedCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FeedCategoryCopyWith<FeedCategory> get copyWith => _$FeedCategoryCopyWithImpl<FeedCategory>(this as FeedCategory, _$identity);

  /// Serializes this FeedCategory to a JSON map.
  Map<String, dynamic> toJson();


  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is FeedCategory && (identical(other.id, id) || other.id == id) && (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @override
  String toString() {
    return 'FeedCategory(id: $id, name: $name)';
  }


}

/// @nodoc
abstract mixin class $FeedCategoryCopyWith<$Res> {
  factory $FeedCategoryCopyWith(FeedCategory value, $Res Function(FeedCategory) _then) = _$FeedCategoryCopyWithImpl;

  @useResult
  $Res call({
    String? id, String name
  });


}

/// @nodoc
class _$FeedCategoryCopyWithImpl<$Res>
    implements $FeedCategoryCopyWith<$Res> {
  _$FeedCategoryCopyWithImpl(this._self, this._then);

  final FeedCategory _self;
  final $Res Function(FeedCategory) _then;

  /// Create a copy of FeedCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = freezed, Object? name = null,}) {
    return _then(_self.copyWith(
      id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
      as String?, name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
    as String,
    ));
  }

}


/// Adds pattern-matching-related methods to [FeedCategory].
extension FeedCategoryPatterns on FeedCategory {
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

  @optionalTypeArgs TResult maybeMap

  <

  TResult

  extends

  Object?

  >

  (

  TResult Function( _FeedCategory value)? $default,{required TResult orElse(),}){
  final _that = this;
  switch (_that) {
  case _FeedCategory() when $default != null:
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

  @optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedCategory value) $default,){
  final _that = this;
  switch (_that) {
  case _FeedCategory():
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

  @optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedCategory value)? $default,){
  final _that = this;
  switch (_that) {
  case _FeedCategory() when $default != null:
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

  @optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id, String name)? $default,{required TResult orElse(),}) {final _that = this;
  switch (_that) {
  case _FeedCategory() when $default != null:
  return $default(_that.id,_that.name);case _:
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

  @optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id, String name) $default,) {final _that = this;
  switch (_that) {
  case _FeedCategory():
  return $default(_that.id,_that.name);}
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

  @optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id, String name)? $default,) {final _that = this;
  switch (_that) {
  case _FeedCategory() when $default != null:
  return $default(_that.id,_that.name);case _:
  return null;

  }
  }

}

/// @nodoc
@JsonSerializable()
class _FeedCategory implements FeedCategory {
  const _FeedCategory({this.id, required this.name});

  factory _FeedCategory.fromJson(Map<String, dynamic> json) => _$FeedCategoryFromJson(json);

  @override final String? id;
  @override final String name;

  /// Create a copy of FeedCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FeedCategoryCopyWith<_FeedCategory> get copyWith => __$FeedCategoryCopyWithImpl<_FeedCategory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FeedCategoryToJson(this,);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is _FeedCategory && (identical(other.id, id) || other.id == id) && (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @override
  String toString() {
    return 'FeedCategory(id: $id, name: $name)';
  }


}

/// @nodoc
abstract mixin class _$FeedCategoryCopyWith<$Res> implements $FeedCategoryCopyWith<$Res> {
  factory _$FeedCategoryCopyWith(_FeedCategory value, $Res Function(_FeedCategory) _then) = __$FeedCategoryCopyWithImpl;

  @override
  @useResult
  $Res call({
    String? id, String name
  });


}

/// @nodoc
class __$FeedCategoryCopyWithImpl<$Res>
    implements _$FeedCategoryCopyWith<$Res> {
  __$FeedCategoryCopyWithImpl(this._self, this._then);

  final _FeedCategory _self;
  final $Res Function(_FeedCategory) _then;

  /// Create a copy of FeedCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? id = freezed, Object? name = null,}) {
    return _then(_FeedCategory(
      id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
      as String?, name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
    as String,
    ));
  }


}

// dart format on
