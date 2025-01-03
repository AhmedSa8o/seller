import 'dart:convert';
import 'package:equatable/equatable.dart';
import '../../../dashboard/model/seller_model/seller_model.dart';
import '../brand_model/brand_model.dart';
import '../category_model/category_model.dart';

class SingleProductModel extends Equatable {
  final int id;
  final String name;
  final String nameAr;
  final String shortName;
  final String shortNameAr;
  final String slug;
  final String thumbImage;
  final int vendorId;
  final int categoryId;
  final int subCategoryId;
  final int childCategoryId;
  final int brandId;
  final int qty;
  final String weight;
  final int soldQty;
  final String shortDescription;
  final String shortDescriptionAr;
  final String longDescription;
  final List<ProductSpecification>? productSpecifications;
  final String longDescriptionAr;
  final String videoLink;
  final String sku;
  final String seoTitle;
  final String seoDescription;
  final double price;
  final double offerPrice;
  final String tags;
  final int showHomepage;
  final int isUndefine;
  final int isFeatured;
  final int newProduct;
  final int isTop;
  final int isBest;
  final int status;
  final int isSpecification;
  final int approveByAdmin;
  final String createdAt;
  final String updatedAt;
  final double averageRating;
  final int totalSold;
  final CategoryModel? category;
  final SellerModel? seller;
  final BrandModel? brand;
  final List<ProductSpecification>? specifications;

  const SingleProductModel({
    required this.id,
    required this.name,
    this.nameAr = '',
    required this.shortName,
    this.shortNameAr = '',
    required this.slug,
    required this.thumbImage,
    required this.vendorId,
    required this.categoryId,
    this.productSpecifications, // Changed from specifications
    required this.subCategoryId,
    required this.childCategoryId,
    required this.brandId,
    required this.qty,
    required this.weight,
    required this.soldQty,
    required this.shortDescription,
    this.shortDescriptionAr = '',
    required this.longDescription,
    this.longDescriptionAr = '',
    required this.videoLink,
    required this.sku,
    required this.seoTitle,
    required this.seoDescription,
    required this.price,
    required this.offerPrice,
    required this.tags,
    required this.showHomepage,
    required this.isUndefine,
    required this.isFeatured,
    required this.newProduct,
    required this.isTop,
    required this.isBest,
    required this.status,
    required this.isSpecification,
    required this.approveByAdmin,
    required this.createdAt,
    required this.updatedAt,
    required this.averageRating,
    required this.totalSold,
    required this.category,
    required this.seller,
    required this.brand,
    this.specifications,
  });

  SingleProductModel copyWith({
    int? id,
    String? name,
    String? nameAr,
    String? shortName,
    String? shortNameAr,
    String? slug,
    String? thumbImage,
    int? vendorId,
    int? categoryId,
    int? subCategoryId,
    int? childCategoryId,
    int? brandId,
    int? qty,
    String? weight,
    List<ProductSpecification>? productSpecifications, // Changed parameter name

    int? soldQty,
    String? shortDescription,
    String? shortDescriptionAr,
    String? longDescription,
    String? longDescriptionAr,
    String? videoLink,
    String? sku,
    String? seoTitle,
    String? seoDescription,
    double? price,
    double? offerPrice,
    String? tags,
    int? showHomepage,
    int? isUndefine,
    int? isFeatured,
    int? newProduct,
    int? isTop,
    int? isBest,
    int? status,
    int? isSpecification,
    int? approveByAdmin,
    String? createdAt,
    String? updatedAt,
    double? averageRating,
    int? totalSold,
    CategoryModel? category,
    SellerModel? seller,
    BrandModel? brand,
    List<ProductSpecification>? specifications,
  }) {
    return SingleProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      nameAr: nameAr ?? this.nameAr,
      productSpecifications:
          productSpecifications ?? this.productSpecifications, // Updated name

      shortName: shortName ?? this.shortName,
      shortNameAr: shortNameAr ?? this.shortNameAr,
      slug: slug ?? this.slug,
      thumbImage: thumbImage ?? this.thumbImage,
      vendorId: vendorId ?? this.vendorId,
      categoryId: categoryId ?? this.categoryId,
      subCategoryId: subCategoryId ?? this.subCategoryId,
      childCategoryId: childCategoryId ?? this.childCategoryId,
      brandId: brandId ?? this.brandId,
      qty: qty ?? this.qty,
      weight: weight ?? this.weight,
      soldQty: soldQty ?? this.soldQty,
      shortDescription: shortDescription ?? this.shortDescription,
      shortDescriptionAr: shortDescriptionAr ?? this.shortDescriptionAr,
      longDescription: longDescription ?? this.longDescription,
      longDescriptionAr: longDescriptionAr ?? this.longDescriptionAr,
      videoLink: videoLink ?? this.videoLink,
      sku: sku ?? this.sku,
      seoTitle: seoTitle ?? this.seoTitle,
      seoDescription: seoDescription ?? this.seoDescription,
      price: price ?? this.price,
      offerPrice: offerPrice ?? this.offerPrice,
      tags: tags ?? this.tags,
      showHomepage: showHomepage ?? this.showHomepage,
      isUndefine: isUndefine ?? this.isUndefine,
      isFeatured: isFeatured ?? this.isFeatured,
      newProduct: newProduct ?? this.newProduct,
      isTop: isTop ?? this.isTop,
      isBest: isBest ?? this.isBest,
      status: status ?? this.status,
      isSpecification: isSpecification ?? this.isSpecification,
      approveByAdmin: approveByAdmin ?? this.approveByAdmin,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      averageRating: averageRating ?? this.averageRating,
      totalSold: totalSold ?? this.totalSold,
      category: category ?? this.category,
      seller: seller ?? this.seller,
      brand: brand ?? this.brand,
      specifications: specifications ?? this.specifications,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'name_ar': nameAr,
      'short_name': shortName,
      'short_name_ar': shortNameAr,
      'slug': slug,
      'thumb_image': thumbImage,
      'vendor_id': vendorId,
      'category_id': categoryId,
      'sub_category_id': subCategoryId,
      'child_category_id': childCategoryId,
      'brand_id': brandId,
      'qty': qty,
      'weight': weight,
      'sold_qty': soldQty,
      'short_description': shortDescription,
      'short_description_ar': shortDescriptionAr,
      'long_description': longDescription,
      'long_description_ar': longDescriptionAr,
      'specifications': productSpecifications
          ?.map((x) => x.toMap())
          .toList(), // Keep API name as 'specifications'

      'video_link': videoLink,
      'sku': sku,
      'seo_title': seoTitle,
      'seo_description': seoDescription,
      'price': price,
      'offer_price': offerPrice,
      'tags': tags,
      'show_homepage': showHomepage,
      'is_undefine': isUndefine,
      'is_featured': isFeatured,
      'new_product': newProduct,
      'is_top': isTop,
      'is_best': isBest,
      'status': status,
      'is_specification': isSpecification,
      'approve_by_admin': approveByAdmin,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'averageRating': averageRating,
      'totalSold': totalSold,
      'category': category?.toMap(),
      'seller': seller?.toMap(),
      'brand': brand?.toMap(),
      'specifications': specifications?.map((x) => x.toMap()).toList(),
    };
  }

  factory SingleProductModel.fromMap(Map<String, dynamic> map) {
    return SingleProductModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      nameAr: map['name_ar'] ?? '',
      shortName: map['short_name'] ?? '',
      shortNameAr: map['short_name_ar'] ?? '',
      slug: map['slug'] ?? '',
      thumbImage: map['thumb_image'] ?? '',
      vendorId:
          map['vendor_id'] != null ? int.parse(map['vendor_id'].toString()) : 0,
      categoryId: map['category_id'] != null
          ? int.parse(map['category_id'].toString())
          : 0,
      subCategoryId: map['sub_category_id'] != null
          ? int.parse(map['sub_category_id'].toString())
          : 0,
      childCategoryId: map['child_category_id'] != null
          ? int.parse(map['child_category_id'].toString())
          : 0,
      brandId:
          map['brand_id'] != null ? int.parse(map['brand_id'].toString()) : 0,
      qty: map['qty'] != null ? int.parse(map['qty'].toString()) : 0,
      weight: map['weight'] ?? '',
      soldQty:
          map['sold_qty'] != null ? int.parse(map['sold_qty'].toString()) : 0,
      shortDescription: map['short_description'] ?? '',
      shortDescriptionAr: map['short_description_ar'] ?? '',
      longDescription: map['long_description'] ?? '',
      longDescriptionAr: map['long_description_ar'] ?? '',
      videoLink: map['video_link'] ?? '',
      sku: map['sku'] ?? '',
      seoTitle: map['seo_title'] ?? '',
      seoDescription: map['seo_description'] ?? '',
      price: map['price'] != null ? double.parse(map['price'].toString()) : 0.0,
      offerPrice: map['offer_price'] != null
          ? double.parse(map['offer_price'].toString())
          : 0.0,
      tags: map['tags'] ?? '',
      showHomepage: map['show_homepage'] != null
          ? int.parse(map['show_homepage'].toString())
          : 0,
      isUndefine: map['is_undefine'] != null
          ? int.parse(map['is_undefine'].toString())
          : 0,
      isFeatured: map['is_featured'] != null
          ? int.parse(map['is_featured'].toString())
          : 0,
      newProduct: map['new_product'] != null
          ? int.parse(map['new_product'].toString())
          : 0,
      isTop: map['is_top'] != null ? int.parse(map['is_top'].toString()) : 0,
      isBest: map['is_best'] != null ? int.parse(map['is_best'].toString()) : 0,
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      isSpecification: map['is_specification'] != null
          ? int.parse(map['is_specification'].toString())
          : 0,
      approveByAdmin: map['approve_by_admin'] != null
          ? int.parse(map['approve_by_admin'].toString())
          : 0,
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
      averageRating: map['averageRating'] != null
          ? double.parse(map['averageRating'].toString())
          : 0.0,
      totalSold:
          map['totalSold'] != null ? int.parse(map['totalSold'].toString()) : 0,
      category: map['category'] != null
          ? CategoryModel.fromMap(map['category'])
          : null,
      seller: map['seller'] != null ? SellerModel.fromMap(map['seller']) : null,
      brand: map['brand'] != null ? BrandModel.fromMap(map['brand']) : null,
      specifications: map['specifications'] != null
          ? List<ProductSpecification>.from((map['specifications'] as List)
              .map((x) => ProductSpecification.fromMap(x)))
          : null,
      productSpecifications: map['specifications'] != null
          ? List<ProductSpecification>.from((map['specifications'] as List)
              .map((x) => ProductSpecification.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SingleProductModel.fromJson(String source) =>
      SingleProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      nameAr,
      shortName,
      shortNameAr,
      slug,
      thumbImage,
      vendorId,
      categoryId,
      subCategoryId,
      childCategoryId,
      brandId,
      qty,
      weight,
      soldQty,
      shortDescription,
      shortDescriptionAr,
      longDescription,
      longDescriptionAr,
      videoLink,
      sku,
      seoTitle,
      seoDescription,
      price,
      offerPrice,
      tags,
      showHomepage,
      isUndefine,
      isFeatured,
      newProduct,
      isTop,
      if (productSpecifications != null) ...productSpecifications!,
      isBest,
      status,
      isSpecification,
      approveByAdmin,
      createdAt,
      updatedAt,
      averageRating,
      totalSold,
      if (category != null) category!,
      if (seller != null) seller!,
      if (brand != null) brand!,
      if (specifications != null) ...specifications!,
    ];
  }
}

class ProductSpecification {
  final int? id;
  final int? keyId;
  final String key;
  final String value;

  ProductSpecification({
    this.id,
    this.keyId,
    required this.key,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'key_id': keyId,
      'key': key,
      'specification': value,
    };
  }

  factory ProductSpecification.fromMap(Map<String, dynamic> map) {
    return ProductSpecification(
      id: map['id']?.toInt(),
      keyId: map['product_specification_key_id']?.toInt(),
      key: map['key'] ?? '',
      value: map['specification'] ?? '',
    );
  }
}
