part of 'update_variant_cubit.dart';

abstract class UpdateVariantState extends Equatable {
  const UpdateVariantState();

  @override
  List<Object> get props => [];
}

class UpdateVariantInitial extends UpdateVariantState {
  const UpdateVariantInitial();
}

class UpdateVariantLoading extends UpdateVariantState {
  const UpdateVariantLoading();
}

class VariantProductUpdated extends UpdateVariantState {
  final String message;

  const VariantProductUpdated(this.message);

  @override
  List<Object> get props => [message];
}

class UpdateVariantError extends UpdateVariantState {
  final String message;
  final int statusCode;

  const UpdateVariantError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class UpdateVariantFormError extends UpdateVariantState {
  final Errors errors;

  const UpdateVariantFormError(this.errors);

  @override
  List<Object> get props => [errors];
}
