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

  List<Feed> get feeds;

  Feed? get selectedFeed;

  String get searchTerms;

  List<FeedItem> get feedItems;

  int get page;

  List<LayoutBlock> get layout;

  int get errorCount;

  bool get drawerOpened;

  FeedViewMode get viewMode;

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
      const DeepCollectionEquality().equals(other.categories, categories) && const DeepCollectionEquality().equals(other.feeds, feeds) &&
      (identical(other.selectedFeed, selectedFeed) || other.selectedFeed == selectedFeed) && (identical(other.searchTerms, searchTerms) || other.searchTerms == searchTerms) &&
      const DeepCollectionEquality().equals(other.feedItems, feedItems) && (identical(other.page, page) || other.page == page) && const DeepCollectionEquality().equals(other.layout, layout) &&
      (identical(other.errorCount, errorCount) || other.errorCount == errorCount) && (identical(other.drawerOpened, drawerOpened) || other.drawerOpened == drawerOpened) &&
      (identical(other.viewMode, viewMode) || other.viewMode == viewMode) && const DeepCollectionEquality().equals(other.error, error) &&
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
        const DeepCollectionEquality().hash(feeds),
        selectedFeed,
        searchTerms,
        const DeepCollectionEquality().hash(feedItems),
        page,
        const DeepCollectionEquality().hash(layout),
        errorCount,
        drawerOpened,
        viewMode,
        const DeepCollectionEquality().hash(error),
        stackTrace);

@override
String toString() {
  return 'MainFeedState(hasScrolled: $hasScrolled, currentTime: $currentTime, timeBlock: $timeBlock, loading: $loading, items: $items, categories: $categories, feeds: $feeds, selectedFeed: $selectedFeed, searchTerms: $searchTerms, feedItems: $feedItems, page: $page, layout: $layout, errorCount: $errorCount, drawerOpened: $drawerOpened, viewMode: $viewMode, error: $error, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class $MainFeedStateCopyWith<$Res>  {
  factory $MainFeedStateCopyWith(MainFeedState value, $Res Function(MainFeedState) _then) = _$MainFeedStateCopyWithImpl;
@useResult
$Res call({
  bool hasScrolled, DateTime currentTime, TimeBlock timeBlock, bool loading, Map<DateTimeRange, List<FeedItem>> items, List<FeedCategory> categories, List<
      Feed> feeds, Feed? selectedFeed, String searchTerms, List<FeedItem> feedItems, int page, List<
      LayoutBlock> layout, int errorCount, bool drawerOpened, FeedViewMode viewMode, dynamic error, StackTrace? stackTrace
});


  $FeedCopyWith<$Res>? get selectedFeed;

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
      {Object? hasScrolled = null, Object? currentTime = null, Object? timeBlock = null, Object? loading = null, Object? items = null, Object? categories = null, Object? feeds = null, Object? selectedFeed = freezed, Object? searchTerms = null, Object? feedItems = null, Object? page = null, Object? layout = null, Object? errorCount = null, Object? drawerOpened = null, Object? viewMode = null, Object? error = freezed, Object? stackTrace = freezed,}) {
  return _then(_self.copyWith(
hasScrolled: null == hasScrolled ? _self.hasScrolled : hasScrolled // ignore: cast_nullable_to_non_nullable
as bool,currentTime: null == currentTime ? _self.currentTime : currentTime // ignore: cast_nullable_to_non_nullable
as DateTime,timeBlock: null == timeBlock ? _self.timeBlock : timeBlock // ignore: cast_nullable_to_non_nullable
as TimeBlock,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
  as Map<DateTimeRange, List<FeedItem>>,
    categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
    as List<FeedCategory>,
    feeds: null == feeds ? _self.feeds : feeds // ignore: cast_nullable_to_non_nullable
    as List<Feed>,
    selectedFeed: freezed == selectedFeed ? _self.selectedFeed : selectedFeed // ignore: cast_nullable_to_non_nullable
    as Feed?,
    searchTerms: null == searchTerms ? _self.searchTerms : searchTerms // ignore: cast_nullable_to_non_nullable
    as String,
    feedItems: null == feedItems ? _self.feedItems : feedItems // ignore: cast_nullable_to_non_nullable
    as List<FeedItem>,
    page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,layout: null == layout ? _self.layout : layout // ignore: cast_nullable_to_non_nullable
as List<LayoutBlock>,errorCount: null == errorCount ? _self.errorCount : errorCount // ignore: cast_nullable_to_non_nullable
  as int,
    drawerOpened: null == drawerOpened ? _self.drawerOpened : drawerOpened // ignore: cast_nullable_to_non_nullable
    as bool,
    viewMode: null == viewMode ? _self.viewMode : viewMode // ignore: cast_nullable_to_non_nullable
    as FeedViewMode,
    error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as dynamic,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}

  /// Create a copy of MainFeedState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FeedCopyWith<$Res>? get selectedFeed {
    if (_self.selectedFeed == null) {
      return null;
    }

    return $FeedCopyWith<$Res>(_self.selectedFeed!, (value) {
      return _then(_self.copyWith(selectedFeed: value));
    });
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool hasScrolled, DateTime currentTime, TimeBlock timeBlock, bool loading, Map<DateTimeRange, List<FeedItem>> items, List<FeedCategory> categories, List<Feed> feeds, Feed? selectedFeed, String searchTerms, List<FeedItem> feedItems, int page, List<LayoutBlock> layout, int errorCount, bool drawerOpened, FeedViewMode viewMode, dynamic error, StackTrace? stackTrace)? $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MainFeedState() when $default != null:
return $default(_that.hasScrolled,_that.currentTime,_that.timeBlock,_that.loading,_that.items,_that.categories,_that.feeds,_that.selectedFeed,_that.searchTerms,_that.feedItems,_that.page,_that.layout,_that.errorCount,_that.drawerOpened,_that.viewMode,_that.error,_that.stackTrace);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool hasScrolled, DateTime currentTime, TimeBlock timeBlock, bool loading, Map<DateTimeRange, List<FeedItem>> items, List<FeedCategory> categories, List<Feed> feeds, Feed? selectedFeed, String searchTerms, List<FeedItem> feedItems, int page, List<LayoutBlock> layout, int errorCount, bool drawerOpened, FeedViewMode viewMode, dynamic error, StackTrace? stackTrace) $default,) {final _that = this;
switch (_that) {
case _MainFeedState():
return $default(_that.hasScrolled,_that.currentTime,_that.timeBlock,_that.loading,_that.items,_that.categories,_that.feeds,_that.selectedFeed,_that.searchTerms,_that.feedItems,_that.page,_that.layout,_that.errorCount,_that.drawerOpened,_that.viewMode,_that.error,_that.stackTrace);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool hasScrolled, DateTime currentTime, TimeBlock timeBlock, bool loading, Map<DateTimeRange, List<FeedItem>> items, List<FeedCategory> categories, List<Feed> feeds, Feed? selectedFeed, String searchTerms, List<FeedItem> feedItems, int page, List<LayoutBlock> layout, int errorCount, bool drawerOpened, FeedViewMode viewMode, dynamic error, StackTrace? stackTrace)? $default,) {final _that = this;
switch (_that) {
case _MainFeedState() when $default != null:
return $default(_that.hasScrolled,_that.currentTime,_that.timeBlock,_that.loading,_that.items,_that.categories,_that.feeds,_that.selectedFeed,_that.searchTerms,_that.feedItems,_that.page,_that.layout,_that.errorCount,_that.drawerOpened,_that.viewMode,_that.error,_that.stackTrace);case _:
  return null;

}
}

}

/// @nodoc


class _MainFeedState extends MainFeedState implements WithError {
  const _MainFeedState(
      {this.hasScrolled = false, required this.currentTime, this.timeBlock = TimeBlock.one_day, this.loading = true, final Map<DateTimeRange, List<FeedItem>> items = const {}, final List<
          FeedCategory> categories = const [], final List<Feed> feeds = const [], this.selectedFeed, this.searchTerms = '', final List<FeedItem> feedItems = const [], this.page = 0, final List<
          LayoutBlock> layout = const [], this.errorCount = 0, this.drawerOpened = false, this.viewMode = FeedViewMode.feeds, this.error, this.stackTrace})
      : _items = items,
        _categories = categories,
        _feeds = feeds,
        _feedItems = feedItems,
        _layout = layout,
        super._();


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

  final List<Feed> _feeds;

  @override
  @JsonKey()
  List<Feed> get feeds {
    if (_feeds is EqualUnmodifiableListView) return _feeds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_feeds);
  }

  @override final Feed? selectedFeed;
@override@JsonKey() final  String searchTerms;
  final List<FeedItem> _feedItems;

  @override
  @JsonKey()
  List<FeedItem> get feedItems {
    if (_feedItems is EqualUnmodifiableListView) return _feedItems;
  // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_feedItems);
}

  @override
  @JsonKey()
  final int page;
 final  List<LayoutBlock> _layout;
@override@JsonKey() List<LayoutBlock> get layout {
  if (_layout is EqualUnmodifiableListView) return _layout;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_layout);
}

@override@JsonKey() final  int errorCount;
  @override
  @JsonKey()
  final bool drawerOpened;
  @override
  @JsonKey()
  final FeedViewMode viewMode;
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
      const DeepCollectionEquality().equals(other._categories, _categories) && const DeepCollectionEquality().equals(other._feeds, _feeds) &&
      (identical(other.selectedFeed, selectedFeed) || other.selectedFeed == selectedFeed) && (identical(other.searchTerms, searchTerms) || other.searchTerms == searchTerms) &&
      const DeepCollectionEquality().equals(other._feedItems, _feedItems) && (identical(other.page, page) || other.page == page) && const DeepCollectionEquality().equals(other._layout, _layout) &&
      (identical(other.errorCount, errorCount) || other.errorCount == errorCount) && (identical(other.drawerOpened, drawerOpened) || other.drawerOpened == drawerOpened) &&
      (identical(other.viewMode, viewMode) || other.viewMode == viewMode) && const DeepCollectionEquality().equals(other.error, error) &&
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
        const DeepCollectionEquality().hash(_feeds),
        selectedFeed,
        searchTerms,
        const DeepCollectionEquality().hash(_feedItems),
        page,
        const DeepCollectionEquality().hash(_layout),
        errorCount,
        drawerOpened,
        viewMode,
        const DeepCollectionEquality().hash(error),
        stackTrace);

@override
String toString() {
  return 'MainFeedState(hasScrolled: $hasScrolled, currentTime: $currentTime, timeBlock: $timeBlock, loading: $loading, items: $items, categories: $categories, feeds: $feeds, selectedFeed: $selectedFeed, searchTerms: $searchTerms, feedItems: $feedItems, page: $page, layout: $layout, errorCount: $errorCount, drawerOpened: $drawerOpened, viewMode: $viewMode, error: $error, stackTrace: $stackTrace)';
}


}

/// @nodoc
abstract mixin class _$MainFeedStateCopyWith<$Res> implements $MainFeedStateCopyWith<$Res> {
  factory _$MainFeedStateCopyWith(_MainFeedState value, $Res Function(_MainFeedState) _then) = __$MainFeedStateCopyWithImpl;
@override @useResult
$Res call({
  bool hasScrolled, DateTime currentTime, TimeBlock timeBlock, bool loading, Map<DateTimeRange, List<FeedItem>> items, List<FeedCategory> categories, List<
      Feed> feeds, Feed? selectedFeed, String searchTerms, List<FeedItem> feedItems, int page, List<
      LayoutBlock> layout, int errorCount, bool drawerOpened, FeedViewMode viewMode, dynamic error, StackTrace? stackTrace
});


  @override $FeedCopyWith<$Res>? get selectedFeed;

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
      {Object? hasScrolled = null, Object? currentTime = null, Object? timeBlock = null, Object? loading = null, Object? items = null, Object? categories = null, Object? feeds = null, Object? selectedFeed = freezed, Object? searchTerms = null, Object? feedItems = null, Object? page = null, Object? layout = null, Object? errorCount = null, Object? drawerOpened = null, Object? viewMode = null, Object? error = freezed, Object? stackTrace = freezed,}) {
  return _then(_MainFeedState(
hasScrolled: null == hasScrolled ? _self.hasScrolled : hasScrolled // ignore: cast_nullable_to_non_nullable
as bool,currentTime: null == currentTime ? _self.currentTime : currentTime // ignore: cast_nullable_to_non_nullable
as DateTime,timeBlock: null == timeBlock ? _self.timeBlock : timeBlock // ignore: cast_nullable_to_non_nullable
as TimeBlock,loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
  as Map<DateTimeRange, List<FeedItem>>,
    categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
    as List<FeedCategory>,
    feeds: null == feeds ? _self._feeds : feeds // ignore: cast_nullable_to_non_nullable
    as List<Feed>,
    selectedFeed: freezed == selectedFeed ? _self.selectedFeed : selectedFeed // ignore: cast_nullable_to_non_nullable
    as Feed?,
    searchTerms: null == searchTerms ? _self.searchTerms : searchTerms // ignore: cast_nullable_to_non_nullable
    as String,
    feedItems: null == feedItems ? _self._feedItems : feedItems // ignore: cast_nullable_to_non_nullable
    as List<FeedItem>,
    page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,layout: null == layout ? _self._layout : layout // ignore: cast_nullable_to_non_nullable
as List<LayoutBlock>,errorCount: null == errorCount ? _self.errorCount : errorCount // ignore: cast_nullable_to_non_nullable
  as int,
    drawerOpened: null == drawerOpened ? _self.drawerOpened : drawerOpened // ignore: cast_nullable_to_non_nullable
    as bool,
    viewMode: null == viewMode ? _self.viewMode : viewMode // ignore: cast_nullable_to_non_nullable
    as FeedViewMode,
    error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as dynamic,stackTrace: freezed == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace?,
  ));
}

  /// Create a copy of MainFeedState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FeedCopyWith<$Res>? get selectedFeed {
    if (_self.selectedFeed == null) {
      return null;
    }

    return $FeedCopyWith<$Res>(_self.selectedFeed!, (value) {
      return _then(_self.copyWith(selectedFeed: value));
    });
  }
}

// dart format on
