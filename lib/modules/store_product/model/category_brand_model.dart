import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../order/model/brand_model/brand_model.dart';
import '../../order/model/category_model/category_model.dart';

class CategoryBrandModel extends Equatable {
  final List<CategoryModel> category;
  final List<BrandModel> brands;
  final List<SpecificationModel> specificationKey;

  const CategoryBrandModel({
    required this.category,
    required this.brands,
    required this.specificationKey,
  });

  CategoryBrandModel copyWith({
    List<CategoryModel>? category,
    List<BrandModel>? brands,
    List<SpecificationModel>? specificationKey,
  }) {
    return CategoryBrandModel(
      category: category ?? this.category,
      brands: brands ?? this.brands,
      specificationKey: specificationKey ?? this.specificationKey,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categories': category.map((x) => x.toMap()).toList(),
      'brands': brands.map((x) => x.toMap()).toList(),
      'specificationKeys': specificationKey.map((x) => x.toMap()).toList(),
    };
  }

  factory CategoryBrandModel.fromMap(Map<String, dynamic> map) {
    return CategoryBrandModel(
      category: map['categories'] != null
          ? List<CategoryModel>.from(
              (map['categories'] as List<dynamic>).map<CategoryModel>(
                (x) => CategoryModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      brands: map['brands'] != null
          ? List<BrandModel>.from(
              (map['brands'] as List<dynamic>).map<BrandModel>(
                (x) => BrandModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      specificationKey: map['specificationKeys'] != null
          ? List<SpecificationModel>.from(
              (map['specificationKeys'] as List<dynamic>)
                  .map<SpecificationModel>(
                (x) => SpecificationModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryBrandModel.fromJson(String source) =>
      CategoryBrandModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [category, brands, specificationKey];
}

class SpecificationModel extends Equatable {
  final int id;
  final String key;
  final int status;
  final String createdAt;
  final String updatedAt;

  const SpecificationModel({
    required this.id,
    required this.key,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  SpecificationModel copyWith({
    int? id,
    String? key,
    int? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return SpecificationModel(
      id: id ?? this.id,
      key: key ?? this.key,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'key': key,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory SpecificationModel.fromMap(Map<String, dynamic> map) {
    return SpecificationModel(
      id: map['id'] ?? 0,
      key: map['key'] ?? '',
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SpecificationModel.fromJson(String source) =>
      SpecificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      key,
      status,
      createdAt,
      updatedAt,
    ];
  }
}
