import 'package:app/feed/models/feed.dart';
import 'package:app/feed/models/feed_category.dart';
import 'package:app/feed/models/feed_item.dart';
import 'package:app/feed/models/time_block.dart';
import 'package:app/feed/models/view_mode.dart';
import 'package:app/feed/services/feed_service.dart';
import 'package:app/identity/states/identity.dart';
import 'package:app/layouts/models/layout_block.dart';
import 'package:app/layouts/services/layout.dart';
import 'package:app/main.dart';
import 'package:app/utils/models/with_error.dart';
import 'package:app/utils/utils.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

part 'main_feed.freezed.dart';

final pageSize = 100;

final _log = Logger('MainFeedCubit');

class MainFeedCubit extends Cubit<MainFeedState> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  final List<String> readItems = [];

  MainFeedCubit(super.initialState) {
    init();
  }

  Future<void> init() async {
    scrollController.addListener(() {
      if (!state.hasScrolled && scrollController.position.pixels > 0) {
        emit(state.copyWith(hasScrolled: true));
      } else if (state.hasScrolled && scrollController.position.pixels == 0) {
        emit(state.copyWith(hasScrolled: false));
      }
      if (state.viewMode == FeedViewMode.feeds &&
          scrollController.position.pixels > scrollController.position.maxScrollExtent * 0.95 &&
          !state.loading) {
        EasyThrottle.throttle('load-feed', Duration(seconds: 1), () {
          if (!state.loading) {
            getFeed();
          }
        });
      }
    });
    refresh();
  }

  @override
  Future<void> close() async {
    scrollController.dispose();
    searchController.dispose();
    super.close();
  }

  void readItem(String? id) {
    if (id == null) {
      return;
    }
    readItems.add(id);

    EasyDebounce.debounce('read-items-update', Duration(seconds: 1), () {
      _log.info('set read status of ${readItems.length} items');
      FeedService(serverUrl!).readItems(List.from(readItems));
      readItems.clear();
    });
  }

  Future<void> getFeed() async {
    try {
      emit(state.copyWith(loading: true));
      var identityCubit = getIt.get<IdentityCubit>();
      var service = FeedService(identityCubit.state.serverUrl ?? '');

      final categoriesAsync = service.getFeedCategories();

      final now = state.currentTime;
      final from = now.add(-state.timeBlock.duration);

      var key = DateTimeRange(start: from, end: now);

      var data = List<FeedItem>.from(
        await service
            .getFeedItems(page: 0, pageSize: 999999, from: from.millisecondsSinceEpoch, to: now.millisecondsSinceEpoch)
            .then((value) => value.content),
      );

      // if required, we sort by read status then by the importance
      if (identityCubit.currentUser?.readItemHandling == .unreadFirstThenDim) {
        data.sort((a, b) {
          final readSort = (a.read == b.read ? 0 : (a.read ? 1 : -1));

          if (readSort == 0) {
            return b.importance.compareTo(a.importance);
          } else {
            return readSort;
          }
        });
      }

      // we need to sort the data into the headlines and stuff
      var map = Map<DateTimeRange, List<FeedItem>>.from(state.items);
      map[key] = data;

      emit(state.copyWith(loading: false, items: map, currentTime: from, categories: await categoriesAsync));
    } catch (e, s) {
      emit(state.copyWith(error: e, stackTrace: s, loading: false));
      rethrow;
    }
  }

  void setSearch(bool enable) {
    emit(
      state.copyWith(viewMode: enable ? .search : .feeds, page: 0, feedItems: [], searchTerms: '', drawerOpened: false),
    );
    searchController.text = '';
    scrollController.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.easeOutQuart);
  }

  Future<void> refresh() async {
    try {
      emit(state.copyWith(loading: true));
      final layout = LayoutService(serverUrl!).getLayout();

      var feedService = FeedService(serverUrl!);
      final errorCount = feedService.countLast24Hours();

      final feeds = feedService.getFeeds();

      emit(
        state.copyWith(
          currentTime: DateTime.now().copyWith(hour: 23, minute: 59, second: 59, millisecond: 999),
          items: {},
          layout: await layout,
          errorCount: await errorCount,
          feeds: await feeds,
        ),
      );
    } catch (e, s) {
      emit(state.copyWith(error: e, stackTrace: s, loading: false));
      _log.severe("Error getting layout or error count", e);
      return;
    }

    try {
      // loading 3 to have a minimum of things to see
      await getFeed();
      await getFeed();
      await getFeed();
    } catch (e) {
      _log.severe('Couldn\'t refresh feed', e);
    }
  }

  Future<void> search(String value) async {
    emit(state.copyWith(page: 0, feedItems: []));
    EasyDebounce.debounce('search', Duration(milliseconds: 500), () async {
      try {
        final results = await FeedService(serverUrl!).search(query: value, page: state.page, pageSize: pageSize);
        emit(state.copyWith(page: 0, feedItems: results, searchTerms: value));
      } catch (e, s) {
        emit(state.copyWith(error: e, stackTrace: s));
      }
    });
  }

  Future<void> loadMoreSearchResults() async {
    try {
      emit(state.copyWith(loading: true));
      final page = state.page + 1;
      final results = await FeedService(serverUrl!).search(query: state.searchTerms, page: page, pageSize: pageSize);
      final feeds = List<FeedItem>.from(state.feedItems);
      feeds.addAll(results);
      emit(state.copyWith(feedItems: feeds, page: page, loading: false));
    } catch (e, s) {
      emit(state.copyWith(loading: false, error: e, stackTrace: s));
    }
  }

  void toggleDrawer() {
    emit(state.copyWith(drawerOpened: !state.drawerOpened));
  }

  void selectFeed(Feed? f) {
    emit(state.copyWith(selectedFeed: f, viewMode: f == null ? .feeds : .singleFeed, page: 0, feedItems: []));
    if (f != null) {
      getSingleFeedItems(0);
    }
  }

  Future<void> getSingleFeedItems(int page) async {
    if (state.selectedFeed == null) return;

    emit(state.copyWith(loading: true));

    // dirty lazy trick, we
    final results = await FeedService(
      serverUrl!,
    ).getSingleFeedItems(state.selectedFeed!, page: page, pageSize: pageSize);
    final feeds = List<FeedItem>.from(state.feedItems);
    feeds.addAll(results.content);
    emit(state.copyWith(feedItems: feeds, page: page, loading: false));
  }
}

@freezed
sealed class MainFeedState with _$MainFeedState implements WithError {
  @Implements<WithError>()
  const factory MainFeedState({
    @Default(false) bool hasScrolled,
    required DateTime currentTime,
    @Default(TimeBlock.one_day) TimeBlock timeBlock,
    @Default(true) bool loading,
    @Default({}) Map<DateTimeRange, List<FeedItem>> items,
    @Default([]) List<FeedCategory> categories,
    @Default([]) List<Feed> feeds,
    Feed? selectedFeed,
    @Default('') String searchTerms,
    @Default([]) List<FeedItem> feedItems,
    @Default(0) int page,
    @Default([]) List<LayoutBlock> layout,
    @Default(0) int errorCount,
    @Default(false) bool drawerOpened,
    @Default(FeedViewMode.feeds) FeedViewMode viewMode,
    dynamic error,
    StackTrace? stackTrace,
  }) = _MainFeedState;

  const MainFeedState._();

  bool get searchMode => viewMode == FeedViewMode.search;

  bool get singleFeedMode => viewMode == FeedViewMode.singleFeed;

  bool get feedsMode => viewMode == FeedViewMode.feeds;
}
