import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/country_model.dart';
import '/modules/profile/repository/seller_repository.dart';

import '../../../authentication/login/login_bloc/login_bloc.dart';
import '../../model/city_by_state_model.dart';
import '../../model/state_by_country_model.dart';

part 'country_state_city_state.dart';

class CountryStateCityCubit extends Cubit<CountryStateCityState> {
  final SellerProfileRepository _sellerProfileRepository;
  final LoginBloc _loginBloc;
  List<CountryModel> countryList = [];
  List<StateByCountryModel> stateList = [];
  List<CityByStateModel> cityList = [];

  CountryStateCityCubit(
      {required SellerProfileRepository sellerProfileRepository,
      required LoginBloc loginBloc})
      : _sellerProfileRepository = sellerProfileRepository,
        _loginBloc = loginBloc,
        super(const CountryStateCityInitial());

  Future<void> getStateByCountry(String countryId) async {
    stateList = [];
    emit(StateByCountryLoading());
    final result = await _sellerProfileRepository.getStateByCountryList(
        countryId, _loginBloc.userInformation!.accessToken);
    result.fold((failure) {
      emit(StateByCountryError(failure.message, failure.statusCode));
    }, (success) {
      stateList = success.toSet().toList();
      emit(StateByCountryLoaded(success));
    });
  }

  Future<void> getCityByState(String stateId) async {
    cityList = [];
    emit(CityByStateLoading());
    final result = await _sellerProfileRepository.getCityByStateList(
        stateId, _loginBloc.userInformation!.accessToken);
    result.fold((failure) {
      emit(CityByStateError(failure.message, failure.statusCode));
    }, (success) {
      cityList = success.toSet().toList();
      emit(CityByStateLoaded(success));
    });
  }

  StateByCountryModel? filterState(String id) {
    for (var i in stateList) {
      if (i.id.toString() == id) {
        return i;
      }
    }
    return null;
  }

  CityByStateModel? filterCity(String id) {
    for (var i in cityList) {
      if (i.id.toString() == id) {
        return i;
      }
    }
    return null;
  }
}
