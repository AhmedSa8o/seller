part of 'update_variant_item_bloc.dart';

abstract class UpdateVIEvent extends Equatable {
  const UpdateVIEvent();

  @override
  List<Object?> get props => [];
}

class UpdateVIProductIdChangeEvent extends UpdateVIEvent {
  final String productId;

  const UpdateVIProductIdChangeEvent(this.productId);

  @override
  List<Object?> get props => [productId];
}

class UpdateVIVariantIdChangeEvent extends UpdateVIEvent {
  final String variantId;

  const UpdateVIVariantIdChangeEvent(this.variantId);

  @override
  List<Object?> get props => [variantId];
}

class UpdateVINameChangeEvent extends UpdateVIEvent {
  final String name;

  const UpdateVINameChangeEvent(this.name);

  @override
  List<Object?> get props => [name];
}

class UpdateVIPriceChangeEvent extends UpdateVIEvent {
  final String price;

  const UpdateVIPriceChangeEvent(this.price);

  @override
  List<Object?> get props => [price];
}

class UpdateVIStatusChangeEvent extends UpdateVIEvent {
  final String status;

  const UpdateVIStatusChangeEvent(this.status);

  @override
  List<Object?> get props => [status];
}

class UpdateVISubmitEvent extends UpdateVIEvent {
  final String itemId;

  const UpdateVISubmitEvent(this.itemId);

  @override
  List<Object?> get props => [itemId];
}
