// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'local_preferences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocalPreferencesState implements DiagnosticableTreeMixin {

 Color get themeColor; bool get dynamicColor; bool get blackBackground; bool get reduceMotion; double get density; ThemeMode get theme; bool get notifications; int get notificationsFrequency; ColorScheme? get systemColors;
/// Create a copy of LocalPreferencesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocalPreferencesStateCopyWith<LocalPreferencesState> get copyWith => _$LocalPreferencesStateCopyWithImpl<LocalPreferencesState>(this as LocalPreferencesState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  final _this = this as LocalPreferencesState;
  properties
    ..add(DiagnosticsProperty('type', 'LocalPreferencesState'))
    ..add(DiagnosticsProperty('themeColor', _this.themeColor))..add(DiagnosticsProperty('dynamicColor', _this.dynamicColor))..add(DiagnosticsProperty('blackBackground', _this.blackBackground))..add(DiagnosticsProperty('reduceMotion', _this.reduceMotion))..add(DiagnosticsProperty('density', _this.density))..add(DiagnosticsProperty('theme', _this.theme))..add(DiagnosticsProperty('notifications', _this.notifications))..add(DiagnosticsProperty('notificationsFrequency', _this.notificationsFrequency))..add(DiagnosticsProperty('systemColors', _this.systemColors));
}

@override
bool operator ==(Object other) {
  final _this = this as LocalPreferencesState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalPreferencesState&&(identical(other.themeColor, _this.themeColor) || other.themeColor == _this.themeColor)&&(identical(other.dynamicColor, _this.dynamicColor) || other.dynamicColor == _this.dynamicColor)&&(identical(other.blackBackground, _this.blackBackground) || other.blackBackground == _this.blackBackground)&&(identical(other.reduceMotion, _this.reduceMotion) || other.reduceMotion == _this.reduceMotion)&&(identical(other.density, _this.density) || other.density == _this.density)&&(identical(other.theme, _this.theme) || other.theme == _this.theme)&&(identical(other.notifications, _this.notifications) || other.notifications == _this.notifications)&&(identical(other.notificationsFrequency, _this.notificationsFrequency) || other.notificationsFrequency == _this.notificationsFrequency)&&(identical(other.systemColors, _this.systemColors) || other.systemColors == _this.systemColors));
}


@override
int get hashCode {
  final _this = this as LocalPreferencesState;
  return Object.hash(runtimeType,_this.themeColor,_this.dynamicColor,_this.blackBackground,_this.reduceMotion,_this.density,_this.theme,_this.notifications,_this.notificationsFrequency,_this.systemColors);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  final _this = this as LocalPreferencesState;
  return 'LocalPreferencesState(themeColor: ${_this.themeColor}, dynamicColor: ${_this.dynamicColor}, blackBackground: ${_this.blackBackground}, reduceMotion: ${_this.reduceMotion}, density: ${_this.density}, theme: ${_this.theme}, notifications: ${_this.notifications}, notificationsFrequency: ${_this.notificationsFrequency}, systemColors: ${_this.systemColors})';
}


}

/// @nodoc
abstract mixin class $LocalPreferencesStateCopyWith<$Res>  {
  factory $LocalPreferencesStateCopyWith(LocalPreferencesState value, $Res Function(LocalPreferencesState) _then) = _$LocalPreferencesStateCopyWithImpl;
@useResult
$Res call({
 Color themeColor, bool dynamicColor, bool blackBackground, bool reduceMotion, double density, ThemeMode theme, bool notifications, int notificationsFrequency, ColorScheme? systemColors
});




}
/// @nodoc
class _$LocalPreferencesStateCopyWithImpl<$Res>
    implements $LocalPreferencesStateCopyWith<$Res> {
  _$LocalPreferencesStateCopyWithImpl(this._self, this._then);

  final LocalPreferencesState _self;
  final $Res Function(LocalPreferencesState) _then;

/// Create a copy of LocalPreferencesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? themeColor = null,Object? dynamicColor = null,Object? blackBackground = null,Object? reduceMotion = null,Object? density = null,Object? theme = null,Object? notifications = null,Object? notificationsFrequency = null,Object? systemColors = freezed,}) {
  return _then(LocalPreferencesState(
themeColor: null == themeColor ? _self.themeColor : themeColor // ignore: cast_nullable_to_non_nullable
as Color,dynamicColor: null == dynamicColor ? _self.dynamicColor : dynamicColor // ignore: cast_nullable_to_non_nullable
as bool,blackBackground: null == blackBackground ? _self.blackBackground : blackBackground // ignore: cast_nullable_to_non_nullable
as bool,reduceMotion: null == reduceMotion ? _self.reduceMotion : reduceMotion // ignore: cast_nullable_to_non_nullable
as bool,density: null == density ? _self.density : density // ignore: cast_nullable_to_non_nullable
as double,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as ThemeMode,notifications: null == notifications ? _self.notifications : notifications // ignore: cast_nullable_to_non_nullable
as bool,notificationsFrequency: null == notificationsFrequency ? _self.notificationsFrequency : notificationsFrequency // ignore: cast_nullable_to_non_nullable
as int,systemColors: freezed == systemColors ? _self.systemColors : systemColors // ignore: cast_nullable_to_non_nullable
as ColorScheme?,
  ));
}

}


/// Adds pattern-matching-related methods to [LocalPreferencesState].
extension LocalPreferencesStatePatterns on LocalPreferencesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocalPreferencesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocalPreferencesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocalPreferencesState value)  $default,){
final _that = this;
switch (_that) {
case _LocalPreferencesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocalPreferencesState value)?  $default,){
final _that = this;
switch (_that) {
case _LocalPreferencesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Color themeColor,  bool dynamicColor,  bool blackBackground,  bool reduceMotion,  double density,  ThemeMode theme,  bool notifications,  int notificationsFrequency,  ColorScheme? systemColors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocalPreferencesState() when $default != null:
return $default(_that.themeColor,_that.dynamicColor,_that.blackBackground,_that.reduceMotion,_that.density,_that.theme,_that.notifications,_that.notificationsFrequency,_that.systemColors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Color themeColor,  bool dynamicColor,  bool blackBackground,  bool reduceMotion,  double density,  ThemeMode theme,  bool notifications,  int notificationsFrequency,  ColorScheme? systemColors)  $default,) {final _that = this;
switch (_that) {
case _LocalPreferencesState():
return $default(_that.themeColor,_that.dynamicColor,_that.blackBackground,_that.reduceMotion,_that.density,_that.theme,_that.notifications,_that.notificationsFrequency,_that.systemColors);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Color themeColor,  bool dynamicColor,  bool blackBackground,  bool reduceMotion,  double density,  ThemeMode theme,  bool notifications,  int notificationsFrequency,  ColorScheme? systemColors)?  $default,) {final _that = this;
switch (_that) {
case _LocalPreferencesState() when $default != null:
return $default(_that.themeColor,_that.dynamicColor,_that.blackBackground,_that.reduceMotion,_that.density,_that.theme,_that.notifications,_that.notificationsFrequency,_that.systemColors);case _:
  return null;

}
}

}

/// @nodoc


class _LocalPreferencesState extends LocalPreferencesState with DiagnosticableTreeMixin {
  const _LocalPreferencesState({this.themeColor = _defaultColor, this.dynamicColor = false, this.blackBackground = false, this.reduceMotion = false, this.density = 4, this.theme = ThemeMode.system, this.notifications = false, this.notificationsFrequency = 1, this.systemColors}): super._();
  

@override@JsonKey() final  Color themeColor;
@override@JsonKey() final  bool dynamicColor;
@override@JsonKey() final  bool blackBackground;
@override@JsonKey() final  bool reduceMotion;
@override@JsonKey() final  double density;
@override@JsonKey() final  ThemeMode theme;
@override@JsonKey() final  bool notifications;
@override@JsonKey() final  int notificationsFrequency;
@override final  ColorScheme? systemColors;

/// Create a copy of LocalPreferencesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocalPreferencesStateCopyWith<_LocalPreferencesState> get copyWith => __$LocalPreferencesStateCopyWithImpl<_LocalPreferencesState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
    ..add(DiagnosticsProperty('type', 'LocalPreferencesState'))
    ..add(DiagnosticsProperty('themeColor', themeColor))..add(DiagnosticsProperty('dynamicColor', dynamicColor))..add(DiagnosticsProperty('blackBackground', blackBackground))..add(DiagnosticsProperty('reduceMotion', reduceMotion))..add(DiagnosticsProperty('density', density))..add(DiagnosticsProperty('theme', theme))..add(DiagnosticsProperty('notifications', notifications))..add(DiagnosticsProperty('notificationsFrequency', notificationsFrequency))..add(DiagnosticsProperty('systemColors', systemColors));
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocalPreferencesState&&(identical(other.themeColor, themeColor) || other.themeColor == themeColor)&&(identical(other.dynamicColor, dynamicColor) || other.dynamicColor == dynamicColor)&&(identical(other.blackBackground, blackBackground) || other.blackBackground == blackBackground)&&(identical(other.reduceMotion, reduceMotion) || other.reduceMotion == reduceMotion)&&(identical(other.density, density) || other.density == density)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.notifications, notifications) || other.notifications == notifications)&&(identical(other.notificationsFrequency, notificationsFrequency) || other.notificationsFrequency == notificationsFrequency)&&(identical(other.systemColors, systemColors) || other.systemColors == systemColors));
}


@override
int get hashCode {
    return Object.hash(runtimeType,themeColor,dynamicColor,blackBackground,reduceMotion,density,theme,notifications,notificationsFrequency,systemColors);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    return 'LocalPreferencesState(themeColor: $themeColor, dynamicColor: $dynamicColor, blackBackground: $blackBackground, reduceMotion: $reduceMotion, density: $density, theme: $theme, notifications: $notifications, notificationsFrequency: $notificationsFrequency, systemColors: $systemColors)';
}


}

/// @nodoc
abstract mixin class _$LocalPreferencesStateCopyWith<$Res> implements $LocalPreferencesStateCopyWith<$Res> {
  factory _$LocalPreferencesStateCopyWith(_LocalPreferencesState value, $Res Function(_LocalPreferencesState) _then) = __$LocalPreferencesStateCopyWithImpl;
@override @useResult
$Res call({
 Color themeColor, bool dynamicColor, bool blackBackground, bool reduceMotion, double density, ThemeMode theme, bool notifications, int notificationsFrequency, ColorScheme? systemColors
});




}
/// @nodoc
class __$LocalPreferencesStateCopyWithImpl<$Res>
    implements _$LocalPreferencesStateCopyWith<$Res> {
  __$LocalPreferencesStateCopyWithImpl(this._self, this._then);

  final _LocalPreferencesState _self;
  final $Res Function(_LocalPreferencesState) _then;

/// Create a copy of LocalPreferencesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? themeColor = null,Object? dynamicColor = null,Object? blackBackground = null,Object? reduceMotion = null,Object? density = null,Object? theme = null,Object? notifications = null,Object? notificationsFrequency = null,Object? systemColors = freezed,}) {
  return _then(_LocalPreferencesState(
themeColor: null == themeColor ? _self.themeColor : themeColor // ignore: cast_nullable_to_non_nullable
as Color,dynamicColor: null == dynamicColor ? _self.dynamicColor : dynamicColor // ignore: cast_nullable_to_non_nullable
as bool,blackBackground: null == blackBackground ? _self.blackBackground : blackBackground // ignore: cast_nullable_to_non_nullable
as bool,reduceMotion: null == reduceMotion ? _self.reduceMotion : reduceMotion // ignore: cast_nullable_to_non_nullable
as bool,density: null == density ? _self.density : density // ignore: cast_nullable_to_non_nullable
as double,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as ThemeMode,notifications: null == notifications ? _self.notifications : notifications // ignore: cast_nullable_to_non_nullable
as bool,notificationsFrequency: null == notificationsFrequency ? _self.notificationsFrequency : notificationsFrequency // ignore: cast_nullable_to_non_nullable
as int,systemColors: freezed == systemColors ? _self.systemColors : systemColors // ignore: cast_nullable_to_non_nullable
as ColorScheme?,
  ));
}


}

// dart format on
