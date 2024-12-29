import 'dart:convert';

import 'package:equatable/equatable.dart';

class DefaultProfileModel extends Equatable {
  final int id;
  final String header;
  final String title;
  final String link;
  final String image;
  final String bannerLocation;
  //final String afterProductQuantity;
  final int status;
  final String createdAt;
  final String updatedAt;
  final String titleOne;
  final String titleTwo;
  final String badge;
  final String productSlug;

  const DefaultProfileModel({
    required this.id,
    required this.header,
    required this.title,
    required this.link,
    required this.image,
    required this.bannerLocation,
    //required this.afterProductQuantity,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.titleOne,
    required this.titleTwo,
    required this.badge,
    required this.productSlug,
  });

  DefaultProfileModel copyWith({
    int? id,
    String? header,
    String? title,
    String? link,
    String? image,
    String? bannerLocation,
    //String? afterProductQuantity,
    int? status,
    String? createdAt,
    String? updatedAt,
    String? titleOne,
    String? titleTwo,
    String? badge,
    String? productSlug,
  }) {
    return DefaultProfileModel(
      id: id ?? this.id,
      header: header ?? this.header,
      title: title ?? this.title,
      link: link ?? this.link,
      image: image ?? this.image,
      bannerLocation: bannerLocation ?? this.bannerLocation,
      //afterProductQuantity: afterProductQuantity ?? this.afterProductQuantity,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      titleOne: titleOne ?? this.titleOne,
      titleTwo: titleTwo ?? this.titleTwo,
      badge: badge ?? this.badge,
      productSlug: productSlug ?? this.productSlug,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'header': header,
      'title': title,
      'link': link,
      'image': image,
      'banner_location': bannerLocation,
      //'after_product_qty': afterProductQuantity,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'title_one': titleOne,
      'title_two': titleTwo,
      'badge': badge,
      'product_slug': productSlug,
    };
  }

  factory DefaultProfileModel.fromMap(Map<String, dynamic> map) {
    return DefaultProfileModel(
      id: map['id'] ?? 0,
      header: map['header'] ?? '',
      title: map['title'] ?? '',
      link: map['link'] ?? '',
      image: map['image'] ?? '',
      bannerLocation: map['banner_location'] ?? '',
      //afterProductQuantity: map['after_product_qty'] ?? '',
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      titleOne: map['title_one'] ?? '',
      titleTwo: map['title_two'] ?? '',
      badge: map['badge'] ?? '',
      productSlug: map['product_slug'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DefaultProfileModel.fromJson(String source) =>
      DefaultProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      header,
      title,
      link,
      image,
      bannerLocation,
      //afterProductQuantity,
      status,
      createdAt,
      updatedAt,
      titleOne,
      titleTwo,
      badge,
      productSlug,
    ];
  }
}
