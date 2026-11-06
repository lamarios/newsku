import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_key.freezed.dart';

part 'api_key.g.dart';

@freezed
sealed class ApiKey with _$ApiKey {
  const factory ApiKey({
    required String id,
    required String name,
    required int timeCreated,
    int? expiresAt,
    int? lastUsed,
    @Default(false) bool expired,
  }) = _ApiKey;

  factory ApiKey.fromJson(Map<String, Object?> json) => _$ApiKeyFromJson(json);
}

/// Only returned when creating a key, the plain [key] can't be retrieved afterwards
@freezed
sealed class CreatedApiKey with _$CreatedApiKey {
  const factory CreatedApiKey({required ApiKey apiKey, required String key}) = _CreatedApiKey;

  factory CreatedApiKey.fromJson(Map<String, Object?> json) => _$CreatedApiKeyFromJson(json);
}
