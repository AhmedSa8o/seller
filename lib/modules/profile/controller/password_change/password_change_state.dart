part of 'password_change_cubit.dart';

abstract class PasswordChangeState extends Equatable {
  const PasswordChangeState();

  @override
  List<Object> get props => [];
}

class PasswordChangeInitial extends PasswordChangeState {
  const PasswordChangeInitial();
  @override
  List<Object> get props => [];
}

class PasswordChangeLoading extends PasswordChangeState {
  @override
  List<Object> get props => [];
}

class PasswordChangeLoaded extends PasswordChangeState {
  final String notification;

  const PasswordChangeLoaded(this.notification);

  @override
  List<Object> get props => [notification];
}

class PasswordChangeError extends PasswordChangeState {
  final String message;
  final int statusCode;

  const PasswordChangeError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class PasswordChangeFormError extends PasswordChangeState {
  final Errors errors;

  const PasswordChangeFormError(this.errors);

  @override
  List<Object> get props => [errors];
}
