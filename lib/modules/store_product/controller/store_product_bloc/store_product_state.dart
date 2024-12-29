part of 'store_product_bloc.dart';

abstract class StoreProductState extends Equatable {
  const StoreProductState();

  @override
  List<Object> get props => [];
}

class StoreProductInitial extends StoreProductState {
  const StoreProductInitial();
}

class StoreProductLoading extends StoreProductState {}

class StoreProductLoadError extends StoreProductState {
  final String message;
  final int statusCode;

  const StoreProductLoadError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class StoreProductLoadFormValidate extends StoreProductState {
  final Errors errors;

  const StoreProductLoadFormValidate(this.errors);

  @override
  List<Object> get props => [errors];
}

class StoreProductLoaded extends StoreProductState {
  final String notification;

  const StoreProductLoaded(this.notification);

  @override
  List<Object> get props => [notification];
}

class StoreProductStatusUpdated extends StoreProductState {
  final String message;

  const StoreProductStatusUpdated(this.message);

  @override
  List<Object> get props => [message];
}
