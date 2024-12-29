part of 'store_variant_item_cubit.dart';

abstract class StoreVIState extends Equatable {
  const StoreVIState();

  @override
  List<Object> get props => [];
}

class StoreVIInitial extends StoreVIState {
  const StoreVIInitial();
}

class StoreVIStateLoading extends StoreVIState {}

class StoreVIStateStored extends StoreVIState {
  final String message;

  const StoreVIStateStored(this.message);

  @override
  List<Object> get props => [message];
}

class StoreVIStateUpdated extends StoreVIState {
  final String message;

  const StoreVIStateUpdated(this.message);

  @override
  List<Object> get props => [message];
}

class StoreVIStateStatusChanged extends StoreVIState {
  final String message;

  const StoreVIStateStatusChanged(this.message);

  @override
  List<Object> get props => [message];
}

class StoreVIError extends StoreVIState {
  final String message;
  final int statusCode;

  const StoreVIError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class StoreVIStateFormValidate extends StoreVIState {
  final Errors errors;

  const StoreVIStateFormValidate(this.errors);

  @override
  List<Object> get props => [errors];
}
