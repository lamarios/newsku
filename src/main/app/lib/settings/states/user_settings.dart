import 'package:app/user/models/email_digest_frequency.dart';
import 'package:app/user/models/user.dart';
import 'package:app/user/services/oidc_flow.dart';
import 'package:app/user/services/user_service.dart';
import 'package:app/user/states/signup.dart';
import 'package:app/utils/models/with_error.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_settings.freezed.dart';

class UserSettingsCubit extends Cubit<UserSettingsState> {
  final TextEditingController password = TextEditingController(text: '');
  final TextEditingController repeatPassword = TextEditingController(text: '');
  late final TextEditingController email;

  UserSettingsCubit(super.initialState) {
    email = TextEditingController(text: state.email);

    password.addListener(() => emit(state.copyWith(password: password.value.text.trim())));
    repeatPassword.addListener(() => emit(state.copyWith(repeatPassword: repeatPassword.value.text.trim())));
    email.addListener(() => emit(state.copyWith(email: email.value.text.trim())));
  }

  @override
  Future<void> close() {
    password.dispose();
    repeatPassword.dispose();
    email.dispose();
    return super.close();
  }

  /// Returns whether the update worked, errors are emitted in the state
  Future<bool> updateUser(User user) async {
    try {
      emit(state.copyWith(loading: true));
      await UserService(serverUrl!).updateUser(user);
      return true;
    } catch (e, s) {
      emit(state.copyWith(error: e, stackTrace: s));
      return false;
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  Future<bool> updateEmail() async {
    var user = identityCubit.currentUser;
    if (user == null) {
      return false;
    }
    user = user.copyWith(email: email.value.text.trim());
    final updated = await updateUser(user);
    if (updated) {
      await identityCubit.getUser();
    }
    return updated;
  }

  Future<bool> resetPassword() async {
    var user = identityCubit.currentUser;
    if (user == null) {
      return false;
    }
    user = user.copyWith(password: password.value.text);
    final updated = await updateUser(user);
    if (updated) {
      emit(state.copyWith(password: '', repeatPassword: ''));
      repeatPassword.text = '';
      password.text = '';
    }
    return updated;
  }

  Future<void> linkSso() async {
    final oidcConfig = identityCubit.state.config?.oidcConfig;
    if (oidcConfig == null) {
      return;
    }

    try {
      emit(state.copyWith(loading: true));
      final accessToken = await getOidcAccessToken(oidcConfig);
      if (accessToken == null) {
        return;
      }
      final user = await UserService(serverUrl!).linkOidc(accessToken);
      emit(state.copyWith(ssoLinked: user.oidcSub != null));
      await identityCubit.getUser();
    } catch (e, s) {
      emit(state.copyWith(error: e, stackTrace: s));
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  Future<void> unlinkSso() async {
    try {
      emit(state.copyWith(loading: true));
      final user = await UserService(serverUrl!).unlinkOidc();
      emit(state.copyWith(ssoLinked: user.oidcSub != null));
      await identityCubit.getUser();
    } catch (e, s) {
      emit(state.copyWith(error: e, stackTrace: s));
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  Future<void> setDigestPreference(List<EmailDigestFrequency> list) async {
    var user = identityCubit.currentUser;
    if (user != null) {
      emit(state.copyWith(digest: list));
      user = user.copyWith(emailDigest: list);
      await updateUser(user);
      await identityCubit.getUser();
    }
  }
}

@freezed
sealed class UserSettingsState with _$UserSettingsState implements WithError {
  @Implements<WithError>()
  const factory UserSettingsState({
    @Default(false) bool loading,
    @Default("") String password,
    @Default("") String repeatPassword,
    @Default("") String email,
    @Default([]) List<EmailDigestFrequency> digest,
    @Default(false) bool ssoLinked,
    dynamic error,
    StackTrace? stackTrace,
  }) = _UserSettingsState;

  const UserSettingsState._();

  bool get validEmail => RegExp(emailRegex).hasMatch(email);
}
