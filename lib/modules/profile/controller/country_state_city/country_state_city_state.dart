part of 'country_state_city_cubit.dart';

abstract class CountryStateCityState extends Equatable {
  const CountryStateCityState();

  @override
  List<Object> get props => [];
}

class CountryStateCityInitial extends CountryStateCityState {
  const CountryStateCityInitial();
}

class StateByCountryLoading extends CountryStateCityState {}

class CityByStateLoading extends CountryStateCityState {}

class StateByCountryLoaded extends CountryStateCityState {
  final List<StateByCountryModel> states;

  const StateByCountryLoaded(this.states);

  @override
  List<Object> get props => [states];
}

class CityByStateLoaded extends CountryStateCityState {
  final List<CityByStateModel> cities;

  const CityByStateLoaded(this.cities);

  @override
  List<Object> get props => [cities];
}

class StateByCountryError extends CountryStateCityState {
  final String message;
  final int statusCode;

  const StateByCountryError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class CityByStateError extends CountryStateCityState {
  final String message;
  final int statusCode;

  const CityByStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}
