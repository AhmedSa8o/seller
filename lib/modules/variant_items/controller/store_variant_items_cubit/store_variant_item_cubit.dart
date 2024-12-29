import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/errors/failure.dart';
import '/utils/errors_model.dart';
import '../../../authentication/login/login_bloc/login_bloc.dart';
import '../../model/store_variant_item_state_model.dart';
import '../../repository/variant_item_repository.dart';

part 'store_variant_item_state.dart';

class StoreVICubit extends Cubit<StoreVIStateModel> {
  final VariantItemRepository _variantItemRepository;
  final LoginBloc _loginBloc;

  StoreVICubit({
    required VariantItemRepository variantItemRepository,
    required LoginBloc loginBloc,
  })  : _variantItemRepository = variantItemRepository,
        _loginBloc = loginBloc,
        super(const StoreVIStateModel());

  void productIdChange(String productId) {
    emit(state.copyWith(productId: productId));
  }

  void variantIdChange(String variantId) {
    emit(state.copyWith(variantId: variantId));
  }

  void nameChange(String name) {
    emit(state.copyWith(name: name));
  }

  void priceChange(String price) {
    emit(state.copyWith(price: price));
  }

  void statusChange(String status) {
    emit(state.copyWith(status: status));
  }

  Future<void> storeVariantItem() async {
    emit(state.copyWith(itemState: StoreVIStateLoading()));
    final body = state.toMap();
    print('StoreBody: $body');
    final result = await _variantItemRepository.storeVariantItem(
        _loginBloc.userInformation!.accessToken, body);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        final errors = StoreVIStateFormValidate(failure.errors);
        emit(state.copyWith(itemState: errors));
      } else {
        final error = StoreVIError(failure.message, failure.statusCode);
        emit(state.copyWith(itemState: error));
      }
    }, (success) {
      emit(state.copyWith(itemState: StoreVIStateStored(success)));
      emit(state.clear());
    });
  }

  Future<void> updateVIStatus(String itemId) async {
    emit(state.copyWith(itemState: StoreVIStateLoading()));
    final result = await _variantItemRepository.updateVIStatus(
        itemId, _loginBloc.userInformation!.accessToken);
    result.fold((f) {
      emit(state.copyWith(itemState: StoreVIError(f.message, f.statusCode)));
    }, (r) {
      final success = StoreVIStateStatusChanged(r);
      emit(state.copyWith(itemState: success));
      emit(state.clear());
    });
  }
}
