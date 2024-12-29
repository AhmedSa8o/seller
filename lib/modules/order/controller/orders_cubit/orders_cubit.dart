import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../authentication/login/login_bloc/login_bloc.dart';
import '../../model/order_models.dart';
import '../../model/product_model.dart';
import '../../repository/orders_repository.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final OrdersRepository _productRepository;
  final LoginBloc _loginBloc;
  OrderModel? orderModel;

  OrdersCubit(
      {required OrdersRepository productRepository,
      required LoginBloc loginBloc})
      : _productRepository = productRepository,
        _loginBloc = loginBloc,
        super(OrderStateLoading());
  ProductModel? productModel;
  Future<void> getAllProduct() async {
    emit(OrderStateLoading());
    final result = await _productRepository
        .getAllProduct(_loginBloc.userInformation!.accessToken);
    result.fold((failure) {
      emit(OrderStateError(failure.message, failure.statusCode));
    }, (product) {
      productModel = product;
      emit(
        OrderStateLoaded(productModel: product),
      );
    });
  }
  Future<void> deleteSingleProduct(String id) async {
    emit(OrderStateLoading());
    final result = await _productRepository.deleteSingleProduct(
        id, _loginBloc.userInformation!.accessToken);
    result.fold((l) {
      emit(DeletedStateError(l.message, l.statusCode));
      return false;
    }, (r) {
      productModel!.singleProduct.removeWhere((e) => e.id.toString() == id);
      emit(DeletedSingleProduct(r));
      getAllProduct();
      return true;
    });
  }

  Future<void> getSingleOrderDetailsProduct(String id) async {
    emit(OrderStateLoading());
    final result = await _productRepository.getSingleOrderDetailsProduct(
        id, _loginBloc.userInformation!.accessToken);
    result.fold((failure) {
      emit(OrderStateError(failure.message, failure.statusCode));
    }, (success) {
      orderModel = success;
      emit(OrderDetailsProductLoaded(orders: success));
    });
  }
}
