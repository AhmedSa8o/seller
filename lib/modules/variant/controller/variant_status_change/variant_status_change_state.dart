part of 'variant_status_change_cubit.dart';

abstract class VPStatusChangeState extends Equatable {
  const VPStatusChangeState();

  @override
  List<Object?> get props => [];
}

class VPStatusChangeInitial extends VPStatusChangeState {
  const VPStatusChangeInitial();
}

class VPStatusChangeLoading extends VPStatusChangeState {
  const VPStatusChangeLoading();
}

class VPStatusChanged extends VPStatusChangeState {
  final String message;

  const VPStatusChanged(this.message);

  @override
  List<Object> get props => [message];
}

class VPStatusChangeError extends VPStatusChangeState {
  final String message;
  final int statusCode;

  const VPStatusChangeError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}
