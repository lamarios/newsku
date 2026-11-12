// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_errors.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FeedErrorsState {

 int get page; bool get loading; dynamic get error; StackTrace? get stackTrace; Paginated<FeedError> get errors;
/// Create a copy of FeedErrorsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedErrorsStateCopyWith<FeedErrorsState> get copyWith => _$FeedErrorsStateCopyWithImpl<FeedErrorsState>(this as FeedErrorsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as FeedErrorsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedErrorsState&&(identical(other.page, _this.page) || other.page == _this.page)&&(identical(other.loading, _this.loading) || other.loading == _this.loading)&&const DeepCollectionEquality().equals(other.error, _this.error)&&(identical(other.stackTrace, _this.stackTrace) || other.stackTrace == _this.stackTrace)&&(identical(other.errors, _this.errors) || other.errors == _this.errors));
}


@override
int get hashCode {
  final _this = this as FeedErrorsState;
  return Object.hash(runtimeType,_this.page,_this.loading,const DeepCollectionEquality().hash(_this.error),_this.stackTrace,_this.errors);
}

@override
String toString() {
  final _this = this as FeedErrorsState;
  return 'FeedErrorsState(page: ${_this.page}, loading: ${_this.loading}, error: ${_this.error}, stackTrace: ${_this.stackTrace}, errors: ${_this.errors})';
}


}

/// @nodoc
abstract mixin class $FeedErrorsStateCopyWith<$Res>  {
  factory $FeedErrorsStateCopyWith(FeedErrorsState value, $Res Function(FeedErrorsState) _then) = _$FeedErrorsStateCopyWithImpl;
@useResult
$Res call({
 int page, bool loading, dynamic error, StackTrace? stackTrace, Paginated<FeedError> errors
});


$PaginatedCopyWith<FeedError, $Res> get errors;

}
/// @nodoc
class _$FeedErrorsStateCopyWithImpl<$Res>
    implements $FeedErrorsStateCopyWith<$Res> {
  _$FeedErrorsStateCopyWithImpl(this._self, this._then);

  final FeedErrorsState _self;
  final $Res Function(FeedErrorsState) _then;

/// Create a copy of FeedErrorsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? page = null,Object? loading = null,Object? error = freezed,Object? stackTrace = freezed,Object? errors = null,}) {
  return _then(FeedErrorsState(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as dynamic,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as Paginated<FeedError>,
  ));
}
/// Create a copy of FeedErrorsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginatedCopyWith<FeedError, $Res> get errors {
  
  return $PaginatedCopyWith<FeedError, $Res>(_self.errors, (value) {
    return _then(_self.copyWith(errors: value));
  });
}
}


/// Adds pattern-matching-related methods to [FeedErrorsState].
extension FeedErrorsStatePatterns on FeedErrorsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedErrorsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedErrorsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedErrorsState value)  $default,){
final _that = this;
switch (_that) {
case _FeedErrorsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedErrorsState value)?  $default,){
final _that = this;
switch (_that) {
case _FeedErrorsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int page,  bool loading,  dynamic error,  StackTrace? stackTrace,  Paginated<FeedError> errors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedErrorsState() when $default != null:
return $default(_that.page,_that.loading,_that.error,_that.stackTrace,_that.errors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int page,  bool loading,  dynamic error,  StackTrace? stackTrace,  Paginated<FeedError> errors)  $default,) {final _that = this;
switch (_that) {
case _FeedErrorsState():
return $default(_that.page,_that.loading,_that.error,_that.stackTrace,_that.errors);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int page,  bool loading,  dynamic error,  StackTrace? stackTrace,  Paginated<FeedError> errors)?  $default,) {final _that = this;
switch (_that) {
case _FeedErrorsState() when $default != null:
return $default(_that.page,_that.loading,_that.error,_that.stackTrace,_that.errors);case _:
  return null;

}
}

}

/// @nodoc


class _FeedErrorsState implements FeedErrorsState, WithError {
  const _FeedErrorsState({this.page = 0, this.loading = true, this.error, this.stackTrace, this.errors = const Paginated()});
  

@override@JsonKey() final  int page;
@override@JsonKey() final  bool loading;
@override final  dynamic error;
@override final  StackTrace? stackTrace;
@override@JsonKey() final  Paginated<FeedError> errors;

/// Create a copy of FeedErrorsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedErrorsStateCopyWith<_FeedErrorsState> get copyWith => __$FeedErrorsStateCopyWithImpl<_FeedErrorsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedErrorsState&&(identical(other.page, page) || other.page == page)&&(identical(other.loading, loading) || other.loading == loading)&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace)&&(identical(other.errors, errors) || other.errors == errors));
}


@override
int get hashCode {
    return Object.hash(runtimeType,page,loading,const DeepCollectionEquality().hash(error),stackTrace,errors);
}

@override
String toString() {
    return 'FeedErrorsState(page: $page, loading: $loading, error: $error, stackTrace: $stackTrace, errors: $errors)';
}


}

/// @nodoc
abstract mixin class _$FeedErrorsStateCopyWith<$Res> implements $FeedErrorsStateCopyWith<$Res> {
  factory _$FeedErrorsStateCopyWith(_FeedErrorsState value, $Res Function(_FeedErrorsState) _then) = __$FeedErrorsStateCopyWithImpl;
@override @useResult
$Res call({
 int page, bool loading, dynamic error, StackTrace? stackTrace, Paginated<FeedError> errors
});


@override $PaginatedCopyWith<FeedError, $Res> get errors;

}
/// @nodoc
class __$FeedErrorsStateCopyWithImpl<$Res>
    implements _$FeedErrorsStateCopyWith<$Res> {
  __$FeedErrorsStateCopyWithImpl(this._self, this._then);

  final _FeedErrorsState _self;
  final $Res Function(_FeedErrorsState) _then;

/// Create a copy of FeedErrorsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? page = null,Object? loading = null,Object? error = freezed,Object? stackTrace = freezed,Object? errors = null,}) {
  return _then(_FeedErrorsState(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as dynamic,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as Paginated<FeedError>,
  ));
}

/// Create a copy of FeedErrorsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginatedCopyWith<FeedError, $Res> get errors {
  
  return $PaginatedCopyWith<FeedError, $Res>(_self.errors, (value) {
    return _then(_self.copyWith(errors: value));
  });
}
}

// dart format on
