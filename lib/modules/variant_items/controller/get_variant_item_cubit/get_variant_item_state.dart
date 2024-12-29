part of 'get_variant_item_cubit.dart';

abstract class GetVariantItemState extends Equatable {
  const GetVariantItemState();

  @override
  List<Object> get props => [];
}

class GetVariantItemInitial extends GetVariantItemState {}

class GetVariantItemLoading1 extends GetVariantItemState {}

class GetVariantItemLoading2 extends GetVariantItemState {}

class GetVariantItemLoading3 extends GetVariantItemState {}

class GetVariantItemByIdError extends GetVariantItemState {
  final String message;
  final int statusCode;

  const GetVariantItemByIdError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class GetVariantItemByVPIdError extends GetVariantItemState {
  final String message;
  final int statusCode;

  const GetVariantItemByVPIdError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class GetVariantItemDeletedError extends GetVariantItemState {
  final String message;
  final int statusCode;

  const GetVariantItemDeletedError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class GetVariantItemByIdLoaded extends GetVariantItemState {
  final VariantItem variantItem;

  const GetVariantItemByIdLoaded(this.variantItem);

  @override
  List<Object> get props => [variantItem];
}

class GetVariantItemByVPIdLoaded extends GetVariantItemState {
  final VariantItemModel variantItemModel;

  const GetVariantItemByVPIdLoaded(this.variantItemModel);

  @override
  List<Object> get props => [variantItemModel];
}

class GetVariantItemDeleted extends GetVariantItemState {
  final String message;

  const GetVariantItemDeleted(this.message);

  @override
  List<Object> get props => [message];
}
