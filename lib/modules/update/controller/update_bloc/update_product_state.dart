part of 'update_product_bloc.dart';

abstract class UpdateProductState extends Equatable {
  const UpdateProductState();

  @override
  List<Object> get props => [];
}

class UpdateProductInitial extends UpdateProductState {
  const UpdateProductInitial();
}

class UpdateProductLoading extends UpdateProductState {
  const UpdateProductLoading();
}

class UpdateProductLoaded extends UpdateProductState {
  final String message;

  const UpdateProductLoaded(this.message);

  @override
  List<Object> get props => [message];
}

class UpdateProductFormValidate extends UpdateProductState {
  final Errors errors;

  const UpdateProductFormValidate(this.errors);

  @override
  List<Object> get props => [errors];
}

class UpdateProductError extends UpdateProductState {
  final String message;
  final int statusCode;

  const UpdateProductError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}
