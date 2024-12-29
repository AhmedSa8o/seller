import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'single_order_model/single_order_model.dart';
import 'single_product_model/single_product_model.dart';

class ProductModel extends Equatable {
  final List<SingleProductModel> singleProduct;
  final List<SingleOrderedProductModel> singleOrder;

  const ProductModel({
    required this.singleProduct,
    required this.singleOrder,
  });

  ProductModel copyWith({
    List<SingleProductModel>? singleProduct,
    List<SingleOrderedProductModel>? singleOrder,
  }) {
    return ProductModel(
      singleProduct: singleProduct ?? this.singleProduct,
      singleOrder: singleOrder ?? this.singleOrder,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'products': singleProduct.map((x) => x.toMap()).toList(),
      'orderProducts': singleOrder.map((x) => x.toMap()).toList(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      singleProduct: map['products'] != null
          ? List<SingleProductModel>.from(
              (map['products'] as List<dynamic>).map<SingleProductModel>(
                (x) => SingleProductModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      singleOrder: map['orderProducts'] != null
          ? List<SingleOrderedProductModel>.from(
              (map['orderProducts'] as List<dynamic>)
                  .map<SingleOrderedProductModel>(
                (x) => SingleOrderedProductModel.fromMap(
                    x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [singleProduct, singleOrder];
}
