part of 'update_variant_item_bloc.dart';

abstract class UpdateVariantItemState extends Equatable {
  const UpdateVariantItemState();
  @override
  List<Object> get props => [];
}

class UpdateVariantItemInitial extends UpdateVariantItemState {
  const UpdateVariantItemInitial();
}

class UpdateVariantItemLoading extends UpdateVariantItemState {}

class UpdateVariantItemLoaded extends UpdateVariantItemState {
  final String message;

  const UpdateVariantItemLoaded(this.message);

  @override
  List<Object> get props => [message];
}

class UpdateVariantItemError extends UpdateVariantItemState {
  final String message;
  final int statusCode;

  const UpdateVariantItemError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class UpdateVariantItemFormValidate extends UpdateVariantItemState {
  final Errors errors;

  const UpdateVariantItemFormValidate(this.errors);

  @override
  List<Object> get props => [errors];
}
