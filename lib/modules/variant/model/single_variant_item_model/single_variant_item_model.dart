import 'dart:convert';

import 'package:equatable/equatable.dart';

class SingleVariantItemModel extends Equatable {
  // "id": 1,
  // "product_variant_id": "2",
  // "product_variant_name": "Color",
  // "product_id": "47",
  // "name": "Red",
  // "price": "1000",
  // "status": "1",
  // "is_default": "0",
  // "created_at": "2023-01-02T23:44:12.000000Z",
  // "updated_at": "2023-01-03T15:34:08.000000Z"

  final int id;
  final int productVariantId;
  final String productVariantName;
  final int productId;
  final String name;
  final double price;
  final int status;
  final int isDefault;
  final String createdAt;
  final String updatedAt;

  const SingleVariantItemModel({
    required this.id,
    required this.productVariantId,
    required this.productVariantName,
    required this.productId,
    required this.name,
    required this.price,
    required this.status,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
  });

  SingleVariantItemModel copyWith({
    int? id,
    int? productVariantId,
    String? productVariantName,
    int? productId,
    String? name,
    double? price,
    int? status,
    int? isDefault,
    String? createdAt,
    String? updatedAt,
  }) {
    return SingleVariantItemModel(
      id: id ?? this.id,
      productVariantId: productVariantId ?? this.productVariantId,
      productVariantName: productVariantName ?? this.productVariantName,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      status: status ?? this.status,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'product_variant_id': productVariantId,
      'product_variant_name': productVariantName,
      'product_id': productId,
      'name': name,
      'price': price,
      'status': status,
      'is_default': isDefault,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory SingleVariantItemModel.fromMap(Map<String, dynamic> map) {
    return SingleVariantItemModel(
      id: map['id'] ?? 0,
      productVariantId: map['product_variant_id'] != null
          ? int.parse(map['product_variant_id'].toString())
          : 0,
      productVariantName: map['product_variant_name'] ?? '',
      productId: map['product_id'] != null
          ? int.parse(map['product_id'].toString())
          : 0,
      name: map['name'] ?? '',
      price: map['price'] != null ? double.parse(map['price'].toString()) : 0.0,
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      isDefault: map['is_default'] != null
          ? int.parse(map['is_default'].toString())
          : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SingleVariantItemModel.fromJson(String source) =>
      SingleVariantItemModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      productVariantId,
      productVariantName,
      productId,
      name,
      price,
      status,
      isDefault,
      createdAt,
      updatedAt,
    ];
  }
}

class VariantItem extends Equatable {
  final SingleVariantItemModel? variantItem;

  const VariantItem({
    this.variantItem,
  });

  VariantItem copyWith({
    SingleVariantItemModel? variantItem,
  }) {
    return VariantItem(
      variantItem: variantItem ?? this.variantItem,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'variantItem': variantItem?.toMap(),
    };
  }

  factory VariantItem.fromMap(Map<String, dynamic> map) {
    return VariantItem(
      variantItem: map['variantItem'] != null
          ? SingleVariantItemModel.fromMap(
              map['variantItem'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VariantItem.fromJson(String source) =>
      VariantItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [variantItem!];
}
