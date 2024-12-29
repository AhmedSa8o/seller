// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'currencies_model.dart';
import 'maintainance_mode_model.dart';
import 'setting_model.dart';

class WebsiteSetupModel extends Equatable {
  final SettingModel setting;
  final dynamic flashSaleActive;

  // final FlashSaleDto flashSale;
  final List<CurrenciesModel> currencies;

  // final List<FlashSaleProductsModel> flashSaleProducts;
  final MaintainTextModel? maintainTextModel;
  final Map<String, String>? imageContent;

  //final PusherInfo pusherInfo;

  const WebsiteSetupModel({
    required this.setting,
    required this.flashSaleActive,
    // required this.flashSale,
    required this.currencies,
    // required this.flashSaleProducts,
    required this.maintainTextModel,
    required this.imageContent,
    //required this.pusherInfo,
  });

  WebsiteSetupModel copyWith({
    SettingModel? setting,
    bool? flashSaleActive,
    // FlashSaleDto? flashSale,
    List<CurrenciesModel>? currencies,
    // List<FlashSaleProductsModel>? flashSaleProducts,
    MaintainTextModel? maintainTextModel,
    Map<String, String>? imageContent,
    //PusherInfo? pusherInfo,
  }) {
    return WebsiteSetupModel(
      setting: setting ?? this.setting,
      flashSaleActive: flashSaleActive ?? this.flashSaleActive,
      // flashSale: flashSale ?? this.flashSale,
      currencies: currencies ?? this.currencies,
      // flashSaleProducts: flashSaleProducts ?? this.flashSaleProducts,
      maintainTextModel: maintainTextModel ?? this.maintainTextModel,
      imageContent: imageContent ?? this.imageContent,
      //pusherInfo: pusherInfo ?? this.pusherInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'setting': setting.toMap(),
      'flashSaleActive': flashSaleActive,
      'image_content': imageContent,
      // 'flashSale': flashSale.toMap(),
      'maintainance': maintainTextModel!.toMap(),
      // 'flashSaleProducts': flashSaleProducts.map((x) => x.toMap()).toList(),
      'currencies': currencies.map((x) => x.toMap()).toList(),
      //'pusher_info': pusherInfo.toMap(),
    };
  }

  factory WebsiteSetupModel.fromMap(Map<String, dynamic> map) {
    return WebsiteSetupModel(
      setting: SettingModel.fromMap(map['setting'] as Map<String, dynamic>),
      flashSaleActive: map['flashSaleActive'] ?? false,
      // flashSale: FlashSaleDto.fromMap(map['flashSale'] as Map<String, dynamic>),
      maintainTextModel: map['maintainance'] != null
          ? MaintainTextModel.fromMap(
              map['maintainance'] as Map<String, dynamic>)
          : null,
      // flashSaleProducts: List<FlashSaleProductsModel>.from(
      //   (map['flashSaleProducts'] as List<dynamic>).map<FlashSaleProductsModel>(
      //     (x) => FlashSaleProductsModel.fromMap(x as Map<String, dynamic>),
      //   ),
      // ),
      // productCategories: List<CategoriesModel>.from(
      //   (map['productCategories'] as List<dynamic>).map<CategoriesModel>(
      //     (x) => CategoriesModel.fromMap(x as Map<String, dynamic>),
      //   ),
      // ),
      currencies: List<CurrenciesModel>.from(
        (map['currencies'] as List<dynamic>).map<CurrenciesModel>(
          (x) => CurrenciesModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      imageContent: map['image_content'] != null
          ? Map<String, String>.from(map['image_content'] as Map)
          : null,
      // pusherInfo:
      //     PusherInfo.fromMap(map['pusher_info'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory WebsiteSetupModel.fromJson(String source) =>
      WebsiteSetupModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      setting,
      flashSaleActive,
      // flashSale,
      currencies,
      // flashSaleProducts,
      imageContent,
      // productCategories,
      // maintainTextModel!,
      // pusherInfo,
    ];
  }
}