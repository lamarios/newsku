// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Feed _$FeedFromJson(Map<String, dynamic> json) => _Feed(
  id: json['id'] as String?,
  name: json['name'] as String?,
  description: json['description'] as String?,
  url: json['url'] as String?,
  itemPreference: json['itemPreference'] as String?,
  image: json['image'] as String?,
  category: json['category'] == null ? null : FeedCategory.fromJson(json['category'] as Map<String, dynamic>),
  lastRefreshErrors: (json['lastRefreshErrors'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$FeedToJson(_Feed instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'url': instance.url,
  'itemPreference': instance.itemPreference,
  'image': instance.image,
  'category': instance.category,
  'lastRefreshErrors': instance.lastRefreshErrors,
};
