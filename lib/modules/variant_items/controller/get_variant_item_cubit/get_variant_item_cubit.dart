import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/modules/variant/model/single_variant_item_model/single_variant_item_model.dart';
import '../../../authentication/login/login_bloc/login_bloc.dart';
import '../../model/variant_item_model.dart';
import '../../repository/variant_item_repository.dart';

part 'get_variant_item_state.dart';

class GetVariantItemCubit extends Cubit<GetVariantItemState> {
  final VariantItemRepository _variantItemRepository;
  final LoginBloc _loginBloc;
  VariantItem? variantItem;
  VariantItemModel? variantItemModel;

  GetVariantItemCubit({
    required VariantItemRepository variantItemRepository,
    required LoginBloc loginBloc,
  })  : _variantItemRepository = variantItemRepository,
        _loginBloc = loginBloc,
        super(GetVariantItemInitial());

  Future<void> getVariantItemById(String id) async {
    emit(GetVariantItemLoading1());
    final result = await _variantItemRepository.getVariantItemById(
        id, _loginBloc.userInformation!.accessToken);
    result.fold((failure) {
      emit(GetVariantItemByIdError(failure.message, failure.statusCode));
    }, (itemById) {
      variantItem = itemById;
          emit(GetVariantItemByIdLoaded(itemById));
    });
  }

  Future<void> getVIByVPIdAndVId(String productId, String variantId) async {
    emit(GetVariantItemLoading1());
    final result = await _variantItemRepository.getVIByVPIdAndVId(
        productId, variantId, _loginBloc.userInformation!.accessToken);
    result.fold((failure) {
      emit(GetVariantItemByVPIdError(failure.message, failure.statusCode));
    }, (itemByPVId) {
      variantItemModel = itemByPVId;
      emit(GetVariantItemByVPIdLoaded(itemByPVId));
    });
  }

  Future<void> deleteVariantItemById(String id) async {
    emit(GetVariantItemLoading1());
    final result = await _variantItemRepository.deleteVariantItemById(
        id, _loginBloc.userInformation!.accessToken);
    result.fold((failure) {
      emit(GetVariantItemDeletedError(failure.message, failure.statusCode));
      return false;
    }, (deletedItem) {
      variantItemModel!.variantItems.removeWhere((e) => e.id.toString() == id);
      emit(GetVariantItemDeleted(deletedItem));
      // Future.delayed(const Duration(milliseconds: 300),(){
      //   getVIByVPIdAndVId(variantItem!.variantItem!.productId.toString(),
      //       variantItem!.variantItem!.productVariantId.toString());
      // });
      return true;
    });
  }
}
