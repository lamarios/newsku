import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password.freezed.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final TextEditingController password = TextEditingController(text: '');
  final TextEditingController repeatPassword = TextEditingController(text: '');

  ResetPasswordCubit(super.initialState) {
    password.addListener(() => emit(state.copyWith(password: password.value.text)));
    repeatPassword.addListener(() => emit(state.copyWith(repeatPassword: repeatPassword.value.text)));
  }

  @override
  Future<void> close() async {
    password.dispose();
    repeatPassword.dispose();
    super.close();
  }
}

@freezed
sealed class ResetPasswordState with _$ResetPasswordState {
  const factory ResetPasswordState({@Default("") String password, @Default("") String repeatPassword}) =
      _ResetPasswordState;

  const ResetPasswordState._();

  bool get validPassword => password.trim().isNotEmpty && password == repeatPassword;
}
