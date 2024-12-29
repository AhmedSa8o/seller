// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class SingleOrderedProductModel extends Equatable {
  final int id;
  final int orderId;
  final int productId;
  final int sellerId;
  final String productName;
  final double unitPrice;
  final int quantity;
  final String createdAt;
  final String updatedAt;
  final bool isExpanded;
  const SingleOrderedProductModel({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.sellerId,
    required this.productName,
    required this.unitPrice,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
    this.isExpanded = false,
  });

  SingleOrderedProductModel copyWith({
    int? id,
    int? orderId,
    int? productId,
    int? sellerId,
    String? productName,
    double? unitPrice,
    int? quantity,
    String? createdAt,
    String? updatedAt,
    bool? isExpanded,
  }) {
    return SingleOrderedProductModel(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      sellerId: sellerId ?? this.sellerId,
      productName: productName ?? this.productName,
      unitPrice: unitPrice ?? this.unitPrice,
      quantity: quantity ?? this.quantity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'order_id': orderId,
      'product_id': productId,
      'seller_id': sellerId,
      'product_name': productName,
      'unit_price': unitPrice,
      'qty': quantity,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'isExpanded': isExpanded,
    };
  }

  factory SingleOrderedProductModel.fromMap(Map<String, dynamic> map) {
    return SingleOrderedProductModel(
      id: map['id'] != null ? int.parse(map['id'].toString()) : 0,
      orderId:
          map['order_id'] != null ? int.parse(map['order_id'].toString()) : 0,
      productId: map['product_id'] != null
          ? int.parse(map['product_id'].toString())
          : 0,
      sellerId:
          map['seller_id'] != null ? int.parse(map['seller_id'].toString()) : 0,
      productName: map['product_name'] ?? '',
      unitPrice: map['unit_price'] != null
          ? double.parse(map['unit_price'].toString())
          : 0.0,
      quantity: map['qty'] != null ? int.parse(map['qty'].toString()) : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SingleOrderedProductModel.fromJson(String source) =>
      SingleOrderedProductModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      orderId,
      productId,
      sellerId,
      productName,
      unitPrice,
      quantity,
      createdAt,
      updatedAt,
    ];
  }
}
