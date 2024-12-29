part of 'pending_product_cubit.dart';

abstract class PendingProductState extends Equatable {
  const PendingProductState();

  @override
  List<Object> get props => [];
}

class PendingProductInitial extends PendingProductState {
  const PendingProductInitial();
}

class PendingProductLoaded extends PendingProductState {
  final ProductModel product;

  const PendingProductLoaded(this.product);

  @override
  List<Object> get props => [product];
}

class PendingProductLoading extends PendingProductState {
  const PendingProductLoading();
}

class PendingProductError extends PendingProductState {
  final String message;
  final int statusCode;

  const PendingProductError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}
