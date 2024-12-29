import 'dart:convert';

import 'package:equatable/equatable.dart';

import '/modules/dashboard/model/today_model/user_model.dart';
import '../../order/model/single_product_model/single_product_model.dart';

class ReviewModel extends Equatable {
  final int id;
  final String productId;
  final String userId;
  final String productVendorId;
  final String review;
  final double rating;
  final String status;
  final String createdAt;
  final String updatedAt;
  final UserModel? user;
  final SingleProductModel? product;

  const ReviewModel({
    required this.id,
    required this.productId,
    required this.userId,
    required this.productVendorId,
    required this.review,
    required this.rating,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.user,
    this.product,
  });

  ReviewModel copyWith({
    int? id,
    String? productId,
    String? userId,
    String? productVendorId,
    String? review,
    double? rating,
    String? status,
    String? createdAt,
    String? updatedAt,
    UserModel? user,
    SingleProductModel? product,
  }) {
    return ReviewModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      userId: userId ?? this.userId,
      productVendorId: productVendorId ?? this.productVendorId,
      review: review ?? this.review,
      rating: rating ?? this.rating,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      user: user ?? this.user,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'product_id': productId,
      'user_id': userId,
      'product_vendor_id': productVendorId,
      'review': review,
      'rating': rating,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user': user!.toMap(),
      'product': product?.toMap(),
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      id: map['id'] ?? 0,
      productId: map['product_id'] ?? '',
      userId: map['user_id'] ?? '',
      productVendorId: map['product_vendor_id'] ?? '',
      review: map['review'] ?? '',
      rating:
          map['rating'] != null ? double.parse(map['rating'].toString()) : 0.0,
      status: map['status'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      user: map['user'] != null
          ? UserModel.fromMap(map['user'] as Map<String, dynamic>)
          : null,
      product: map['product'] != null
          ? SingleProductModel.fromMap(map['product'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewModel.fromJson(String source) =>
      ReviewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      productId,
      userId,
      productVendorId,
      review,
      rating,
      status,
      createdAt,
      updatedAt,
      user!,
      product!,
    ];
  }
}
