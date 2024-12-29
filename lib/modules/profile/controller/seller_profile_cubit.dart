import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller_app/modules/dashboard/model/today_model/user_model.dart';

import '/modules/profile/model/seller_profile_model.dart';
import '../../authentication/login/login_bloc/login_bloc.dart';
import '../model/city_by_state_model.dart';
import '../model/country_model.dart';
import '../model/state_by_country_model.dart';
import '../repository/seller_repository.dart';

part 'seller_profile_state.dart';

class SellerProfileCubit extends Cubit<SellerProfileState> {
  final SellerProfileRepository _repository;
  final LoginBloc _loginBloc;
  SellerProfileModel? sellerProfile;

  List<CountryModel> countryList = [];
  List<StateByCountryModel> stateList = [];
  List<CityByStateModel> cityList = [];

  SellerProfileCubit(
      {required SellerProfileRepository repository,
      required LoginBloc loginBloc})
      : _repository = repository,
        _loginBloc = loginBloc,
        super(SellerProfileStateLoading());

  Future<void> getSellerProfile() async {
    emit(SellerProfileStateLoading());
    final result = await _repository
        .getSellerProfile(_loginBloc.userInformation!.accessToken);
    result.fold(
      (l) => emit(SellerProfileStateError(l.message, l.statusCode)),
      (data) {
        sellerProfile = data;
        countryList = data.countries!.toSet().toList();
        stateList = data.states!.toSet().toList();
        cityList = data.cities!.toSet().toList();
        emit(
          SellerProfileStateLoaded(data),
        );
      },
    );
  }

  CountryModel? defaultCountry(UserModel user) {
    for (var item in countryList) {
      if (item.id == user.countryId) {
        return item;
      }
    }
    return null;
  }

  StateByCountryModel? defaultState(String id) {
    for (var item in stateList) {
      if (item.id.toString() == id) {
        return item;
      }
    }
    return null;
  }

  CityByStateModel? defaultCity(String id) {
    for (var item in cityList) {
      if (item.id.toString() == id) {
        return item;
      }
    }
    return null;
  }
}
