import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'today_model/today_order_product.dart';
import 'today_model/user_model.dart';

class TodayOrderedModel extends Equatable {
  final int id;
  final String orderId;
  final int userId;
  final double totalAmount;
  final int productQuantity;
  final String paymentMethod;
  final int paymentStatus;
  final String paymentApprovalData;
  final String transactionId;
  final String shippingMethod;
  final double shippingCost;
  final double couponCost;
  final int orderStatus;
  final String orderApprovalData;
  final String orderDeliveredData;
  final String orderCompletedData;
  //final int orderDeclinedData;
  //final String cashOnDelivery;
  final String additionalInfo;
  final String createdAt;
  final String updatedAt;
  final UserModel? user;
  final List<SingleOrderedProductModel> orderedProduct;

  const TodayOrderedModel({
    required this.id,
    required this.orderId,
    required this.userId,
    required this.totalAmount,
    required this.productQuantity,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.paymentApprovalData,
    required this.transactionId,
    required this.shippingMethod,
    required this.shippingCost,
    required this.couponCost,
    required this.orderStatus,
    required this.orderApprovalData,
    required this.orderDeliveredData,
    required this.orderCompletedData,
    // required this.orderDeclinedData,
    //required this.cashOnDelivery,
    required this.additionalInfo,
    required this.createdAt,
    required this.updatedAt,
    this.user,
    required this.orderedProduct,
  });

  TodayOrderedModel copyWith({
    int? id,
    String? orderId,
    int? userId,
    double? totalAmount,
    int? productQuantity,
    String? paymentMethod,
    int? paymentStatus,
    String? paymentApprovalData,
    String? transactionId,
    String? shippingMethod,
    double? shippingCost,
    double? couponCost,
    int? orderStatus,
    String? orderApprovalData,
    String? orderDeliveredData,
    String? orderCompletedData,
    //int? orderDeclinedData,
    // String? cashOnDelivery,
    String? additionalInfo,
    String? createdAt,
    String? updatedAt,
    UserModel? user,
    List<SingleOrderedProductModel>? orderedProduct,
  }) {
    return TodayOrderedModel(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      userId: userId ?? this.userId,
      totalAmount: totalAmount ?? this.totalAmount,
      productQuantity: productQuantity ?? this.productQuantity,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentApprovalData: paymentApprovalData ?? this.paymentApprovalData,
      transactionId: transactionId ?? this.transactionId,
      shippingMethod: shippingMethod ?? this.shippingMethod,
      shippingCost: shippingCost ?? this.shippingCost,
      couponCost: couponCost ?? this.couponCost,
      orderStatus: orderStatus ?? this.orderStatus,
      orderApprovalData: orderApprovalData ?? this.orderApprovalData,
      orderCompletedData: orderCompletedData ?? this.orderCompletedData,
      orderDeliveredData: orderDeliveredData ?? this.orderDeliveredData,
      //orderDeclinedData: orderDeclinedData ?? this.orderDeclinedData,
      //cashOnDelivery: cashOnDelivery ?? this.cashOnDelivery,
      additionalInfo: additionalInfo ?? this.additionalInfo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      user: user ?? this.user,
      orderedProduct: orderedProduct ?? this.orderedProduct,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'order_id': orderId,
      'user_id': userId,
      'total_amount': totalAmount,
      'product_qty': productQuantity,
      'payment_method': paymentMethod,
      'payment_status': paymentStatus,
      'payment_approval_date': paymentApprovalData,
      'transection_id': transactionId,
      'shipping_method': shippingMethod,
      'shipping_cost': shippingCost,
      'coupon_coast': couponCost,
      'order_status': orderStatus,
      'order_approval_date': orderApprovalData,
      'order_delivered_date': orderDeliveredData,
      //'order_declined_date': orderDeclinedData,
      'order_completed_date': orderCompletedData,
      //'cash_on_delivery': cashOnDelivery,
      'additional_info': additionalInfo,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user': user!.toMap(),
      'order_products': orderedProduct.map((x) => x.toMap()).toList(),
    };
  }

  factory TodayOrderedModel.fromMap(Map<String, dynamic> map) {
    return TodayOrderedModel(
      id: map['id'] != null ? int.parse(map['id'].toString()) : 0,
      orderId: map['order_id'] ?? '',
      userId: map['user_id'] != null ? int.parse(map['user_id'].toString()) : 0,
      totalAmount: map['total_amount'] != null
          ? double.parse(map['total_amount'].toString())
          : 0.0,
      productQuantity: map['product_qty'] != null
          ? int.parse(map['product_qty'].toString())
          : 0,
      paymentMethod: map['payment_method'] ?? '',
      paymentStatus: map['payment_status'] != null
          ? int.parse(map['payment_status'].toString())
          : 0,
      paymentApprovalData: map['payment_approval_date'] ?? '',
      transactionId: map['transection_id'] ?? '',
      shippingMethod: map['shipping_method'] ?? '',
      shippingCost: map['shipping_cost'] != null
          ? double.parse(map['shipping_cost'].toString())
          : 0.0,
      couponCost: map['coupon_coast'] != null
          ? double.parse(map['coupon_coast'].toString())
          : 0.0,
      orderStatus: map['order_status'] != null
          ? int.parse(map['order_status'].toString())
          : 0,
      orderApprovalData: map['order_approval_date'] ?? '',
      orderCompletedData: map['order_completed_date'] ?? '',
      orderDeliveredData: map['order_delivered_date'] ?? '',
      // orderDeclinedData: map['order_declined_date'] != null
      //     ? int.parse(map['order_declined_date'].toString())
      //     : 0,
      // cashOnDelivery: map['cash_on_delivery'] ?? '',
      additionalInfo: map['additional_info'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      user: map['user'] != null
          ? UserModel.fromMap(map['user'] as Map<String, dynamic>)
          : null,
      orderedProduct: map['order_products'] != null
          ? List<SingleOrderedProductModel>.from(
              (map['order_products'] as List<dynamic>)
                  .map<SingleOrderedProductModel>(
                (x) => SingleOrderedProductModel.fromMap(
                    x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory TodayOrderedModel.fromJson(String source) =>
      TodayOrderedModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      orderId,
      userId,
      totalAmount,
      productQuantity,
      paymentMethod,
      paymentStatus,
      paymentApprovalData,
      transactionId,
      shippingMethod,
      shippingCost,
      couponCost,
      orderStatus,
      orderApprovalData,
      orderDeliveredData,
      //orderDeclinedData,
      // cashOnDelivery,
      additionalInfo,
      createdAt,
      updatedAt,
      user!,
      orderedProduct,
    ];
  }
}
