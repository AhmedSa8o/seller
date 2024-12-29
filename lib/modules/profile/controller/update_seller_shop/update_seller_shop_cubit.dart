import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failure.dart';
import '../../../../utils/errors_model.dart';
import '../../../authentication/login/login_bloc/login_bloc.dart';
import '../../repository/seller_repository.dart';
import 'update_seller_shop_state_model.dart';

part 'update_seller_shop_state.dart';

class UpdateSellerShopCubit extends Cubit<UpdateSellerShopStateModel> {
  final SellerProfileRepository _sellerProfileRepository;
  final LoginBloc _loginBloc;

  UpdateSellerShopCubit(
      {required SellerProfileRepository sellerProfileRepository,
      required LoginBloc loginBloc})
      : _sellerProfileRepository = sellerProfileRepository,
        _loginBloc = loginBloc,
        super(const UpdateSellerShopStateModel());

  bool isNavigate = false;

  void bannerImageChange(String bannerImage) {
    emit(state.copyWith(bannerImage: bannerImage));
  }

  void nameChange(String name) {
    emit(state.copyWith(shopName: name));
  }

  void logoChange(String logo) {
    emit(state.copyWith(logo: logo));
  }

  void openAtChange(String openAt) {
    emit(state.copyWith(openAt: openAt));
  }

  void closedAtChange(String closedAt) {
    emit(state.copyWith(closeAt: closedAt));
  }

  void emailChange(String email) {
    emit(state.copyWith(email: email));
  }

  void phoneChange(String phone) {
    emit(state.copyWith(phone: phone));
  }

  void greetingMessageChange(String greetingMessage) {
    emit(state.copyWith(greetingMessage: greetingMessage));
  }

  void addressChange(String address) {
    emit(state.copyWith(address: address));
  }

  void seoTitleChange(String seoTitle) {
    emit(state.copyWith(seoTitle: seoTitle));
  }

  void seoDescriptionChange(String seoDescription) {
    emit(state.copyWith(seoDescription: seoDescription));
  }

  Future<void> updateSellerShop() async {
    emit(state.copyWith(updateSellerShopState: UpdateSellerShopStateLoading()));
    final body = state;
    // print('updateSellerShopBody: $body');
    final result = await _sellerProfileRepository.updateSellerShop(
        body, _loginBloc.userInformation!.accessToken);

    result.fold((failure) {
      if (failure is InvalidAuthData) {
        final data = UpdateSellerShopStateFormValidate(failure.errors);
        // print('formData: $data');
        emit(state.copyWith(updateSellerShopState: data));
      } else {
        final errors =
            UpdateSellerShopStateError(failure.message, failure.statusCode);
        // print('Errors: $errors');
        emit(state.copyWith(updateSellerShopState: errors));
      }
    }, (updated) {
      emit(state.copyWith(
          updateSellerShopState: UpdateSellerShopStateLoaded(updated)));
      // emit(state.clear());
    });
  }

  FutureOr<void> initState() {
    // print('initState-called');
    const init = UpdateSellerShopInitial();
    emit(state.copyWith(updateSellerShopState: init));
  }
}
