// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MainSettingsState {

 bool get loading; int get feeds; int get categories; dynamic get error; StackTrace? get stackTrace;
/// Create a copy of MainSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MainSettingsStateCopyWith<MainSettingsState> get copyWith => _$MainSettingsStateCopyWithImpl<MainSettingsState>(this as MainSettingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MainSettingsState&&(identical(other.loading, loading) || other.loading == loading)&&(identical(other.feeds, feeds) || other.feeds == feeds)&&(identical(other.categories, categories) || other.categories == categories)&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,loading,feeds,categories,const DeepCollectionEquality().hash(error),stackTrace);

@override
String toString() {
  return 'MainSettingsState(loading: $loading, feeds: $feeds, categories: $categories, error: $error, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $MainSettingsStateCopyWith<$Res>  {
  factory $MainSettingsStateCopyWith(MainSettingsState value, $Res Function(MainSettingsState) _then) = _$MainSettingsStateCopyWithImpl;
@useResult
$Res call({
 bool loading, int feeds, int categories, dynamic error, StackTrace? stackTrace
});




}
/// @nodoc
class _$MainSettingsStateCopyWithImpl<$Res>
    implements $MainSettingsStateCopyWith<$Res> {
  _$MainSettingsStateCopyWithImpl(this._self, this._then);

  final MainSettingsState _self;
  final $Res Function(MainSettingsState) _then;

/// Create a copy of MainSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loading = null,Object? feeds = null,Object? categories = null,Object? error = freezed,Object? stackTrace = freezed,}) {
  return _then(_self.copyWith(
loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,feeds: null == feeds ? _self.feeds : feeds // ignore: cast_nullable_to_non_nullable
as int,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as int,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as dynamic,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}

}


/// Adds pattern-matching-related methods to [MainSettingsState].
extension MainSettingsStatePatterns on MainSettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MainSettingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MainSettingsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MainSettingsState value)  $default,){
final _that = this;
switch (_that) {
case _MainSettingsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MainSettingsState value)?  $default,){
final _that = this;
switch (_that) {
case _MainSettingsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool loading,  int feeds,  int categories,  dynamic error,  StackTrace? stackTrace)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MainSettingsState() when $default != null:
return $default(_that.loading,_that.feeds,_that.categories,_that.error,_that.stackTrace);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool loading,  int feeds,  int categories,  dynamic error,  StackTrace? stackTrace)  $default,) {final _that = this;
switch (_that) {
case _MainSettingsState():
return $default(_that.loading,_that.feeds,_that.categories,_that.error,_that.stackTrace);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool loading,  int feeds,  int categories,  dynamic error,  StackTrace? stackTrace)?  $default,) {final _that = this;
switch (_that) {
case _MainSettingsState() when $default != null:
return $default(_that.loading,_that.feeds,_that.categories,_that.error,_that.stackTrace);case _:
  return null;

}
}

}

/// @nodoc


class _MainSettingsState implements MainSettingsState, WithError {
  const _MainSettingsState({this.loading = true, this.feeds = 0, this.categories = 0, this.error, this.stackTrace});
  

@override@JsonKey() final  bool loading;
@override@JsonKey() final  int feeds;
@override@JsonKey() final  int categories;
@override final  dynamic error;
@override final  StackTrace? stackTrace;

/// Create a copy of MainSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MainSettingsStateCopyWith<_MainSettingsState> get copyWith => __$MainSettingsStateCopyWithImpl<_MainSettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MainSettingsState&&(identical(other.loading, loading) || other.loading == loading)&&(identical(other.feeds, feeds) || other.feeds == feeds)&&(identical(other.categories, categories) || other.categories == categories)&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,loading,feeds,categories,const DeepCollectionEquality().hash(error),stackTrace);

@override
String toString() {
  return 'MainSettingsState(loading: $loading, feeds: $feeds, categories: $categories, error: $error, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class _$MainSettingsStateCopyWith<$Res> implements $MainSettingsStateCopyWith<$Res> {
  factory _$MainSettingsStateCopyWith(_MainSettingsState value, $Res Function(_MainSettingsState) _then) = __$MainSettingsStateCopyWithImpl;
@override @useResult
$Res call({
 bool loading, int feeds, int categories, dynamic error, StackTrace? stackTrace
});




}
/// @nodoc
class __$MainSettingsStateCopyWithImpl<$Res>
    implements _$MainSettingsStateCopyWith<$Res> {
  __$MainSettingsStateCopyWithImpl(this._self, this._then);

  final _MainSettingsState _self;
  final $Res Function(_MainSettingsState) _then;

/// Create a copy of MainSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loading = null,Object? feeds = null,Object? categories = null,Object? error = freezed,Object? stackTrace = freezed,}) {
  return _then(_MainSettingsState(
loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,feeds: null == feeds ? _self.feeds : feeds // ignore: cast_nullable_to_non_nullable
as int,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as int,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as dynamic,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

// dart format on
