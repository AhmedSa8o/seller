part of 'create_variant_bloc.dart';

abstract class CreateVariantEvent extends Equatable {
  const CreateVariantEvent();
}

class CreateVariantNameEvent extends CreateVariantEvent {
  final String name;

  const CreateVariantNameEvent(this.name);

  @override
  List<Object?> get props => [name];
}

class CreateVariantProductIdEvent extends CreateVariantEvent {
  final String productId;

  const CreateVariantProductIdEvent(this.productId);

  @override
  List<Object?> get props => [productId];
}

class CreateVariantStatusEvent extends CreateVariantEvent {
  final String status;

  const CreateVariantStatusEvent(this.status);

  @override
  List<Object?> get props => [status];
}

class CreateVariantSubmitWithIdEvent extends CreateVariantEvent {
  // final String productId;

  const CreateVariantSubmitWithIdEvent();

  @override
  List<Object?> get props => [];
}

class UpdateVariantNameEvent extends CreateVariantEvent {
  final String name;

  const UpdateVariantNameEvent(this.name);

  @override
  List<Object?> get props => [name];
}

class UpdateVariantProductIdEvent extends CreateVariantEvent {
  final String productId;

  const UpdateVariantProductIdEvent(this.productId);

  @override
  List<Object?> get props => [productId];
}

class UpdateVariantStatusEvent extends CreateVariantEvent {
  final String status;

  const UpdateVariantStatusEvent(this.status);

  @override
  List<Object?> get props => [status];
}

class UpdateVariantSubmitEventWithId extends CreateVariantEvent {
  final String id;

  const UpdateVariantSubmitEventWithId(this.id);

  @override
  List<Object?> get props => [id];
}
