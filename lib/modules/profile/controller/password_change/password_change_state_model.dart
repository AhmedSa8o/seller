import 'package:equatable/equatable.dart';
import '/modules/profile/controller/password_change/password_change_cubit.dart';

class PasswordChangeModel extends Equatable {
  final String password;
  final String confirmPassword;
  final bool isVisible;
  final PasswordChangeState passwordState;

  const PasswordChangeModel({
    this.password = '',
    this.confirmPassword = '',
    this.isVisible = false,
    this.passwordState = const PasswordChangeInitial(),
  });

  PasswordChangeModel copyWith({
    String? password,
    String? confirmPassword,
    bool? isVisible,
    PasswordChangeState? passwordState,
  }) {
    return PasswordChangeModel(
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isVisible: isVisible ?? this.isVisible,
      passwordState: passwordState ?? this.passwordState,
    );
  }

  Map<String, String> toMap() {
    return <String, String>{
      'password': password,
      'password_confirmation': confirmPassword,
    };
  }

  PasswordChangeModel clear() {
    return const PasswordChangeModel(
      password: '',
      confirmPassword: '',
      passwordState: PasswordChangeInitial(),
    );
  }

  @override
  List<Object> get props {
    return [
      password,
      confirmPassword,
      isVisible,
      passwordState,
    ];
  }
}
