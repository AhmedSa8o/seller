import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/login/login_bloc/login_bloc.dart';
import '../../model/product_model.dart';
import '../../repository/orders_repository.dart';

part 'pending_product_state.dart';

class PendingProductCubit extends Cubit<PendingProductState> {
  final OrdersRepository _productRepository;
  final LoginBloc _loginBloc;
  ProductModel? productModel;

  PendingProductCubit(
      {required OrdersRepository productRepository,
      required LoginBloc loginBloc})
      : _productRepository = productRepository,
        _loginBloc = loginBloc,
        super(const PendingProductInitial());

  Future<void> getAllPendingProduct() async {
    emit(const PendingProductLoading());
    final result = await _productRepository
        .getAllPendingProduct(_loginBloc.userInformation!.accessToken);
    result.fold((failure) {
      emit(PendingProductError(failure.message, failure.statusCode));
    }, (product) {
      productModel = product;
      emit(
        PendingProductLoaded(product),
      );
    });
  }
}
