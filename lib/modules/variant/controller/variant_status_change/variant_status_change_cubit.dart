import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/login/login_bloc/login_bloc.dart';
import '../../model/variant_status_change_state_model.dart';
import '../../repository/variant_repository.dart';

part 'variant_status_change_state.dart';

class VariantStatusChangeCubit extends Cubit<VariantStatusChangeStateModel> {
  final VariantRepository _variantRepository;
  final LoginBloc _loginBloc;

  VariantStatusChangeCubit(
      {required VariantRepository variantRepository,
      required LoginBloc loginBloc})
      : _variantRepository = variantRepository,
        _loginBloc = loginBloc,
        super(const VariantStatusChangeStateModel());

  Future<void> variantProductStatusChange(String id) async {
    emit(state.copyWith(statusChangeState: const VPStatusChangeLoading()));
    final result = await _variantRepository.variantProductStatusChange(
        id, _loginBloc.userInformation!.accessToken);
    result.fold((failure) {
      final errorState =
          VPStatusChangeError(failure.message, failure.statusCode);
      emit(state.copyWith(statusChangeState: errorState));
    }, (statusChanged) {
      final status = VPStatusChanged(statusChanged);
      emit(state.copyWith(statusChangeState: status));
    });
  }
}
