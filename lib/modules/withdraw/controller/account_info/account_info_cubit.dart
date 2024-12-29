import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/login/login_bloc/login_bloc.dart';
import '../../model/account_info_model.dart';
import '../../repository/withdraw_repository.dart';

part 'account_info_state.dart';

class AccountInfoCubit extends Cubit<AccountInfoState> {
  final WithdrawRepository _withdrawRepository;
  final LoginBloc _loginBloc;
  List<AccountInfoModel> accountInfo = [];

  AccountInfoCubit(
      {required WithdrawRepository withdrawRepository,
      required LoginBloc loginBloc})
      : _withdrawRepository = withdrawRepository,
        _loginBloc = loginBloc,
        super(AccountInfoInitial());

  Future<void> getAccountInformation(String id) async {
    emit(AccountInfoLoading());
    final account = await _withdrawRepository.getAccountInformation(
        id, _loginBloc.userInformation!.accessToken);
    account.fold((failure) {
      emit(AccountInfoError(failure.message, failure.statusCode));
    }, (accountInfo) {
      emit(AccountInfoLoaded(accountInfo));
    });
  }

  Future<void> getAllMethodList() async {
    emit(AccountInfoLoading());
    final account = await _withdrawRepository
        .getAllMethodList(_loginBloc.userInformation!.accessToken);
    account.fold((failure) {
      emit(AccountInfoError(failure.message, failure.statusCode));
    }, (methodList) {
      accountInfo = methodList.toList(



      );
      emit(AccountAllMethodLoaded(methodList));
    });
  }
}
