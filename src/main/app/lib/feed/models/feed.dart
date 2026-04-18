import 'package:app/feed/models/feed_category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed.freezed.dart';
part 'feed.g.dart';

@freezed
sealed class Feed with _$Feed {
  const factory Feed({
    String? id,
    String? name,
    String? description,
    String? url,
    String? itemPreference,
    String? image,
    FeedCategory? category,
    @Default(0) int lastRefreshErrors,
  }) = _Feed;

  factory Feed.fromJson(Map<String, Object?> json) => _$FeedFromJson(json);
}
