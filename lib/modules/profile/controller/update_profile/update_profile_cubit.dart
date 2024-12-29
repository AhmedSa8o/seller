import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/errors/failure.dart';

import '../../../../utils/errors_model.dart';
import '../../../authentication/login/login_bloc/login_bloc.dart';
import '../../repository/seller_repository.dart';
import 'update_profile_state_model.dart';

part 'update_profile_state.dart';

class UpdateSellerProfileCubit extends Cubit<UpdateSellerProfileStateModel> {
  final SellerProfileRepository _sellerProfileRepository;
  final LoginBloc _loginBloc;

  UpdateSellerProfileCubit(
      {required SellerProfileRepository sellerProfileRepository,
        required LoginBloc loginBloc})
      : _sellerProfileRepository = sellerProfileRepository,
        _loginBloc = loginBloc,
        super(const UpdateSellerProfileStateModel());

  void imageChange(String image) {
    emit(state.copyWith(image: image));
  }

  void nameChange(String name) {
    emit(state.copyWith(name: name));
  }

  void emailChange(String email) {
    emit(state.copyWith(email: email));
  }

  void phoneChange(String phone) {
    emit(state.copyWith(phone: phone));
  }

  void countryChange(String country) {
    emit(state.copyWith(country: country));
  }

  void countryStateChange(String countryState) {
    emit(state.copyWith(countryState: countryState));
  }

  void cityChange(String city) {
    emit(state.copyWith(city: city));
  }

  void zipCodeChange(String zipCode) {
    emit(state.copyWith(zipCode: zipCode));
  }

  void addressChange(String address) {
    emit(state.copyWith(address: address));
  }

  void addLatLong(double lat, double long) {
    emit(state.copyWith(latitude: lat, longitude: long));
  }

  Future<void> updateSellerProfile() async {
    debugPrint('UpdateProfileBody: ${state.toMap()}');
      emit(state.copyWith(updateProfileState: UpdateProfileStateLoading()));
      final body = state;
      final result = await _sellerProfileRepository.updateSellerProfile(
          body, _loginBloc.userInformation!.accessToken);
      result.fold((failure) {
        if (failure is InvalidAuthData) {
          final errors = UpdateProfileStateFormValidate(failure.errors);
          emit(state.copyWith(updateProfileState: errors));
        } else {
          final errors =
              UpdateProfileStateError(failure.message, failure.statusCode);
          emit(state.copyWith(updateProfileState: errors));
        }
      }, (updated) {
        emit(state.copyWith(
            updateProfileState: UpdateProfileStateLoaded(updated)));
        // emit(state.clear());
      });
     }
  }
