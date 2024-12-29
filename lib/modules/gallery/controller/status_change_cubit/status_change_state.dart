part of 'status_change_cubit.dart';

abstract class StatusChangeState extends Equatable {
  const StatusChangeState();

  @override
  List<Object> get props => [];
}

class StatusChangeInitial extends StatusChangeState {
  const StatusChangeInitial();
}

class StatusChangeLoading extends StatusChangeState {
  const StatusChangeLoading();
}

class StatusChangeLoaded extends StatusChangeState {
  final String message;

  const StatusChangeLoaded(this.message);

  @override
  List<Object> get props => [message];
}

class StatusChangeError extends StatusChangeState {
  final String message;
  final int statusCode;

  const StatusChangeError(this.message, this.statusCode);

  @override
  // TODO: implement props
  List<Object> get props => [message, statusCode];
}
