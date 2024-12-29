part of 'withdraw_list_cubit.dart';

abstract class WithdrawListState extends Equatable {
  const WithdrawListState();

  @override
  List<Object> get props => [];
}

class WithdrawListInitial extends WithdrawListState {}

class WithdrawListLoading extends WithdrawListState {}

class WithdrawListLoaded extends WithdrawListState {
  final List<WithdrawModel> withdrawList;

  const WithdrawListLoaded(this.withdrawList);

  @override
  List<Object> get props => [withdrawList];
}

class WithdrawListError extends WithdrawListState {
  final String message;
  final int statusCode;

  const WithdrawListError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}
