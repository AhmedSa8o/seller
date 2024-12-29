part of 'orders_cubit.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object?> get props => [];
}

class OrderStateLoading extends OrdersState {}

class DeletedSingleProduct extends OrdersState {
  final String message;

  const DeletedSingleProduct(this.message);

  @override
  List<Object?> get props => [message];
}

class OrderStateLoaded extends OrdersState {
  final ProductModel productModel;

  const OrderStateLoaded({required this.productModel});

  @override
  List<Object?> get props => [productModel];
}

class OrderStateError extends OrdersState {
  final String message;
  final int statusCode;

  const OrderStateError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}

class OrderDetailsProductLoaded extends OrdersState {
  final OrderModel orders;

  const OrderDetailsProductLoaded({required this.orders});

  @override
  List<Object> get props => [orders];
}

class DeletedStateError extends OrdersState {
  final String message;
  final int statusCode;

  const DeletedStateError(this.message, this.statusCode);

  @override
  List<Object?> get props => [message, statusCode];
}
