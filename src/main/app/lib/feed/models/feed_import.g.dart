// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_import.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeedImport _$FeedImportFromJson(Map<String, dynamic> json) => _FeedImport(
  url: json['url'] as String,
  feedCategory: json['feedCategory'] == null
      ? null
      : FeedCategory.fromJson(json['feedCategory'] as Map<String, dynamic>),
);

Map<String, dynamic> _$FeedImportToJson(_FeedImport instance) => <String, dynamic>{
  'url': instance.url,
  'feedCategory': instance.feedCategory,
};
