import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/login/login_bloc/login_bloc.dart';
import '../../model/product_variant-model.dart';
import '../../model/single_variant_model/single_variant_model.dart';
import '../../repository/variant_repository.dart';

part 'variant_state.dart';

class VariantProductCubit extends Cubit<VariantState> {
  final VariantRepository _variantRepository;
  final LoginBloc _loginBloc;

  VariantProductCubit(
      {required VariantRepository variantRepository,
      required LoginBloc loginBloc})
      : _variantRepository = variantRepository,
        _loginBloc = loginBloc,
        super(VariantInitial());

  ProductVariantModel? productVariant;

  SingleVariant? singleVariant;

  Future<void> getAllProductVariantById(String id) async {
    emit(VariantProductLoading());
    final result = await _variantRepository.getAllProductVariantById(
        id, _loginBloc.userInformation!.accessToken);
    result.fold((failure) {
      emit(VariantProductError(failure.message, failure.statusCode));
    }, (success) {
      productVariant = success;
      emit(VariantProductByIdLoaded(success));
    });
  }

  Future<void> getAllProductVariantByVariantId(String id) async {
    emit(VariantProductLoading());
    final result = await _variantRepository.getAllProductVariantByVariantId(
        id, _loginBloc.userInformation!.accessToken);
    result.fold((failure) {
      emit(VariantProductError(failure.message, failure.statusCode));
    }, (success) {
      singleVariant = success;
      emit(VariantProductByVariantIdLoaded(success));
    });
  }

  Future<void> deleteProductVariant(String id) async {
    emit(VariantProductLoading());
    final result = await _variantRepository.deleteProductVariant(
        id, _loginBloc.userInformation!.accessToken);
    result.fold((failure) {
      emit(VariantProductError(failure.message, failure.statusCode));
      return false;
    }, (success) {
      productVariant!.variants
          .removeWhere((element) => element.id.toString() == id);
      getAllProductVariantById(productVariant!.product!.id.toString());
      return true;
    });
  }

  // Future<void> variantProductStatusChange(String id) async {
  //   emit(VariantProductStatusChangeLoading());
  //   final result = await _variantRepository.variantProductStatusChange(
  //       id, _loginBloc.userInformation!.accessToken);
  //   result.fold((failure) {
  //     emit(VariantProductError(failure.message, failure.statusCode));
  //   }, (statusChanged) {
  //     emit(VariantProductStatusChange(statusChanged));
  //   });
  // }
}
