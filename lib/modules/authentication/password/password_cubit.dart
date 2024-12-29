import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'password_state_model.dart';

part 'password_state.dart';

class PasswordCubit extends Cubit<PasswordStateModel> {
  PasswordCubit() : super(PasswordStateModel());

  final pinCodeController = TextEditingController();

  void emailChange(String text) {
    emit(state.copyWith(email: text, passwordState: const PasswordInitial()));
  }

  void passwordChange(String text) {
    emit(
        state.copyWith(password: text, passwordState: const PasswordInitial()));
  }

  void confirmPasswordChange(String text) {
    emit(state.copyWith(
        confirmPassword: text, passwordState: const PasswordInitial()));
  }

  void showPassword(bool val) {
    emit(state.copyWith(
        showPassword: !val, passwordState: const PasswordInitial()));
  }

  void showConfirmPassword(bool val) {
    emit(state.copyWith(
        showConfirmPassword: !val, passwordState: const PasswordInitial()));
  }

  Future<void> forgotPasswordCodeCheck() async {
    print(pinCodeController.text);
    emit(state.copyWith(passwordState: const PasswordCodeLoading()));
    Future.delayed(const Duration(seconds: 2), () {
      if (pinCodeController.text.isEmpty ||
          pinCodeController.text.length != 6) {
        const error = PasswordCodeError('Invalid or Short length code');
        emit(state.copyWith(passwordState: error));
      } else {
        emit(state.copyWith(passwordState: const PasswordCodeLoaded()));
      }
    });
  }
}
