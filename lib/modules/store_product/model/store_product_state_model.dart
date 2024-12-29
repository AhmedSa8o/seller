import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../controller/store_product_bloc/store_product_bloc.dart';

class StoreProductStateModel extends Equatable {
// SingleProductModel singleProduct;
  final String thumbImage;
  final String shortName;
  final String name;
  final String slug;
  final String category; //int to String
  final String subCategory;
  final String childCategory;
  final String brand;
  final String quantity;
  final String weight;
  final String shortDescription;
  final String longDescription;
  final String sku;
  final String seoTitle;
  final String seoDescription;
  final String price;
  final String offerPrice;
  final String tags;
  final String isFeatured;
  final String newProduct;
  final String isTop;
  final String isBest;
  final String isSpecification;
  final String status;
  final StoreProductState state;

  const StoreProductStateModel({
    this.name = '',
    this.shortName = '',
    this.slug = '',
    this.thumbImage = '',
    this.category = '1',
    this.subCategory = '',
    this.childCategory = '',
    this.brand = '',
    this.quantity = '',
    this.weight = '',
    this.shortDescription = '',
    this.longDescription = '',
    this.sku = '',
    this.seoTitle = '',
    this.seoDescription = '',
    this.price = '',
    this.offerPrice = '',
    this.tags = '',
    this.isFeatured = '0',
    this.newProduct = '0',
    this.isTop = '0',
    this.isBest = '0',
    this.status = '1',
    this.isSpecification = '0',
    this.state = const StoreProductInitial(),
  });

  StoreProductStateModel copyWith({
    int? id,
    String? name,
    String? shortName,
    String? slug,
    String? thumbImage,
    String? category,
    String? categoryId,
    String? subCategory,
    String? childCategory,
    String? brand,
    String? quantity,
    String? weight,
    int? soldQty,
    String? shortDescription,
    String? longDescription,
    String? videoLink,
    String? sku,
    String? seoTitle,
    String? seoDescription,
    String? price,
    String? offerPrice,
    String? tags,
    String? showHomepage,
    String? isUndefine,
    String? isFeatured,
    String? newProduct,
    String? isTop,
    String? isBest,
    String? status,
    String? isSpecification,
    String? approveByAdmin,
    String? createdAt,
    String? updatedAt,
    double? averageRating,
    int? totalSold,
    StoreProductState? state,
  }) {
    return StoreProductStateModel(
      name: name ?? this.name,
      shortName: shortName ?? this.shortName,
      slug: slug ?? this.slug,
      thumbImage: thumbImage ?? this.thumbImage,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      childCategory: childCategory ?? this.childCategory,
      brand: brand ?? this.brand,
      quantity: quantity ?? this.quantity,
      weight: weight ?? this.weight,
      shortDescription: shortDescription ?? this.shortDescription,
      longDescription: longDescription ?? this.longDescription,
      sku: sku ?? this.sku,
      seoTitle: seoTitle ?? this.seoTitle,
      seoDescription: seoDescription ?? this.seoDescription,
      price: price ?? this.price,
      offerPrice: offerPrice ?? this.offerPrice,
      tags: tags ?? this.tags,
      isFeatured: isFeatured ?? this.isFeatured,
      newProduct: newProduct ?? this.newProduct,
      isTop: isTop ?? this.isTop,
      isBest: isBest ?? this.isBest,
      status: status ?? this.status,
      isSpecification: isSpecification ?? this.isSpecification,
      state: state ?? this.state,
    );
  }

  factory StoreProductStateModel.init(StoreProductStateModel storeProduct) {
    return StoreProductStateModel(
      name: storeProduct.name ?? '',
      shortName: storeProduct.shortName ?? '',
      slug: storeProduct.slug ?? '',
      thumbImage: storeProduct.thumbImage ?? '',
      category: storeProduct.category ?? '1',
      subCategory: storeProduct.subCategory ?? '',
      childCategory: storeProduct.childCategory ?? '',
      brand: storeProduct.brand ?? '',
      quantity: storeProduct.quantity ?? '',
      weight: storeProduct.weight ?? '',
      shortDescription: storeProduct.shortDescription ?? '',
      longDescription: storeProduct.longDescription ?? '',
      sku: storeProduct.sku ?? '',
      seoTitle: storeProduct.seoTitle ?? '',
      seoDescription: storeProduct.seoDescription ?? '',
      price: storeProduct.price ?? '',
      offerPrice: storeProduct.offerPrice ?? '',
      tags: storeProduct.tags ?? '',
      isFeatured: storeProduct.isFeatured ?? '',
      newProduct: storeProduct.newProduct ?? '',
      isTop: storeProduct.isTop ?? '',
      isBest: storeProduct.isBest ?? '',
      status: storeProduct.status ?? '',
      isSpecification: storeProduct.isSpecification ?? '',
      state: const StoreProductInitial(),
    );
  }

  Map<String, String> toMap() {
    return <String, String>{
      'name': name,
      'short_name': shortName,
      'slug': slug,
      'thumb_image': thumbImage,
      'category': category,
      'sub_category': subCategory,
      'child_category': childCategory,
      'brand': brand,
      'quantity': quantity,
      'weight': weight,
      'short_description': shortDescription,
      'long_description': longDescription,
      'sku': sku,
      'seo_title': seoTitle,
      'seo_description': seoDescription,
      'price': price,
      'offer_price': offerPrice,
      'tags': tags,
      'is_featured': isFeatured,
      'new_product': newProduct,
      'is_top': isTop,
      'is_best': isBest,
      'status': status,
      'is_specification': isSpecification,
    };
  }

  StoreProductStateModel clear() {
    return const StoreProductStateModel(
      name: '',
      shortName: '',
      slug: '',
      thumbImage: '',
      category: '1',
      subCategory: '',
      childCategory: '',
      brand: '',
      quantity: '',
      weight: '',
      shortDescription: '',
      longDescription: '',
      sku: '',
      seoTitle: '',
      seoDescription: '',
      price: '',
      offerPrice: '',
      tags: '',
      isFeatured: '0',
      newProduct: '0',
      isTop: '0',
      isBest: '0',
      status: '',
      isSpecification: '0',
      state: StoreProductInitial(),
    );
  }

  factory StoreProductStateModel.fromMap(Map<String, dynamic> map) {
    return StoreProductStateModel(
      name: map['name'] ?? '',
      shortName: map['short_name'] ?? '',
      slug: map['slug'] ?? '',
      thumbImage: map['thumb_image'] ?? '',
      category: map['category'] ?? '1',
      subCategory: map['sub_category'] ?? '',
      childCategory: map['child_category'] ?? '',
      brand: map['brand'] ?? '',
      quantity: map['quantity'],
      weight: map['weight'] ?? '',
      shortDescription: map['short_description'] ?? '',
      longDescription: map['long_description'] ?? '',
      sku: map['sku'] ?? '',
      seoTitle: map['seo_title'] ?? '',
      seoDescription: map['seo_description'] ?? '',
      price: map['price'] ?? '',
      offerPrice: map['offer_price'] ?? '',
      tags: map['tags'] ?? '',
      isFeatured: map['is_featured'] ?? '',
      newProduct: map['new_product'] ?? '',
      isTop: map['is_top'] ?? '',
      isBest: map['is_best'] ?? '',
      status: map['status'] ?? '',
      isSpecification: map['is_specification'] ?? '',
      state: const StoreProductInitial(),
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreProductStateModel.fromJson(String source) =>
      StoreProductStateModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      thumbImage,
      shortName,
      name,
      slug,
      category,
      subCategory,
      childCategory,
      brand,
      sku,
      price,
      offerPrice,
      quantity,
      shortDescription,
      longDescription,
      tags,
      status,
      weight,
      seoTitle,
      seoDescription,
      isTop,
      newProduct,
      isBest,
      isFeatured,
      isSpecification,
      state,
      // soldQty,
      // videoLink,
      // showHomepage,
      // isUndefine,
      // approveByAdmin,
      // createdAt,
      // updatedAt,
      // averageRating,
      // totalSold,
    ];
  }
}
