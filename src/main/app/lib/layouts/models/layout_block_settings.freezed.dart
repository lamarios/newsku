// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'layout_block_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LayoutBlockSettings {

  String? get title;

  int? get items;

  String? get categoryId;
/// Create a copy of LayoutBlockSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LayoutBlockSettingsCopyWith<LayoutBlockSettings> get copyWith => _$LayoutBlockSettingsCopyWithImpl<LayoutBlockSettings>(this as LayoutBlockSettings, _$identity);

  /// Serializes this LayoutBlockSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) ||
      (other.runtimeType == runtimeType && other is LayoutBlockSettings && (identical(other.title, title) || other.title == title) && (identical(other.items, items) || other.items == items) &&
          (identical(other.categoryId, categoryId) || other.categoryId == categoryId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType, title, items, categoryId);

@override
String toString() {
  return 'LayoutBlockSettings(title: $title, items: $items, categoryId: $categoryId)';
}


}

/// @nodoc
abstract mixin class $LayoutBlockSettingsCopyWith<$Res>  {
  factory $LayoutBlockSettingsCopyWith(LayoutBlockSettings value, $Res Function(LayoutBlockSettings) _then) = _$LayoutBlockSettingsCopyWithImpl;
@useResult
$Res call({
  String? title, int? items, String? categoryId
});




}
/// @nodoc
class _$LayoutBlockSettingsCopyWithImpl<$Res>
    implements $LayoutBlockSettingsCopyWith<$Res> {
  _$LayoutBlockSettingsCopyWithImpl(this._self, this._then);

  final LayoutBlockSettings _self;
  final $Res Function(LayoutBlockSettings) _then;

/// Create a copy of LayoutBlockSettings
/// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? title = freezed, Object? items = freezed, Object? categoryId = freezed,}) {
  return _then(_self.copyWith(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,items: freezed == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
  as int?, categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
  as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LayoutBlockSettings].
extension LayoutBlockSettingsPatterns on LayoutBlockSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LayoutBlockSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LayoutBlockSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LayoutBlockSettings value)  $default,){
final _that = this;
switch (_that) {
case _LayoutBlockSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LayoutBlockSettings value)?  $default,){
final _that = this;
switch (_that) {
case _LayoutBlockSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? title, int? items, String? categoryId)? $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LayoutBlockSettings() when $default != null:
return $default(_that.title,_that.items,_that.categoryId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? title, int? items, String? categoryId) $default,) {final _that = this;
switch (_that) {
case _LayoutBlockSettings():
return $default(_that.title,_that.items,_that.categoryId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? title, int? items, String? categoryId)? $default,) {final _that = this;
switch (_that) {
case _LayoutBlockSettings() when $default != null:
return $default(_that.title,_that.items,_that.categoryId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LayoutBlockSettings implements LayoutBlockSettings {
  const _LayoutBlockSettings({this.title, this.items, this.categoryId});
  factory _LayoutBlockSettings.fromJson(Map<String, dynamic> json) => _$LayoutBlockSettingsFromJson(json);

@override final  String? title;
@override final  int? items;
  @override final String? categoryId;

/// Create a copy of LayoutBlockSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LayoutBlockSettingsCopyWith<_LayoutBlockSettings> get copyWith => __$LayoutBlockSettingsCopyWithImpl<_LayoutBlockSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LayoutBlockSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) ||
      (other.runtimeType == runtimeType && other is _LayoutBlockSettings && (identical(other.title, title) || other.title == title) && (identical(other.items, items) || other.items == items) &&
          (identical(other.categoryId, categoryId) || other.categoryId == categoryId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType, title, items, categoryId);

@override
String toString() {
  return 'LayoutBlockSettings(title: $title, items: $items, categoryId: $categoryId)';
}


}

/// @nodoc
abstract mixin class _$LayoutBlockSettingsCopyWith<$Res> implements $LayoutBlockSettingsCopyWith<$Res> {
  factory _$LayoutBlockSettingsCopyWith(_LayoutBlockSettings value, $Res Function(_LayoutBlockSettings) _then) = __$LayoutBlockSettingsCopyWithImpl;
@override @useResult
$Res call({
  String? title, int? items, String? categoryId
});




}
/// @nodoc
class __$LayoutBlockSettingsCopyWithImpl<$Res>
    implements _$LayoutBlockSettingsCopyWith<$Res> {
  __$LayoutBlockSettingsCopyWithImpl(this._self, this._then);

  final _LayoutBlockSettings _self;
  final $Res Function(_LayoutBlockSettings) _then;

/// Create a copy of LayoutBlockSettings
/// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? title = freezed, Object? items = freezed, Object? categoryId = freezed,}) {
  return _then(_LayoutBlockSettings(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,items: freezed == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
  as int?, categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
  as String?,
  ));
}


}

// dart format on
