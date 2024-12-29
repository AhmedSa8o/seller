import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller_app/modules/variant_items/controller/store_bloc/update_variant_item_state_model.dart';

import '../../../../core/errors/failure.dart';
import '../../../../utils/errors_model.dart';
import '../../../authentication/login/login_bloc/login_bloc.dart';
import '../../repository/variant_item_repository.dart';

part 'update_variant_item_event.dart';

part 'update_variant_item_state.dart';

class UpdateVariantItemBloc
    extends Bloc<UpdateVIEvent, UpdateVariantItemStateModel> {
  final VariantItemRepository _variantItemRepository;
  final LoginBloc _loginBloc;

  UpdateVariantItemBloc({
    required VariantItemRepository variantItemRepository,
    required LoginBloc loginBloc,
  })  : _variantItemRepository = variantItemRepository,
        _loginBloc = loginBloc,
        super(const UpdateVariantItemStateModel()) {
    on<UpdateVIProductIdChangeEvent>((event, emit) {
      emit(state.copyWith(productId: event.productId));
    });
    on<UpdateVIVariantIdChangeEvent>((event, emit) {
      emit(state.copyWith(variantId: event.variantId));
    });
    on<UpdateVINameChangeEvent>((event, emit) {
      emit(state.copyWith(name: event.name));
    });
    on<UpdateVIPriceChangeEvent>((event, emit) {
      emit(state.copyWith(price: event.price));
    });
    on<UpdateVIStatusChangeEvent>((event, emit) {
      emit(state.copyWith(status: event.status));
    });

    on<UpdateVISubmitEvent>(_updateSubmitEvent);
  }

  Future<void> _updateSubmitEvent(UpdateVISubmitEvent event,
      Emitter<UpdateVariantItemStateModel> emit) async {
    print('accessed updateVariantItem');
    emit(state.copyWith(updateVIState: UpdateVariantItemLoading()));
    final body = state;
    print('UpdateBody: $body');
    final result = await _variantItemRepository.updateVariantItem(
        event.itemId, _loginBloc.userInformation!.accessToken, body);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        final errors = UpdateVariantItemFormValidate(failure.errors);
        emit(state.copyWith(updateVIState: errors));
      } else {
        final error =
            UpdateVariantItemError(failure.message, failure.statusCode);
        emit(state.copyWith(updateVIState: error));
      }
    }, (success) {
      emit(state.copyWith(updateVIState: UpdateVariantItemLoaded(success)));
      emit(state.clear());
    });
  }
}
