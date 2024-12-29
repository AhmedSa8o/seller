part of 'update_profile_cubit.dart';

abstract class UpdateProfileState extends Equatable {
  const UpdateProfileState();

  @override
  List<Object> get props => [];
}

class UpdateProfileInitial extends UpdateProfileState {
  const UpdateProfileInitial();
}
class UpdateProfileStateLoading extends UpdateProfileState {}

class UpdateProfileStateLoaded extends UpdateProfileState {
  final String message;

  const UpdateProfileStateLoaded(this.message);

  @override
  List<Object> get props => [message];
}

class UpdateProfileStateError extends UpdateProfileState {
  final String message;
  final int statusCode;

  const UpdateProfileStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class UpdateProfileStateFormValidate extends UpdateProfileState {
  final Errors errors;

  const UpdateProfileStateFormValidate(this.errors);

  @override
  List<Object> get props => [errors];
}
