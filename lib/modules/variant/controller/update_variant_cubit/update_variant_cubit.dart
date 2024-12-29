import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failure.dart';
import '../../../../utils/errors_model.dart';
import '../../../authentication/login/login_bloc/login_bloc.dart';
import '../../repository/variant_repository.dart';
import 'update_variant_state_model.dart';

part 'update_variant_state.dart';

class UpdateVariantCubit extends Cubit<UpdateVariantStateModel> {
  final VariantRepository _variantRepository;
  final LoginBloc _loginBloc;

  UpdateVariantCubit(
      {required VariantRepository variantRepository,
      required LoginBloc loginBloc})
      : _variantRepository = variantRepository,
        _loginBloc = loginBloc,
        super(const UpdateVariantStateModel());

  void nameUpdate(String name) {
    emit(state.copyWith(name: name));
  }

  void productIdUpdate(String productId) {
    emit(state.copyWith(productId: productId));
  }

  void statusUpdate(String status) {
    emit(state.copyWith(status: status));
  }

  Future<void> updateVariantProduct(String id) async {
    emit(state.copyWith(updateState: const UpdateVariantLoading()));
    final body = state;
    print('updateVariantBody: $body');
    final result = await _variantRepository.updateVariantProduct(
        id, _loginBloc.userInformation!.accessToken, body);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        final error = UpdateVariantFormError(failure.errors);
        emit(state.copyWith(updateState: error));
      } else {
        final errorState =
            UpdateVariantError(failure.message, failure.statusCode);
        emit(state.copyWith(updateState: errorState));
      }
    }, (updated) {
      emit(state.copyWith(updateState: VariantProductUpdated(updated)));
      print('Now clearing....');
      emit(state.clear());
      print('state cleared');
    });
  }
}
