import 'package:app/identity/states/identity.dart';
import 'package:app/main.dart';
import 'package:app/user/services/login_service.dart';
import 'package:app/user/services/oidc_flow.dart';
import 'package:app/utils/models/with_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  final String serverUrl;

  LoginCubit(super.initialState, {required this.serverUrl});

  Future<String> login() async {
    try {
      return await LoginService(serverUrl).login(username: state.username, password: state.password);
    } catch (e) {
      emit(state.copyWith(failedLogin: true));
      rethrow;
    }
  }

  Future<String> logInWithOidc() async {
    try {
      var config = getIt.get<IdentityCubit>().state.config;
      if (config?.oidcConfig != null) {
        final accessToken = await getOidcAccessToken(config!.oidcConfig!);

        if (accessToken != null) {
          final token = await LoginService(serverUrl).loginWithOidcToken(accessToken);

          return token;
        }
      }
      throw Error();
    } catch (e, s) {
      emit(state.copyWith(error: e, stackTrace: s));
      // emit(state.copyWith(loginError: e.toString().replaceFirst("Exception: ", '')));
      rethrow;
    }
  }

  void setUser(String value) {
    emit(state.copyWith(username: value));
  }

  void setPassword(String value) {
    emit(state.copyWith(password: value));
  }

  void setLoading(bool bool) {
    emit(state.copyWith(loading: bool));
  }
}

@freezed
sealed class LoginState with _$LoginState implements WithError {
  @Implements<WithError>()
  const factory LoginState({
    @Default(false) bool loading,
    @Default(false) bool failedLogin,
    @Default("") String username,
    @Default("") String password,
    dynamic error,
    StackTrace? stackTrace,
  }) = _LoginState;
}
