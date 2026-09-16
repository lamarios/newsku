import 'package:app/feed/models/feed_category.dart';
import 'package:app/feed/services/feed_service.dart';
import 'package:app/utils/models/with_error.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_settings.freezed.dart';

class MainSettingsCubit extends Cubit<MainSettingsState> {
  MainSettingsCubit(super.initialState) {
    getFeeds();
  }

  Future<void> getFeeds() async {
    try {
      emit(state.copyWith(loading: true));

      var feedService = FeedService(serverUrl!);
      var feeds = await feedService.getFeeds();
      var categories = await feedService.getFeedCategories();
      categories.insert(0, FeedCategory(name: ''));
      emit(state.copyWith(loading: false, feeds: feeds.length, categories: categories.length));
    } catch (e, s) {
      emit(state.copyWith(loading: false, error: e, stackTrace: s));
    }
  }
}

@freezed
sealed class MainSettingsState with _$MainSettingsState implements WithError {
  @Implements<WithError>()
  const factory MainSettingsState({
    @Default(true) bool loading,
    @Default(0) int feeds,
    @Default(0) int categories,
    dynamic error,
    StackTrace? stackTrace,
  }) = _MainSettingsState;
}
