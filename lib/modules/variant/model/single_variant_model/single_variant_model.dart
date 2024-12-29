import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../single_variant_item_model/single_variant_item_model.dart';

class SingleVariantModel extends Equatable {
  // "id": 2,
  // "product_id": "47",
  // "name": "Color",
  // "status": "1",
  // "created_at": "2023-01-02T23:43:10.000000Z",
  // "updated_at": "2023-01-03T15:31:52.000000Z",
  //SingleVariantItemModel
  final int id;
  final int productId;
  final String name;
  final int status;
  final String createdAt;
  final String updatedAt;
  final List<SingleVariantItemModel> variantItems;

  const SingleVariantModel({
    required this.id,
    required this.productId,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.variantItems,
  });

  SingleVariantModel copyWith({
    int? id,
    int? productId,
    String? name,
    int? status,
    String? createdAt,
    String? updatedAt,
    List<SingleVariantItemModel>? variantItems,
  }) {
    return SingleVariantModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      variantItems: variantItems ?? this.variantItems,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'product_id': productId,
      'name': name,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'variant_items': variantItems.map((x) => x.toMap()).toList(),
    };
  }

  factory SingleVariantModel.fromMap(Map<String, dynamic> map) {
    return SingleVariantModel(
      id: map['id'] ?? 0,
      productId: map['product_id'] != null
          ? int.parse(map['product_id'].toString())
          : 0,
      name: map['name'] ?? '',
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      variantItems: map['variant_items'] != null
          ? List<SingleVariantItemModel>.from(
              (map['variant_items'] as List<dynamic>)
                  .map<SingleVariantItemModel>(
                (x) =>
                    SingleVariantItemModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory SingleVariantModel.fromJson(String source) =>
      SingleVariantModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      productId,
      name,
      status,
      createdAt,
      updatedAt,
      variantItems,
    ];
  }
}

class SingleVariant extends Equatable {
  final SingleVariantModel? variant;
  const SingleVariant({
    this.variant,
  });

  SingleVariant copyWith({
    SingleVariantModel? variant,
  }) {
    return SingleVariant(
      variant: variant ?? this.variant,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'variant': variant?.toMap(),
    };
  }

  factory SingleVariant.fromMap(Map<String, dynamic> map) {
    return SingleVariant(
      variant: map['variant'] != null
          ? SingleVariantModel.fromMap(map['variant'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SingleVariant.fromJson(String source) =>
      SingleVariant.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [variant!];
}
