import 'package:app/identity/states/identity.dart';
import 'package:app/main.dart';
import 'package:app/user/models/read_item_handling.dart';
import 'package:app/user/models/user.dart';
import 'package:app/user/services/user_service.dart';
import 'package:app/utils/models/with_error.dart';
import 'package:app/utils/utils.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'general.freezed.dart';

class GeneralSettingsCubit extends Cubit<GeneralSettingsState> {
  final TextEditingController preferenceController = TextEditingController(text: '');

  GeneralSettingsCubit(super.initialState) {
    getUser();
  }

  @override
  Future<void> close() async {
    preferenceController.dispose();
    super.close();
  }

  Future<void> getUser() async {
    try {
      emit(state.copyWith(loading: true));
      final user = await UserService(serverUrl!).getUser();
      preferenceController.text = user.feedItemPreference ?? '';
      emit(state.copyWith(user: user));
    } catch (e, s) {
      emit(state.copyWith(error: e, stackTrace: s));
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  Future<void> updateUser() async {
    try {
      await UserService(serverUrl!).updateUser(state.user!);
      await getIt.get<IdentityCubit>().getUser();
    } catch (e, s) {
      emit(state.copyWith(error: e, stackTrace: s));
    }
  }

  Future<void> setReadItemPreference(ReadItemHandling? pref) async {
    if (state.user != null && pref != null) {
      emit(state.copyWith.user!(readItemHandling: pref));
      await updateUser();
    }
  }

  Future<void> setAiPreferences() async {
    if (state.user != null) {
      emit(state.copyWith.user!(feedItemPreference: preferenceController.value.text));
      await updateUser();
    }
  }

  Future<void> setAndSaveImportance(double importance) async {
    if (state.user != null) {
      emit(state.copyWith.user!(minimumImportance: importance.toInt()));
      EasyDebounce.debounce('importance update', Duration(milliseconds: 250), updateUser);
    }
  }
}

@freezed
sealed class GeneralSettingsState with _$GeneralSettingsState implements WithError {
  @Implements<WithError>()
  const factory GeneralSettingsState({
    User? user,
    @Default(true) bool loading,
    dynamic error,
    StackTrace? stackTrace,
    @Default('') String password,
    @Default('') String repeatPassword,
  }) = _GeneralSettingsState;
}
