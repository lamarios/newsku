// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'layout.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LayoutState {

  bool get dragging;

  List<LayoutBlock> get blocks;

  List<FeedCategory> get categories;

  bool get loading;

  dynamic get error;

  StackTrace? get stackTrace;
/// Create a copy of LayoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LayoutStateCopyWith<LayoutState> get copyWith => _$LayoutStateCopyWithImpl<LayoutState>(this as LayoutState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) ||
      (other.runtimeType == runtimeType && other is LayoutState && (identical(other.dragging, dragging) || other.dragging == dragging) && const DeepCollectionEquality().equals(other.blocks, blocks) &&
          const DeepCollectionEquality().equals(other.categories, categories) && (identical(other.loading, loading) || other.loading == loading) &&
          const DeepCollectionEquality().equals(other.error, error) && (identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode =>
    Object.hash(
        runtimeType,
        dragging,
        const DeepCollectionEquality().hash(blocks),
        const DeepCollectionEquality().hash(categories),
        loading,
        const DeepCollectionEquality().hash(error),
        stackTrace);

@override
String toString() {
  return 'LayoutState(dragging: $dragging, blocks: $blocks, categories: $categories, loading: $loading, error: $error, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $LayoutStateCopyWith<$Res>  {
  factory $LayoutStateCopyWith(LayoutState value, $Res Function(LayoutState) _then) = _$LayoutStateCopyWithImpl;
@useResult
$Res call({
  bool dragging, List<LayoutBlock> blocks, List<FeedCategory> categories, bool loading, dynamic error, StackTrace? stackTrace
});




}
/// @nodoc
class _$LayoutStateCopyWithImpl<$Res>
    implements $LayoutStateCopyWith<$Res> {
  _$LayoutStateCopyWithImpl(this._self, this._then);

  final LayoutState _self;
  final $Res Function(LayoutState) _then;

/// Create a copy of LayoutState
/// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? dragging = null, Object? blocks = null, Object? categories = null, Object? loading = null, Object? error = freezed, Object? stackTrace = freezed,}) {
  return _then(_self.copyWith(
dragging: null == dragging ? _self.dragging : dragging // ignore: cast_nullable_to_non_nullable
as bool,blocks: null == blocks ? _self.blocks : blocks // ignore: cast_nullable_to_non_nullable
  as List<LayoutBlock>,
    categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
    as List<FeedCategory>,
    loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as dynamic,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}

}


/// Adds pattern-matching-related methods to [LayoutState].
extension LayoutStatePatterns on LayoutState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LayoutState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LayoutState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LayoutState value)  $default,){
final _that = this;
switch (_that) {
case _LayoutState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LayoutState value)?  $default,){
final _that = this;
switch (_that) {
case _LayoutState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool dragging, List<LayoutBlock> blocks, List<FeedCategory> categories, bool loading, dynamic error, StackTrace? stackTrace)? $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LayoutState() when $default != null:
return $default(_that.dragging,_that.blocks,_that.categories,_that.loading,_that.error,_that.stackTrace);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool dragging, List<LayoutBlock> blocks, List<FeedCategory> categories, bool loading, dynamic error, StackTrace? stackTrace) $default,) {final _that = this;
switch (_that) {
case _LayoutState():
return $default(_that.dragging,_that.blocks,_that.categories,_that.loading,_that.error,_that.stackTrace);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool dragging, List<LayoutBlock> blocks, List<FeedCategory> categories, bool loading, dynamic error, StackTrace? stackTrace)? $default,) {final _that = this;
switch (_that) {
case _LayoutState() when $default != null:
return $default(_that.dragging,_that.blocks,_that.categories,_that.loading,_that.error,_that.stackTrace);case _:
  return null;

}
}

}

/// @nodoc


class _LayoutState extends LayoutState implements WithError {
  const _LayoutState({this.dragging = false, final List<LayoutBlock> blocks = const [], final List<FeedCategory> categories = const [], this.loading = true, this.error, this.stackTrace})
      : _blocks = blocks,
        _categories = categories,
        super._();


@override@JsonKey() final  bool dragging;
 final  List<LayoutBlock> _blocks;
@override@JsonKey() List<LayoutBlock> get blocks {
  if (_blocks is EqualUnmodifiableListView) return _blocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_blocks);
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

/// Create a copy of LayoutState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LayoutStateCopyWith<_LayoutState> get copyWith => __$LayoutStateCopyWithImpl<_LayoutState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType && other is _LayoutState && (identical(other.dragging, dragging) || other.dragging == dragging) &&
      const DeepCollectionEquality().equals(other._blocks, _blocks) && const DeepCollectionEquality().equals(other._categories, _categories) &&
      (identical(other.loading, loading) || other.loading == loading) && const DeepCollectionEquality().equals(other.error, error) &&
      (identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode =>
    Object.hash(
        runtimeType,
        dragging,
        const DeepCollectionEquality().hash(_blocks),
        const DeepCollectionEquality().hash(_categories),
        loading,
        const DeepCollectionEquality().hash(error),
        stackTrace);

@override
String toString() {
  return 'LayoutState(dragging: $dragging, blocks: $blocks, categories: $categories, loading: $loading, error: $error, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class _$LayoutStateCopyWith<$Res> implements $LayoutStateCopyWith<$Res> {
  factory _$LayoutStateCopyWith(_LayoutState value, $Res Function(_LayoutState) _then) = __$LayoutStateCopyWithImpl;
@override @useResult
$Res call({
  bool dragging, List<LayoutBlock> blocks, List<FeedCategory> categories, bool loading, dynamic error, StackTrace? stackTrace
});




}
/// @nodoc
class __$LayoutStateCopyWithImpl<$Res>
    implements _$LayoutStateCopyWith<$Res> {
  __$LayoutStateCopyWithImpl(this._self, this._then);

  final _LayoutState _self;
  final $Res Function(_LayoutState) _then;

/// Create a copy of LayoutState
/// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? dragging = null, Object? blocks = null, Object? categories = null, Object? loading = null, Object? error = freezed, Object? stackTrace = freezed,}) {
  return _then(_LayoutState(
dragging: null == dragging ? _self.dragging : dragging // ignore: cast_nullable_to_non_nullable
as bool,blocks: null == blocks ? _self._blocks : blocks // ignore: cast_nullable_to_non_nullable
  as List<LayoutBlock>,
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
