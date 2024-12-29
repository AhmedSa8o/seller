part of 'update_seller_shop_cubit.dart';

abstract class UpdateSellerShopState extends Equatable {
  const UpdateSellerShopState();

  @override
  List<Object> get props => [];
}

class UpdateSellerShopInitial extends UpdateSellerShopState {
  const UpdateSellerShopInitial();
}

class UpdateSellerShopStateLoading extends UpdateSellerShopState {}

class UpdateSellerShopStateLoaded extends UpdateSellerShopState {
  final String message;

  const UpdateSellerShopStateLoaded(this.message);

  @override
  List<Object> get props => [message];
}

class UpdateSellerShopStateError extends UpdateSellerShopState {
  final String message;
  final int statusCode;

  const UpdateSellerShopStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class UpdateSellerShopStateFormValidate extends UpdateSellerShopState {
  final Errors errors;

  const UpdateSellerShopStateFormValidate(this.errors);

  @override
  List<Object> get props => [errors];
}
