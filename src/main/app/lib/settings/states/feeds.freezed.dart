// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feeds.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FeedsSettingsState {

  List<Feed> get feeds;

  List<FeedCategory> get categories;

  bool get loading;

  dynamic get error;

  StackTrace? get stackTrace;
/// Create a copy of FeedsSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedsSettingsStateCopyWith<FeedsSettingsState> get copyWith => _$FeedsSettingsStateCopyWithImpl<FeedsSettingsState>(this as FeedsSettingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType && other is FeedsSettingsState && const DeepCollectionEquality().equals(other.feeds, feeds) &&
      const DeepCollectionEquality().equals(other.categories, categories) && (identical(other.loading, loading) || other.loading == loading) &&
      const DeepCollectionEquality().equals(other.error, error) && (identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode =>
    Object.hash(runtimeType, const DeepCollectionEquality().hash(feeds), const DeepCollectionEquality().hash(categories), loading, const DeepCollectionEquality().hash(error), stackTrace);

@override
String toString() {
  return 'FeedsSettingsState(feeds: $feeds, categories: $categories, loading: $loading, error: $error, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $FeedsSettingsStateCopyWith<$Res>  {
  factory $FeedsSettingsStateCopyWith(FeedsSettingsState value, $Res Function(FeedsSettingsState) _then) = _$FeedsSettingsStateCopyWithImpl;
@useResult
$Res call({
  List<Feed> feeds, List<FeedCategory> categories, bool loading, dynamic error, StackTrace? stackTrace
});




}
/// @nodoc
class _$FeedsSettingsStateCopyWithImpl<$Res>
    implements $FeedsSettingsStateCopyWith<$Res> {
  _$FeedsSettingsStateCopyWithImpl(this._self, this._then);

  final FeedsSettingsState _self;
  final $Res Function(FeedsSettingsState) _then;

/// Create a copy of FeedsSettingsState
/// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? feeds = null, Object? categories = null, Object? loading = null, Object? error = freezed, Object? stackTrace = freezed,}) {
  return _then(_self.copyWith(
feeds: null == feeds ? _self.feeds : feeds // ignore: cast_nullable_to_non_nullable
as List<Feed>,
    categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
    as List<FeedCategory>,
    loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as dynamic,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedsSettingsState].
extension FeedsSettingsStatePatterns on FeedsSettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedsSettingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedsSettingsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedsSettingsState value)  $default,){
final _that = this;
switch (_that) {
case _FeedsSettingsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedsSettingsState value)?  $default,){
final _that = this;
switch (_that) {
case _FeedsSettingsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Feed> feeds, List<FeedCategory> categories, bool loading, dynamic error, StackTrace? stackTrace)? $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedsSettingsState() when $default != null:
return $default(_that.feeds,_that.categories,_that.loading,_that.error,_that.stackTrace);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Feed> feeds, List<FeedCategory> categories, bool loading, dynamic error, StackTrace? stackTrace) $default,) {final _that = this;
switch (_that) {
case _FeedsSettingsState():
return $default(_that.feeds,_that.categories,_that.loading,_that.error,_that.stackTrace);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Feed> feeds, List<FeedCategory> categories, bool loading, dynamic error, StackTrace? stackTrace)? $default,) {final _that = this;
switch (_that) {
case _FeedsSettingsState() when $default != null:
return $default(_that.feeds,_that.categories,_that.loading,_that.error,_that.stackTrace);case _:
  return null;

}
}

}

/// @nodoc


class _FeedsSettingsState implements FeedsSettingsState, WithError {
  const _FeedsSettingsState({final List<Feed> feeds = const [], final List<FeedCategory> categories = const [], this.loading = true, this.error, this.stackTrace})
      : _feeds = feeds,
        _categories = categories;


 final  List<Feed> _feeds;
@override@JsonKey() List<Feed> get feeds {
  if (_feeds is EqualUnmodifiableListView) return _feeds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_feeds);
}

  final List<FeedCategory> _categories;

  @override
  @JsonKey()
  List<FeedCategory> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

@override@JsonKey() final  bool loading;
@override final  dynamic error;
@override final  StackTrace? stackTrace;

/// Create a copy of FeedsSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedsSettingsStateCopyWith<_FeedsSettingsState> get copyWith => __$FeedsSettingsStateCopyWithImpl<_FeedsSettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType && other is _FeedsSettingsState && const DeepCollectionEquality().equals(other._feeds, _feeds) &&
      const DeepCollectionEquality().equals(other._categories, _categories) && (identical(other.loading, loading) || other.loading == loading) &&
      const DeepCollectionEquality().equals(other.error, error) && (identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode =>
    Object.hash(runtimeType, const DeepCollectionEquality().hash(_feeds), const DeepCollectionEquality().hash(_categories), loading, const DeepCollectionEquality().hash(error), stackTrace);

@override
String toString() {
  return 'FeedsSettingsState(feeds: $feeds, categories: $categories, loading: $loading, error: $error, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class _$FeedsSettingsStateCopyWith<$Res> implements $FeedsSettingsStateCopyWith<$Res> {
  factory _$FeedsSettingsStateCopyWith(_FeedsSettingsState value, $Res Function(_FeedsSettingsState) _then) = __$FeedsSettingsStateCopyWithImpl;
@override @useResult
$Res call({
  List<Feed> feeds, List<FeedCategory> categories, bool loading, dynamic error, StackTrace? stackTrace
});




}
/// @nodoc
class __$FeedsSettingsStateCopyWithImpl<$Res>
    implements _$FeedsSettingsStateCopyWith<$Res> {
  __$FeedsSettingsStateCopyWithImpl(this._self, this._then);

  final _FeedsSettingsState _self;
  final $Res Function(_FeedsSettingsState) _then;

/// Create a copy of FeedsSettingsState
/// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? feeds = null, Object? categories = null, Object? loading = null, Object? error = freezed, Object? stackTrace = freezed,}) {
  return _then(_FeedsSettingsState(
feeds: null == feeds ? _self._feeds : feeds // ignore: cast_nullable_to_non_nullable
as List<Feed>,
    categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
    as List<FeedCategory>,
    loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as dynamic,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

// dart format on
