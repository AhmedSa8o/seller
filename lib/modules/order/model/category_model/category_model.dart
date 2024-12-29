// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final int id;
  final String name;
  final String slug;
  final String icon;
  final int status;
  final String image;
  final String createdAt;
  final String updatedAt;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.icon,
    required this.status,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  CategoryModel copyWith({
    int? id,
    String? name,
    String? slug,
    String? icon,
    int? status,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      icon: icon ?? this.icon,
      status: status ?? this.status,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'slug': slug,
      'icon': icon,
      'status': status,
      'image': image,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      icon: map['icon'] ?? '',
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      image: map['image'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      slug,
      icon,
      status,
      image,
      createdAt,
      updatedAt,
    ];
  }
}
