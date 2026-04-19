// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main_feed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MainFeedState {

  bool get hasScrolled;

  DateTime get currentTime;

  TimeBlock get timeBlock;

  bool get loading;

  Map<DateTimeRange, List<FeedItem>> get items;

  List<FeedCategory> get categories;

  bool get searchMode;

  String get searchTerms;

  List<FeedItem> get searchResults;

  int get searchPage;

  List<LayoutBlock> get layout;

  int get errorCount;

  dynamic get error;

  StackTrace? get stackTrace;
/// Create a copy of MainFeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MainFeedStateCopyWith<MainFeedState> get copyWith => _$MainFeedStateCopyWithImpl<MainFeedState>(this as MainFeedState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType && other is MainFeedState && (identical(other.hasScrolled, hasScrolled) || other.hasScrolled == hasScrolled) &&
      (identical(other.currentTime, currentTime) || other.currentTime == currentTime) && (identical(other.timeBlock, timeBlock) || other.timeBlock == timeBlock) &&
      (identical(other.loading, loading) || other.loading == loading) && const DeepCollectionEquality().equals(other.items, items) &&
      const DeepCollectionEquality().equals(other.categories, categories) && (identical(other.searchMode, searchMode) || other.searchMode == searchMode) &&
      (identical(other.searchTerms, searchTerms) || other.searchTerms == searchTerms) && const DeepCollectionEquality().equals(other.searchResults, searchResults) &&
      (identical(other.searchPage, searchPage) || other.searchPage == searchPage) && const DeepCollectionEquality().equals(other.layout, layout) &&
      (identical(other.errorCount, errorCount) || other.errorCount == errorCount) && const DeepCollectionEquality().equals(other.error, error) &&
      (identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode =>
    Object.hash(
        runtimeType,
        hasScrolled,
        currentTime,
        timeBlock,
        loading,
        const DeepCollectionEquality().hash(items),
        const DeepCollectionEquality().hash(categories),
        searchMode,
        searchTerms,
        const DeepCollectionEquality().hash(searchResults),
        searchPage,
        const DeepCollectionEquality().hash(layout),
        errorCount,
        const DeepCollectionEquality().hash(error),
        stackTrace);

@override
String toString() {
  return 'MainFeedState(hasScrolled: $hasScrolled, currentTime: $currentTime, timeBlock: $timeBlock, loading: $loading, items: $items, categories: $categories, searchMode: $searchMode, searchTerms: $searchTerms, searchResults: $searchResults, searchPage: $searchPage, layout: $layout, errorCount: $errorCount, error: $error, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $MainFeedStateCopyWith<$Res>  {
  factory $MainFeedStateCopyWith(MainFeedState value, $Res Function(MainFeedState) _then) = _$MainFeedStateCopyWithImpl;
@useResult
$Res call({
  bool hasScrolled, DateTime currentTime, TimeBlock timeBlock, bool loading, Map<DateTimeRange, List<FeedItem>> items, List<FeedCategory> categories, bool searchMode, String searchTerms, List<
      FeedItem> searchResults, int searchPage, List<LayoutBlock> layout, int errorCount, dynamic error, StackTrace? stackTrace
});




}
/// @nodoc
class _$MainFeedStateCopyWithImpl<$Res>
    implements $MainFeedStateCopyWith<$Res> {
  _$MainFeedStateCopyWithImpl(this._self, this._then);

  final MainFeedState _self;
  final $Res Function(MainFeedState) _then;

/// Create a copy of MainFeedState
/// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call(
      {Object? hasScrolled = null, Object? currentTime = null, Object? timeBlock = null, Object? loading = null, Object? items = null, Object? categories = null, Object? searchMode = null, Object? searchTerms = null, Object? searchResults = null, Object? searchPage = null, Object? layout = null, Object? errorCount = null, Object? error = freezed, Object? stackTrace = freezed,}) {
  return _then(_self.copyWith(
hasScrolled: null == hasScrolled ? _self.hasScrolled : hasScrolled // ignore: cast_nullable_to_non_nullable
as bool,currentTime: null == currentTime ? _self.currentTime : currentTime // ignore: cast_nullable_to_non_nullable
as DateTime,timeBlock: null == timeBlock ? _self.timeBlock : timeBlock // ignore: cast_nullable_to_non_nullable
as TimeBlock,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
  as Map<DateTimeRange, List<FeedItem>>,
    categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
    as List<FeedCategory>,
    searchMode: null == searchMode ? _self.searchMode : searchMode // ignore: cast_nullable_to_non_nullable
as bool,searchTerms: null == searchTerms ? _self.searchTerms : searchTerms // ignore: cast_nullable_to_non_nullable
as String,searchResults: null == searchResults ? _self.searchResults : searchResults // ignore: cast_nullable_to_non_nullable
as List<FeedItem>,searchPage: null == searchPage ? _self.searchPage : searchPage // ignore: cast_nullable_to_non_nullable
as int,layout: null == layout ? _self.layout : layout // ignore: cast_nullable_to_non_nullable
as List<LayoutBlock>,errorCount: null == errorCount ? _self.errorCount : errorCount // ignore: cast_nullable_to_non_nullable
as int,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as dynamic,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}

}


/// Adds pattern-matching-related methods to [MainFeedState].
extension MainFeedStatePatterns on MainFeedState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MainFeedState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MainFeedState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MainFeedState value)  $default,){
final _that = this;
switch (_that) {
case _MainFeedState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MainFeedState value)?  $default,){
final _that = this;
switch (_that) {
case _MainFeedState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool hasScrolled, DateTime currentTime, TimeBlock timeBlock, bool loading, Map<DateTimeRange, List<FeedItem>> items, List<FeedCategory> categories, bool searchMode, String searchTerms, List<FeedItem> searchResults, int searchPage, List<LayoutBlock> layout, int errorCount, dynamic error, StackTrace? stackTrace)? $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MainFeedState() when $default != null:
return $default(_that.hasScrolled,_that.currentTime,_that.timeBlock,_that.loading,_that.items,_that.categories,_that.searchMode,_that.searchTerms,_that.searchResults,_that.searchPage,_that.layout,_that.errorCount,_that.error,_that.stackTrace);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool hasScrolled, DateTime currentTime, TimeBlock timeBlock, bool loading, Map<DateTimeRange, List<FeedItem>> items, List<FeedCategory> categories, bool searchMode, String searchTerms, List<FeedItem> searchResults, int searchPage, List<LayoutBlock> layout, int errorCount, dynamic error, StackTrace? stackTrace) $default,) {final _that = this;
switch (_that) {
case _MainFeedState():
return $default(_that.hasScrolled,_that.currentTime,_that.timeBlock,_that.loading,_that.items,_that.categories,_that.searchMode,_that.searchTerms,_that.searchResults,_that.searchPage,_that.layout,_that.errorCount,_that.error,_that.stackTrace);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool hasScrolled, DateTime currentTime, TimeBlock timeBlock, bool loading, Map<DateTimeRange, List<FeedItem>> items, List<FeedCategory> categories, bool searchMode, String searchTerms, List<FeedItem> searchResults, int searchPage, List<LayoutBlock> layout, int errorCount, dynamic error, StackTrace? stackTrace)? $default,) {final _that = this;
switch (_that) {
case _MainFeedState() when $default != null:
return $default(_that.hasScrolled,_that.currentTime,_that.timeBlock,_that.loading,_that.items,_that.categories,_that.searchMode,_that.searchTerms,_that.searchResults,_that.searchPage,_that.layout,_that.errorCount,_that.error,_that.stackTrace);case _:
  return null;

}
}

}

/// @nodoc


class _MainFeedState implements MainFeedState, WithError {
  const _MainFeedState(
      {this.hasScrolled = false, required this.currentTime, this.timeBlock = TimeBlock.one_day, this.loading = true, final Map<DateTimeRange, List<FeedItem>> items = const {}, final List<
          FeedCategory> categories = const [], this.searchMode = false, this.searchTerms = '', final List<FeedItem> searchResults = const [], this.searchPage = 0, final List<
          LayoutBlock> layout = const [], this.errorCount = 0, this.error, this.stackTrace})
      : _items = items,
        _categories = categories,
        _searchResults = searchResults,
        _layout = layout;


@override@JsonKey() final  bool hasScrolled;
@override final  DateTime currentTime;
@override@JsonKey() final  TimeBlock timeBlock;
@override@JsonKey() final  bool loading;
 final  Map<DateTimeRange, List<FeedItem>> _items;
@override@JsonKey() Map<DateTimeRange, List<FeedItem>> get items {
  if (_items is EqualUnmodifiableMapView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_items);
}

  final List<FeedCategory> _categories;

  @override
  @JsonKey()
  List<FeedCategory> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

@override@JsonKey() final  bool searchMode;
@override@JsonKey() final  String searchTerms;
 final  List<FeedItem> _searchResults;
@override@JsonKey() List<FeedItem> get searchResults {
  if (_searchResults is EqualUnmodifiableListView) return _searchResults;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_searchResults);
}

@override@JsonKey() final  int searchPage;
 final  List<LayoutBlock> _layout;
@override@JsonKey() List<LayoutBlock> get layout {
  if (_layout is EqualUnmodifiableListView) return _layout;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_layout);
}

@override@JsonKey() final  int errorCount;
@override final  dynamic error;
@override final  StackTrace? stackTrace;

/// Create a copy of MainFeedState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MainFeedStateCopyWith<_MainFeedState> get copyWith => __$MainFeedStateCopyWithImpl<_MainFeedState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType && other is _MainFeedState && (identical(other.hasScrolled, hasScrolled) || other.hasScrolled == hasScrolled) &&
      (identical(other.currentTime, currentTime) || other.currentTime == currentTime) && (identical(other.timeBlock, timeBlock) || other.timeBlock == timeBlock) &&
      (identical(other.loading, loading) || other.loading == loading) && const DeepCollectionEquality().equals(other._items, _items) &&
      const DeepCollectionEquality().equals(other._categories, _categories) && (identical(other.searchMode, searchMode) || other.searchMode == searchMode) &&
      (identical(other.searchTerms, searchTerms) || other.searchTerms == searchTerms) && const DeepCollectionEquality().equals(other._searchResults, _searchResults) &&
      (identical(other.searchPage, searchPage) || other.searchPage == searchPage) && const DeepCollectionEquality().equals(other._layout, _layout) &&
      (identical(other.errorCount, errorCount) || other.errorCount == errorCount) && const DeepCollectionEquality().equals(other.error, error) &&
      (identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode =>
    Object.hash(
        runtimeType,
        hasScrolled,
        currentTime,
        timeBlock,
        loading,
        const DeepCollectionEquality().hash(_items),
        const DeepCollectionEquality().hash(_categories),
        searchMode,
        searchTerms,
        const DeepCollectionEquality().hash(_searchResults),
        searchPage,
        const DeepCollectionEquality().hash(_layout),
        errorCount,
        const DeepCollectionEquality().hash(error),
        stackTrace);

@override
String toString() {
  return 'MainFeedState(hasScrolled: $hasScrolled, currentTime: $currentTime, timeBlock: $timeBlock, loading: $loading, items: $items, categories: $categories, searchMode: $searchMode, searchTerms: $searchTerms, searchResults: $searchResults, searchPage: $searchPage, layout: $layout, errorCount: $errorCount, error: $error, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class _$MainFeedStateCopyWith<$Res> implements $MainFeedStateCopyWith<$Res> {
  factory _$MainFeedStateCopyWith(_MainFeedState value, $Res Function(_MainFeedState) _then) = __$MainFeedStateCopyWithImpl;
@override @useResult
$Res call({
  bool hasScrolled, DateTime currentTime, TimeBlock timeBlock, bool loading, Map<DateTimeRange, List<FeedItem>> items, List<FeedCategory> categories, bool searchMode, String searchTerms, List<
      FeedItem> searchResults, int searchPage, List<LayoutBlock> layout, int errorCount, dynamic error, StackTrace? stackTrace
});




}
/// @nodoc
class __$MainFeedStateCopyWithImpl<$Res>
    implements _$MainFeedStateCopyWith<$Res> {
  __$MainFeedStateCopyWithImpl(this._self, this._then);

  final _MainFeedState _self;
  final $Res Function(_MainFeedState) _then;

/// Create a copy of MainFeedState
/// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call(
      {Object? hasScrolled = null, Object? currentTime = null, Object? timeBlock = null, Object? loading = null, Object? items = null, Object? categories = null, Object? searchMode = null, Object? searchTerms = null, Object? searchResults = null, Object? searchPage = null, Object? layout = null, Object? errorCount = null, Object? error = freezed, Object? stackTrace = freezed,}) {
  return _then(_MainFeedState(
hasScrolled: null == hasScrolled ? _self.hasScrolled : hasScrolled // ignore: cast_nullable_to_non_nullable
as bool,currentTime: null == currentTime ? _self.currentTime : currentTime // ignore: cast_nullable_to_non_nullable
as DateTime,timeBlock: null == timeBlock ? _self.timeBlock : timeBlock // ignore: cast_nullable_to_non_nullable
as TimeBlock,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
  as Map<DateTimeRange, List<FeedItem>>,
    categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
    as List<FeedCategory>,
    searchMode: null == searchMode ? _self.searchMode : searchMode // ignore: cast_nullable_to_non_nullable
as bool,searchTerms: null == searchTerms ? _self.searchTerms : searchTerms // ignore: cast_nullable_to_non_nullable
as String,searchResults: null == searchResults ? _self._searchResults : searchResults // ignore: cast_nullable_to_non_nullable
as List<FeedItem>,searchPage: null == searchPage ? _self.searchPage : searchPage // ignore: cast_nullable_to_non_nullable
as int,layout: null == layout ? _self._layout : layout // ignore: cast_nullable_to_non_nullable
as List<LayoutBlock>,errorCount: null == errorCount ? _self.errorCount : errorCount // ignore: cast_nullable_to_non_nullable
as int,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as dynamic,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}


}

// dart format on
