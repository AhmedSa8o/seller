import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../dashboard/model/seller_model/seller_model.dart';
import '../../dashboard/model/today_model/user_model.dart';
import 'city_by_state_model.dart';
import 'country_model.dart';
import 'default_profile_model.dart';
import 'seller_setting_model.dart';
import 'state_by_country_model.dart';

class SellerProfileModel extends Equatable {
  final UserModel? user;
  final List<CountryModel>? countries;
  final List<StateByCountryModel>? states;
  final List<CityByStateModel>? cities;
  final SellerModel? seller;
  final int totalWithdraw;
  final int totalAmount;
  final double totalPendingWithdraw;
  final int totalSoldProduct;
  final SellerSettingModel? setting;
  final DefaultProfileModel? defaultProfile;

  const SellerProfileModel({
    this.user,
    this.countries,
    this.states,
    this.cities,
    this.seller,
    required this.totalWithdraw,
    required this.totalAmount,
    required this.totalPendingWithdraw,
    required this.totalSoldProduct,
    this.setting,
    this.defaultProfile,
  });

  SellerProfileModel copyWith({
    UserModel? user,
    List<CountryModel>? countries,
    List<StateByCountryModel>? states,
    List<CityByStateModel>? cities,
    SellerModel? seller,
    int? totalWithdraw,
    int? totalAmount,
    double? totalPendingWithdraw,
    int? totalSoldProduct,
    SellerSettingModel? setting,
    DefaultProfileModel? defaultProfile,
  }) {
    return SellerProfileModel(
      user: user ?? this.user,
      countries: countries ?? this.countries,
      states: states ?? this.states,
      cities: cities ?? this.cities,
      seller: seller ?? this.seller,
      totalWithdraw: totalWithdraw ?? this.totalWithdraw,
      totalAmount: totalAmount ?? this.totalAmount,
      totalPendingWithdraw: totalPendingWithdraw ?? this.totalPendingWithdraw,
      totalSoldProduct: totalSoldProduct ?? this.totalSoldProduct,
      setting: setting ?? this.setting,
      defaultProfile: defaultProfile ?? this.defaultProfile,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user?.toMap(),
      'countries': countries!.map((x) => x.toMap()).toList(),
      'states': states!.map((x) => x.toMap()).toList(),
      'cities': cities!.map((x) => x.toMap()).toList(),
      'seller': seller?.toMap(),
      'totalWithdraw': totalWithdraw,
      'totalAmount': totalAmount,
      'totalPendingWithdraw': totalPendingWithdraw,
      'totalSoldProduct': totalSoldProduct,
      'setting': setting!.toMap(),
      'defaultProfile': defaultProfile!.toMap(),
    };
  }

  factory SellerProfileModel.fromMap(Map<String, dynamic> map) {
    return SellerProfileModel(
      user: map['user'] != null
          ? UserModel.fromMap(map['user'] as Map<String, dynamic>)
          : null,
      countries: map['countries'] != null
          ? List<CountryModel>.from(
              (map['countries'] as List<dynamic>).map<CountryModel?>(
                (x) => CountryModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      states: map['states'] != null
          ? List<StateByCountryModel>.from(
              (map['states'] as List<dynamic>).map<StateByCountryModel?>(
                (x) => StateByCountryModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      cities: map['cities'] != null
          ? List<CityByStateModel>.from(
              (map['cities'] as List<dynamic>).map<CityByStateModel?>(
                (x) => CityByStateModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      seller: map['seller'] != null
          ? SellerModel.fromMap(map['seller'] as Map<String, dynamic>)
          : null,
      totalWithdraw: map['totalWithdraw'] != null
          ? int.parse(map['totalWithdraw'].toString())
          : 0,
      totalAmount: map['totalAmount'] ?? 0,
      totalPendingWithdraw: map['totalPendingWithdraw'] != null
          ? double.parse(map['totalPendingWithdraw'].toString())
          : 0.0,
      totalSoldProduct: map['totalSoldProduct'] ?? 0,
      setting: map['setting'] != null
          ? SellerSettingModel.fromMap(map['setting'] as Map<String, dynamic>)
          : null,
      defaultProfile: map['defaultProfile'] != null
          ? DefaultProfileModel.fromMap(
              map['defaultProfile'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SellerProfileModel.fromJson(String source) =>
      SellerProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      user!,
      countries!,
      states!,
      cities!,
      seller!,
      totalWithdraw,
      totalAmount,
      totalPendingWithdraw,
      totalSoldProduct,
      setting!,
      defaultProfile!,
    ];
  }
}
