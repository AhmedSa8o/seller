part of 'edit_product_cubit.dart';

abstract class EditProductState extends Equatable {
  const EditProductState();

  @override
  List<Object> get props => [];
}

class EditProductLoading extends EditProductState {
  const EditProductLoading();
}

class EditProductLoaded extends EditProductState {
  final EditProductModel editProductModel;

  const EditProductLoaded(this.editProductModel);

  @override
  // TODO: implement props
  List<Object> get props => [editProductModel];
}

class EditProductError extends EditProductState {
  final String message;
  final int statusCode;

  const EditProductError(this.message, this.statusCode);

  @override
  // TODO: implement props
  List<Object> get props => [message, statusCode];
}
