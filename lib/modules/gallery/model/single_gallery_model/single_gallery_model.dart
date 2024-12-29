// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class SingleGalleryModel extends Equatable {
  // "id": 46,
  // "product_id": "64",
  // "image": "uploads/custom-images/Gallery-2023-02-06-10-11-25-5244.jpeg",
  // "status": "1",
  // "created_at": "2023-02-06T04:11:25.000000Z",
  // "updated_at": "2023-02-06T04:11:25.000000Z"
  final int id;
  final int productId;
  final String image;
  final int status;
  final String createdAt;
  final String updatedAt;

  const SingleGalleryModel({
    required this.id,
    required this.productId,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  SingleGalleryModel copyWith({
    int? id,
    int? productId,
    String? image,
    int? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return SingleGalleryModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      image: image ?? this.image,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'product_id': productId,
      'image': image,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory SingleGalleryModel.fromMap(Map<String, dynamic> map) {
    return SingleGalleryModel(
      id: map['id'] ?? 0,
      productId: map['product_id'] != null
          ? int.parse(map['product_id'].toString())
          : 0,
      image: map['image'] ?? '',
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SingleGalleryModel.fromJson(String source) =>
      SingleGalleryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      productId,
      image,
      status,
      createdAt,
      updatedAt,
    ];
  }
}
