part of 'variant_cubit.dart';

abstract class VariantState extends Equatable {
  const VariantState();

  @override
  List<Object> get props => [];
}

class VariantInitial extends VariantState {}

class VariantProductLoading extends VariantState {}

class VariantProductByIdLoaded extends VariantState {
  final ProductVariantModel productVariant;

  const VariantProductByIdLoaded(this.productVariant);

  @override
  List<Object> get props => [productVariant];
}

class VariantProductByVariantIdLoaded extends VariantState {
  final SingleVariant singleVariant;

  const VariantProductByVariantIdLoaded(this.singleVariant);

  @override
  List<Object> get props => [singleVariant];
}

class VariantProductDeleted extends VariantState {
  final String message;

  const VariantProductDeleted(this.message);

  @override
  List<Object> get props => [message];
}

class VariantProductError extends VariantState {
  final String message;
  final int statusCode;

  const VariantProductError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class VariantProductStatusChangeLoading extends VariantState {}

