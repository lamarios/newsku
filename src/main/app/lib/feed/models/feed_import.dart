import 'package:app/feed/models/feed_category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_import.freezed.dart';

part 'feed_import.g.dart';

@freezed
sealed class FeedToImport with _$FeedToImport {
  const factory FeedToImport({required String url, FeedCategory? feedCategory}) = _FeedImport;

  factory FeedToImport.fromJson(Map<String, Object?> json) => _$FeedToImportFromJson(json);
}
