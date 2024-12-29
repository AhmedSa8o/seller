import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/login/login_bloc/login_bloc.dart';
import '../../model/withdraw_model.dart';
import '../../repository/withdraw_repository.dart';

part 'withdraw_list_state.dart';

class WithdrawListCubit extends Cubit<WithdrawListState> {
  final WithdrawRepository _withdrawRepository;
  final LoginBloc _loginBloc;
  List<WithdrawModel> withdrawList = [];

  WithdrawListCubit(
      {required WithdrawRepository withdrawRepository,
      required LoginBloc loginBloc})
      : _withdrawRepository = withdrawRepository,
        _loginBloc = loginBloc,
        super(WithdrawListInitial());

  Future<void> getAllWithdrawList() async {
    emit(WithdrawListLoading());
    final result = await _withdrawRepository
        .getAllWithdrawList(_loginBloc.userInformation!.accessToken);
    result.fold(
      (failure) {
        final errors = WithdrawListError(failure.message, failure.statusCode);
        emit(errors);
      },
      (success) {
        withdrawList = success;
        final loadedData = WithdrawListLoaded(success);
        emit(loadedData);
      },
    );
  }
}
