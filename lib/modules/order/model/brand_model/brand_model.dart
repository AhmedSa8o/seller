// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class BrandModel extends Equatable {
  final int id;
  final String name;
  final String slug;
  final String logo;
  final int status;
  final String createdAt;
  final String updatedAt;

  const BrandModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.logo,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  BrandModel copyWith({
    int? id,
    String? name,
    String? slug,
    String? logo,
    int? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return BrandModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      logo: logo ?? this.logo,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'slug': slug,
      'logo': logo,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory BrandModel.fromMap(Map<String, dynamic> map) {
    return BrandModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      logo: map['logo'] ?? '',
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BrandModel.fromJson(String source) =>
      BrandModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      slug,
      logo,
      status,
      createdAt,
      updatedAt,
    ];
  }
}
