import 'package:equatable/equatable.dart';

import 'password_cubit.dart';

class PasswordStateModel extends Equatable {
  final String email;
  final String password;
  bool showPassword;
  bool showConfirmPassword;
  final String confirmPassword;
  final PasswordState passwordState;

  PasswordStateModel({
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.showPassword = true,
    this.showConfirmPassword = true,
    this.passwordState = const PasswordInitial(),
  });

  PasswordStateModel copyWith({
    String? email,
    String? password,
    bool? showPassword,
    bool? showConfirmPassword,
    String? confirmPassword,
    PasswordState? passwordState,
  }) {
    return PasswordStateModel(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      showPassword: showPassword ?? this.showPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
      passwordState: passwordState ?? this.passwordState,
    );
  }

  Map<String, String> toMap() {
    return <String, String>{
      'email': email,
      'password': password,
      'confirm_password': confirmPassword,
    };
  }

  @override
  List<Object?> get props => [
        email,
        password,
        confirmPassword,
        showPassword,
        showConfirmPassword,
        passwordState,
      ];
}
