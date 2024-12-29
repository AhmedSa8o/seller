import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../model/order_models.dart';
import '/modules/order/model/seller_all_order_model.dart';

import '../../../authentication/login/login_bloc/login_bloc.dart';
import '../../repository/orders_repository.dart';

part 'seller_order_state.dart';

class SellerOrderCubit extends Cubit<SellerOrderState> {
  final OrdersRepository _productRepository;
  final LoginBloc _loginBloc;
  SellerAllOrdersModel? sellerOrders;
  SellerAllOrdersModel? pendingOrders;
  SellerAllOrdersModel? deliveredOrders;
  SellerAllOrdersModel? progressOrders;
  SellerAllOrdersModel? declinedOrders;
  SellerAllOrdersModel? completedOrders;
  OrderModel? orderModel;

  SellerOrderCubit(
      {required OrdersRepository productRepository,
      required LoginBloc loginBloc})
      : _productRepository = productRepository,
        _loginBloc = loginBloc,
        super(SellerOrderStateLoading());

  Future<void> getSellerAllOrders() async {
    emit(SellerOrderStateLoading());
    final result = await _productRepository
        .getSellerAllOrders(_loginBloc.userInformation!.accessToken);
    result.fold((failure) {
      emit(SellerOrderStateError(failure.message, failure.statusCode));
    }, (orders) {
      sellerOrders = orders;
      emit(
        SellerOrderStateLoaded(sellerOrders: orders),
      );
    });
  }

  Future<void> getSellerPendingOrders() async {
    emit(SellerOrderStateLoading());
    final result = await _productRepository
        .getSellerPendingOrders(_loginBloc.userInformation!.accessToken);
    result.fold((failure) {
      emit(SellerOrderStateError(failure.message, failure.statusCode));
    }, (orders) {
      pendingOrders = orders;
      emit(
        SellerOrderStateLoaded(sellerOrders: orders),
      );
    });
  }

  Future<void> getSellerProgressOrders() async {
    emit(SellerOrderStateLoading());
    final result = await _productRepository
        .getSellerProgressOrders(_loginBloc.userInformation!.accessToken);
    result.fold((failure) {
      emit(SellerOrderStateError(failure.message, failure.statusCode));
    }, (orders) {
      progressOrders = orders;
      emit(
        SellerOrderStateLoaded(sellerOrders: orders),
      );
    });
  }

  Future<void> getSellerDeliveredOrders() async {
    emit(SellerOrderStateLoading());
    final result = await _productRepository
        .getSellerDeliveredOrders(_loginBloc.userInformation!.accessToken);
    result.fold((failure) {
      emit(SellerOrderStateError(failure.message, failure.statusCode));
    }, (orders) {
      deliveredOrders = orders;
      emit(
        SellerOrderStateLoaded(sellerOrders: orders),
      );
    });
  }

  Future<void> getSellerCompletedOrders() async {
    emit(SellerOrderStateLoading());
    final result = await _productRepository
        .getSellerCompletedOrders(_loginBloc.userInformation!.accessToken);
    result.fold((failure) {
      emit(SellerOrderStateError(failure.message, failure.statusCode));
    }, (orders) {
      completedOrders = orders;
      emit(
        SellerOrderStateLoaded(sellerOrders: orders),
      );
    });
  }

  Future<void> getSellerDeclinedOrders() async {
    emit(SellerOrderStateLoading());
    final result = await _productRepository
        .getSellerDeclinedOrders(_loginBloc.userInformation!.accessToken);
    result.fold((failure) {
      emit(SellerOrderStateError(failure.message, failure.statusCode));
    }, (orders) {
      declinedOrders = orders;
      emit(
        SellerOrderStateLoaded(sellerOrders: orders),
      );
    });
  }
}
