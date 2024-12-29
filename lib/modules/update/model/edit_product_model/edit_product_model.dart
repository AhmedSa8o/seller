import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../order/model/brand_model/brand_model.dart';
import '../../../order/model/category_model/category_model.dart';
import '../../../order/model/single_product_model/single_product_model.dart';

class EditProductModel extends Equatable {
  final SingleProductModel? product;
  final List<CategoryModel> categories;
  final List<BrandModel> brands;
  final List<ChildAndSubCategoryModel> subCategories;
  final List<ChildAndSubCategoryModel> childCategories;

  const EditProductModel({
    this.product,
    required this.categories,
    required this.brands,
    required this.subCategories,
    required this.childCategories,
  });

  EditProductModel copyWith({
    SingleProductModel? product,
    List<CategoryModel>? categories,
    List<BrandModel>? brands,
    List<ChildAndSubCategoryModel>? subCategories,
    List<ChildAndSubCategoryModel>? childCategories,
  }) {
    return EditProductModel(
      product: product ?? this.product,
      categories: categories ?? this.categories,
      brands: brands ?? this.brands,
      subCategories: subCategories ?? this.subCategories,
      childCategories: childCategories ?? this.childCategories,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product?.toMap(),
      'categories': categories.map((x) => x.toMap()).toList(),
      'brands': brands.map((x) => x.toMap()).toList(),
      'subCategories': subCategories.map((x) => x.toMap()).toList(),
      'childCategories': childCategories.map((x) => x.toMap()).toList(),
    };
  }

  factory EditProductModel.fromMap(Map<String, dynamic> map) {
    return EditProductModel(
      product: map['product'] != null
          ? SingleProductModel.fromMap(map['product'] as Map<String, dynamic>)
          : null,
      categories: map['categories'] != null
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
      subCategories: map['subCategories'] != null
          ? List<ChildAndSubCategoryModel>.from(
              (map['subCategories'] as List<dynamic>)
                  .map<ChildAndSubCategoryModel>(
                (x) =>
                    ChildAndSubCategoryModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      childCategories: map['childCategories'] != null
          ? List<ChildAndSubCategoryModel>.from(
              (map['childCategories'] as List<dynamic>)
                  .map<ChildAndSubCategoryModel>(
                (x) =>
                    ChildAndSubCategoryModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory EditProductModel.fromJson(String source) =>
      EditProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      product!,
      categories,
      brands,
      subCategories,
      childCategories,
    ];
  }
}

class ChildAndSubCategoryModel extends Equatable {
  // "id": 5,
  // "category_id": "1",
  // "sub_category_id": "1",
  // "name": "Samsung",
  // "slug": "samsung",
  // "status": "0",
  // "created_at": "2022-09-19T21:13:41.000000Z",
  // "updated_at": "2022-11-22T06:01:13.000000Z"
  final int id;
  final String categoryId;
  final String subCategoryId;
  final String name;
  final String slug;
  final String status;
  final String createdAt;
  final String updatedAt;

  const ChildAndSubCategoryModel({
    required this.id,
    required this.categoryId,
    required this.subCategoryId,
    required this.name,
    required this.slug,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  ChildAndSubCategoryModel copyWith({
    int? id,
    String? categoryId,
    String? subCategoryId,
    String? name,
    String? slug,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return ChildAndSubCategoryModel(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      subCategoryId: subCategoryId ?? this.subCategoryId,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'category_id': categoryId,
      'sub_category_id': subCategoryId,
      'name': name,
      'slug': slug,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory ChildAndSubCategoryModel.fromMap(Map<String, dynamic> map) {
    return ChildAndSubCategoryModel(
      id: map['id'] ?? 0,
      categoryId: map['category_id'] ?? '',
      subCategoryId: map['sub_category_id'] ?? '',
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      status: map['status'] ?? '',
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChildAndSubCategoryModel.fromJson(String source) =>
      ChildAndSubCategoryModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      categoryId,
      subCategoryId,
      name,
      slug,
      status,
      createdAt,
      updatedAt,
    ];
  }
}
