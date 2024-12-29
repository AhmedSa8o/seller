part of 'account_info_cubit.dart';

abstract class AccountInfoState extends Equatable {
  const AccountInfoState();
  @override
  List<Object> get props => [];
}

class AccountInfoInitial extends AccountInfoState {}

class AccountInfoLoading extends AccountInfoState {}

class AccountInfoLoaded extends AccountInfoState {
  final AccountInfoModel accountInfo;
  const AccountInfoLoaded(this.accountInfo);
  @override
  List<Object> get props => [accountInfo];
}

class AccountAllMethodLoaded extends AccountInfoState {
  final List<AccountInfoModel> accountInfo;
  const AccountAllMethodLoaded(this.accountInfo);
  @override
  List<Object> get props => [accountInfo];
}

class AccountInfoError extends AccountInfoState {
  final String message;
  final int statusCode;

  const AccountInfoError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}
