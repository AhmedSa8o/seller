import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../order/model/single_product_model/single_product_model.dart';
import 'single_variant_model/single_variant_model.dart';

class ProductVariantModel extends Equatable {
  final List<SingleVariantModel> variants;
  final SingleProductModel? product;

  const ProductVariantModel({
    required this.variants,
    this.product,
  });

  ProductVariantModel copyWith({
    List<SingleVariantModel>? variants,
    SingleProductModel? product,
  }) {
    return ProductVariantModel(
      variants: variants ?? this.variants,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'variants': variants.map((x) => x.toMap()).toList(),
      'product': product?.toMap(),
    };
  }

  factory ProductVariantModel.fromMap(Map<String, dynamic> map) {
    return ProductVariantModel(
      variants: map['variants'] != null
          ? List<SingleVariantModel>.from(
              (map['variants'] as List<dynamic>).map<SingleVariantModel>(
                (x) => SingleVariantModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      product: map['product'] != null
          ? SingleProductModel.fromMap(map['product'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductVariantModel.fromJson(String source) =>
      ProductVariantModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [variants, product!];
}
