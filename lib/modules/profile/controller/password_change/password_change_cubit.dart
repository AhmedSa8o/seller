import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller_app/core/errors/failure.dart';
import 'package:seller_app/utils/errors_model.dart';

import '../../../authentication/login/login_bloc/login_bloc.dart';
import '../../repository/seller_repository.dart';
import 'password_change_state_model.dart';

part 'password_change_state.dart';

class PasswordChangeCubit extends Cubit<PasswordChangeModel> {
  final SellerProfileRepository _sellerProfileRepository;
  final LoginBloc _loginBloc;

  PasswordChangeCubit(
      {required SellerProfileRepository sellerProfileRepository,
      required LoginBloc loginBloc})
      : _sellerProfileRepository = sellerProfileRepository,
        _loginBloc = loginBloc,
        super(const PasswordChangeModel());

  void password(String password) {
    emit(state.copyWith(password: password));
  }

  void confirmPassword(String password) {
    emit(state.copyWith(confirmPassword: password));
  }

  void isVisible(bool visible) {
    emit(state.copyWith(isVisible: visible));
  }

  Future<void> passwordChange() async {
    emit(state.copyWith(passwordState: PasswordChangeLoading()));
    final body = state;
    print('passwordBody: $body');
    final result = await _sellerProfileRepository.passwordChange(
        _loginBloc.userInformation!.accessToken, body);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        emit(state.copyWith(
            passwordState: PasswordChangeFormError(failure.errors)));
      } else {
        emit(state.copyWith(
            passwordState:
                PasswordChangeError(failure.message, failure.statusCode)));
      }
    }, (notification) {
      emit(state.copyWith(passwordState: PasswordChangeLoaded(notification)));
      emit(state.clear());
    });
  }

  Future<void> clearErrorMessage() async {
    emit(state.clear());
  }
}
