part of 'seller_order_cubit.dart';

abstract class SellerOrderState extends Equatable {
  const SellerOrderState();

  @override
  List<Object> get props => [];
}

class SellerOrderStateLoading extends SellerOrderState {}

class SellerOrderStateLoaded extends SellerOrderState {
  final SellerAllOrdersModel sellerOrders;

  const SellerOrderStateLoaded({required this.sellerOrders});

  @override
  List<Object> get props => [sellerOrders];
}

class SellerOrderStateError extends SellerOrderState {
  final String message;
  final int statusCode;

  const SellerOrderStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}
