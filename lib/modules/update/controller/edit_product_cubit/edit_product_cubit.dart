import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/login/login_bloc/login_bloc.dart';
import '../../model/edit_product_model/edit_product_model.dart';
import '../../repository/update_repository.dart';

part 'edit_product_state.dart';

class EditProductCubit extends Cubit<EditProductState> {
  final UpdateProductRepository _updateProductRepository;
  final LoginBloc _loginBloc;

  EditProductCubit(
      {required UpdateProductRepository updateProductRepository,
      required LoginBloc loginBloc})
      : _updateProductRepository = updateProductRepository,
        _loginBloc = loginBloc,
        super(const EditProductLoading());

  EditProductModel? editProductModel;

  Future<void> getEditProduct(String id) async {
    emit(const EditProductLoading());
    final result = await _updateProductRepository.getEditProduct(
        id, _loginBloc.userInformation!.accessToken);
    result.fold((f) {
      emit(EditProductError(f.message, f.statusCode));
    }, (success) {
      editProductModel = success;
      emit(EditProductLoaded(success));
    });
  }
}
