part of 'password_cubit.dart';

abstract class PasswordState extends Equatable {
  const PasswordState();

  @override
  List<Object> get props => [];
}

class PasswordInitial extends PasswordState {
  const PasswordInitial();
}

class PasswordCodeLoading extends PasswordState {
  const PasswordCodeLoading();
}

class PasswordCodeError extends PasswordState {
  final String message;

  const PasswordCodeError(this.message);

  @override
  List<Object> get props => [message];
}

class PasswordCodeLoaded extends PasswordState {
  const PasswordCodeLoaded();
}
