part of 'create_variant_bloc.dart';

abstract class CreateVariantState extends Equatable {
  const CreateVariantState();

  @override
  List<Object> get props => [];
}

class CreateVariantInitial extends CreateVariantState {
  const CreateVariantInitial();

  @override
  List<Object> get props => [];
}

class CreateVariantLoading extends CreateVariantState {
  const CreateVariantLoading();

  @override
  List<Object> get props => [];
}

class CreateVariantLoaded extends CreateVariantState {
  final String message;

  const CreateVariantLoaded(this.message);

  @override
  List<Object> get props => [message];
}

class CreateVariantFormValidate extends CreateVariantState {
  final Errors errors;

  const CreateVariantFormValidate(this.errors);

  @override
  List<Object> get props => [errors];
}

class CreateVariantError extends CreateVariantState {
  final String message;
  final int statusCode;

  const CreateVariantError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}
