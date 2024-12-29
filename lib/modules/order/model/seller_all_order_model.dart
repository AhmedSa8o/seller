import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'seller_order/seller_single_orders_model.dart';

class SellerAllOrdersModel extends Equatable {
  final SellerSingleOrderModel? orders;
  final String title;

  const SellerAllOrdersModel({
    this.orders,
    required this.title,
  });

  SellerAllOrdersModel copyWith({
    SellerSingleOrderModel? orders,
    String? title,
  }) {
    return SellerAllOrdersModel(
      orders: orders ?? this.orders,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orders': orders?.toMap(),
      'title': title,
    };
  }

  factory SellerAllOrdersModel.fromMap(Map<String, dynamic> map) {
    return SellerAllOrdersModel(
      orders: map['orders'] != null
          ? SellerSingleOrderModel.fromMap(
              map['orders'] as Map<String, dynamic>)
          : null,
      title: map['title'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SellerAllOrdersModel.fromJson(String source) =>
      SellerAllOrdersModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [orders!, title];
}
