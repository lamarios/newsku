// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_key.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApiKey _$ApiKeyFromJson(Map<String, dynamic> json) => _ApiKey(
  id: json['id'] as String,
  name: json['name'] as String,
  timeCreated: (json['timeCreated'] as num).toInt(),
  expiresAt: (json['expiresAt'] as num?)?.toInt(),
  lastUsed: (json['lastUsed'] as num?)?.toInt(),
  expired: json['expired'] as bool? ?? false,
);

Map<String, dynamic> _$ApiKeyToJson(_ApiKey instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'timeCreated': instance.timeCreated,
  'expiresAt': instance.expiresAt,
  'lastUsed': instance.lastUsed,
  'expired': instance.expired,
};

_CreatedApiKey _$CreatedApiKeyFromJson(Map<String, dynamic> json) =>
    _CreatedApiKey(apiKey: ApiKey.fromJson(json['apiKey'] as Map<String, dynamic>), key: json['key'] as String);

Map<String, dynamic> _$CreatedApiKeyToJson(_CreatedApiKey instance) => <String, dynamic>{
  'apiKey': instance.apiKey,
  'key': instance.key,
};
