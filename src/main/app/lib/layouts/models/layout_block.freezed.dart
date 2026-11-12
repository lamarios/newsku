// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'layout_block.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LayoutBlock {

 String? get id; LayoutBlockTypes get type; int get order; LayoutBlockSettings? get settings;
/// Create a copy of LayoutBlock
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LayoutBlockCopyWith<LayoutBlock> get copyWith => _$LayoutBlockCopyWithImpl<LayoutBlock>(this as LayoutBlock, _$identity);

  /// Serializes this LayoutBlock to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as LayoutBlock;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LayoutBlock&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.order, _this.order) || other.order == _this.order)&&(identical(other.settings, _this.settings) || other.settings == _this.settings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LayoutBlock;
  return Object.hash(runtimeType,_this.id,_this.type,_this.order,_this.settings);
}

@override
String toString() {
  final _this = this as LayoutBlock;
  return 'LayoutBlock(id: ${_this.id}, type: ${_this.type}, order: ${_this.order}, settings: ${_this.settings})';
}


}

/// @nodoc
abstract mixin class $LayoutBlockCopyWith<$Res>  {
  factory $LayoutBlockCopyWith(LayoutBlock value, $Res Function(LayoutBlock) _then) = _$LayoutBlockCopyWithImpl;
@useResult
$Res call({
 String? id, LayoutBlockTypes type, int order, LayoutBlockSettings? settings
});


$LayoutBlockSettingsCopyWith<$Res>? get settings;

}
/// @nodoc
class _$LayoutBlockCopyWithImpl<$Res>
    implements $LayoutBlockCopyWith<$Res> {
  _$LayoutBlockCopyWithImpl(this._self, this._then);

  final LayoutBlock _self;
  final $Res Function(LayoutBlock) _then;

/// Create a copy of LayoutBlock
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? type = null,Object? order = null,Object? settings = freezed,}) {
  return _then(LayoutBlock(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as LayoutBlockTypes,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as LayoutBlockSettings?,
  ));
}
/// Create a copy of LayoutBlock
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LayoutBlockSettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $LayoutBlockSettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}
}


/// Adds pattern-matching-related methods to [LayoutBlock].
extension LayoutBlockPatterns on LayoutBlock {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LayoutBlock value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LayoutBlock() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LayoutBlock value)  $default,){
final _that = this;
switch (_that) {
case _LayoutBlock():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LayoutBlock value)?  $default,){
final _that = this;
switch (_that) {
case _LayoutBlock() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  LayoutBlockTypes type,  int order,  LayoutBlockSettings? settings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LayoutBlock() when $default != null:
return $default(_that.id,_that.type,_that.order,_that.settings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  LayoutBlockTypes type,  int order,  LayoutBlockSettings? settings)  $default,) {final _that = this;
switch (_that) {
case _LayoutBlock():
return $default(_that.id,_that.type,_that.order,_that.settings);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  LayoutBlockTypes type,  int order,  LayoutBlockSettings? settings)?  $default,) {final _that = this;
switch (_that) {
case _LayoutBlock() when $default != null:
return $default(_that.id,_that.type,_that.order,_that.settings);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LayoutBlock implements LayoutBlock {
  const _LayoutBlock({this.id, required this.type, required this.order, this.settings});
  factory _LayoutBlock.fromJson(Map<String, dynamic> json) => _$LayoutBlockFromJson(json);

@override final  String? id;
@override final  LayoutBlockTypes type;
@override final  int order;
@override final  LayoutBlockSettings? settings;

/// Create a copy of LayoutBlock
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LayoutBlockCopyWith<_LayoutBlock> get copyWith => __$LayoutBlockCopyWithImpl<_LayoutBlock>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LayoutBlockToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LayoutBlock&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.order, order) || other.order == order)&&(identical(other.settings, settings) || other.settings == settings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,type,order,settings);
}

@override
String toString() {
    return 'LayoutBlock(id: $id, type: $type, order: $order, settings: $settings)';
}


}

/// @nodoc
abstract mixin class _$LayoutBlockCopyWith<$Res> implements $LayoutBlockCopyWith<$Res> {
  factory _$LayoutBlockCopyWith(_LayoutBlock value, $Res Function(_LayoutBlock) _then) = __$LayoutBlockCopyWithImpl;
@override @useResult
$Res call({
 String? id, LayoutBlockTypes type, int order, LayoutBlockSettings? settings
});


@override $LayoutBlockSettingsCopyWith<$Res>? get settings;

}
/// @nodoc
class __$LayoutBlockCopyWithImpl<$Res>
    implements _$LayoutBlockCopyWith<$Res> {
  __$LayoutBlockCopyWithImpl(this._self, this._then);

  final _LayoutBlock _self;
  final $Res Function(_LayoutBlock) _then;

/// Create a copy of LayoutBlock
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? type = null,Object? order = null,Object? settings = freezed,}) {
  return _then(_LayoutBlock(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as LayoutBlockTypes,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,settings: freezed == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as LayoutBlockSettings?,
  ));
}

/// Create a copy of LayoutBlock
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LayoutBlockSettingsCopyWith<$Res>? get settings {
    if (_self.settings == null) {
    return null;
  }

  return $LayoutBlockSettingsCopyWith<$Res>(_self.settings!, (value) {
    return _then(_self.copyWith(settings: value));
  });
}
}

// dart format on
