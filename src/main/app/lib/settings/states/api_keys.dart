import 'package:app/user/models/api_key.dart';
import 'package:app/user/services/api_key_service.dart';
import 'package:app/utils/models/with_error.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_keys.freezed.dart';

class ApiKeysSettingsCubit extends Cubit<ApiKeysSettingsState> {
  ApiKeysSettingsCubit(super.initialState) {
    getApiKeys();
  }

  Future<void> getApiKeys() async {
    try {
      emit(state.copyWith(loading: true));
      final keys = await ApiKeyService(serverUrl!).getApiKeys();
      emit(state.copyWith(loading: false, keys: keys));
    } catch (e, s) {
      emit(state.copyWith(loading: false, error: e, stackTrace: s));
    }
  }

  /// Returns the created key so it can be shown to the user, null if it failed
  Future<CreatedApiKey?> createApiKey({required String name, DateTime? expiresAt}) async {
    try {
      emit(state.copyWith(loading: true));
      final created = await ApiKeyService(
        serverUrl!,
      ).createApiKey(name: name, expiresAt: expiresAt?.millisecondsSinceEpoch);
      await getApiKeys();
      return created;
    } catch (e, s) {
      emit(state.copyWith(loading: false, error: e, stackTrace: s));
      return null;
    }
  }

  Future<void> deleteApiKey(ApiKey key) async {
    try {
      emit(state.copyWith(loading: true));
      await ApiKeyService(serverUrl!).deleteApiKey(key.id);
      await getApiKeys();
    } catch (e, s) {
      emit(state.copyWith(loading: false, error: e, stackTrace: s));
    }
  }
}

@freezed
sealed class ApiKeysSettingsState with _$ApiKeysSettingsState implements WithError {
  @Implements<WithError>()
  const factory ApiKeysSettingsState({
    @Default(true) bool loading,
    @Default([]) List<ApiKey> keys,
    dynamic error,
    StackTrace? stackTrace,
  }) = _ApiKeysSettingsState;
}
