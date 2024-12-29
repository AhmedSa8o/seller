import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/modules/order/model/single_product_model/single_product_model.dart';
import '../../variant/model/single_variant_item_model/single_variant_item_model.dart';
import '../../variant/model/single_variant_model/single_variant_model.dart';

class VariantItemModel extends Equatable {
  final List<SingleVariantItemModel> variantItems;
  final SingleVariant? variant;
  final SingleProductModel? product;

  const VariantItemModel({
    required this.variantItems,
    this.variant,
    this.product,
  });

  VariantItemModel copyWith({
    List<SingleVariantItemModel>? variantItems,
    SingleVariant? variant,
    SingleProductModel? product,
  }) {
    return VariantItemModel(
      variantItems: variantItems ?? this.variantItems,
      variant: variant ?? this.variant,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'variantItems': variantItems.map((x) => x.toMap()).toList(),
      'variant': variant?.toMap(),
      'product': product?.toMap(),
    };
  }

  factory VariantItemModel.fromMap(Map<String, dynamic> map) {
    return VariantItemModel(
      variantItems: map['variantItems'] != null
          ? List<SingleVariantItemModel>.from(
              (map['variantItems'] as List<dynamic>)
                  .map<SingleVariantItemModel>(
                (x) =>
                    SingleVariantItemModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      variant: map['variant'] != null
          ? SingleVariant.fromMap(map['variant'] as Map<String, dynamic>)
          : null,
      product: map['product'] != null
          ? SingleProductModel.fromMap(map['product'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VariantItemModel.fromJson(String source) =>
      VariantItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [variantItems, variant!, product!];
}
