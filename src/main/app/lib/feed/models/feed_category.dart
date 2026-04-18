import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_category.freezed.dart';
part 'feed_category.g.dart';

@freezed
sealed class FeedCategory with _$FeedCategory {
  const factory FeedCategory({String? id, required String name}) = _FeedCategory;

  factory FeedCategory.fromJson(Map<String, Object?> json) => _$FeedCategoryFromJson(json);
}
