import 'package:equatable/equatable.dart';
import 'package:seller_app/modules/store_product/controller/store_product_bloc/store_product_bloc.dart';

class StoreProductStateModel extends Equatable {
  final String thumbImage;
  final String shortName;
  final String shortNameAr;
  final String name;
  final String nameAr;
  final String slug;
  final String category;
  final String subCategory;
  final String childCategory;
  final String brand;
  final String quantity;
  final String weight;
  final String shortDescription;
  final String shortDescriptionAr;
  final String longDescription;
  final String longDescriptionAr;
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
  final List<ProductSpecification> specifications;

  const StoreProductStateModel({
    this.thumbImage = '',
    this.shortName = '',
    this.specifications = const [], // Now uses List<ProductSpecification>
    this.shortNameAr = '',
    this.name = '',
    this.nameAr = '',
    this.slug = '',
    this.category = '1',
    this.subCategory = '',
    this.childCategory = '',
    this.brand = '',
    this.quantity = '',
    this.weight = '',
    this.shortDescription = '',
    this.shortDescriptionAr = '',
    this.longDescription = '',
    this.longDescriptionAr = '',
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
    this.isSpecification = '0',
    this.status = '1',
    this.state = const StoreProductInitial(),
  });

  StoreProductStateModel copyWith({
    String? thumbImage,
    String? shortName,
    String? shortNameAr,
    String? name,
    String? nameAr,
    String? slug,
    String? category,
    String? subCategory,
    String? childCategory,
    String? brand,
    String? quantity,
    String? weight,
    String? shortDescription,
    String? shortDescriptionAr,
    String? longDescription,
    String? longDescriptionAr,
    String? sku,
    String? seoTitle,
    String? seoDescription,
    String? price,
    String? offerPrice,
    String? tags,
    String? isFeatured,
    String? newProduct,
    List<ProductSpecification>? specifications,
    String? isTop,
    String? isBest,
    String? isSpecification,
    String? status,
    StoreProductState? state,
  }) {
    return StoreProductStateModel(
      thumbImage: thumbImage ?? this.thumbImage,
      shortName: shortName ?? this.shortName,
      shortNameAr: shortNameAr ?? this.shortNameAr,
      name: name ?? this.name,
      nameAr: nameAr ?? this.nameAr,
      slug: slug ?? this.slug,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      childCategory: childCategory ?? this.childCategory,
      brand: brand ?? this.brand,
      quantity: quantity ?? this.quantity,
      weight: weight ?? this.weight,
      shortDescription: shortDescription ?? this.shortDescription,
      shortDescriptionAr: shortDescriptionAr ?? this.shortDescriptionAr,
      longDescription: longDescription ?? this.longDescription,
      longDescriptionAr: longDescriptionAr ?? this.longDescriptionAr,
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
      isSpecification: isSpecification ?? this.isSpecification,
      status: status ?? this.status,
      specifications: specifications ?? this.specifications,
      state: state ?? this.state,
    );
  }

  Map<String, dynamic> toMap() {
    final baseMap = <String, String>{
      'thumb_image': thumbImage,
      'short_name': shortName,
      'short_name_ar': shortNameAr,
      'name': name,
      'name_ar': nameAr,
      'slug': slug,
      'category': category,
      'sub_category': subCategory,
      'child_category': childCategory,
      'brand': brand,
      'quantity': quantity,
      'weight': weight,
      'short_description': shortDescription,
      'short_description_ar': shortDescriptionAr,
      'long_description': longDescription,
      'long_description_ar': longDescriptionAr,
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
    if (isSpecification == '1') {
      // Convert to the format expected by your backend
      final List<String> keys =
          specifications.map((spec) => spec.keyId.toString()).toList();
      final List<String> values =
          specifications.map((spec) => spec.value).toList();
      return {
        ...baseMap,
        'keys': keys,
        'specifications': values,
      };
    }

    return baseMap;
  }

  factory StoreProductStateModel.fromMap(Map<String, dynamic> map) {
    return StoreProductStateModel(
      thumbImage: map['thumb_image'] ?? '',
      shortName: map['short_name'] ?? '',
      shortNameAr: map['short_name_ar'] ?? '',
      name: map['name'] ?? '',
      nameAr: map['name_ar'] ?? '',
      slug: map['slug'] ?? '',
      category: map['category'] ?? '1',
      subCategory: map['sub_category'] ?? '',
      childCategory: map['child_category'] ?? '',
      brand: map['brand'] ?? '',
      quantity: map['quantity'] ?? '',
      weight: map['weight'] ?? '',
      shortDescription: map['short_description'] ?? '',
      shortDescriptionAr: map['short_description_ar'] ?? '',
      longDescription: map['long_description'] ?? '',
      longDescriptionAr: map['long_description_ar'] ?? '',
      sku: map['sku'] ?? '',
      seoTitle: map['seo_title'] ?? '',
      seoDescription: map['seo_description'] ?? '',
      price: map['price'] ?? '',
      offerPrice: map['offer_price'] ?? '',
      tags: map['tags'] ?? '',
      isFeatured: map['is_featured'] ?? '0',
      newProduct: map['new_product'] ?? '0',
      isTop: map['is_top'] ?? '0',
      isBest: map['is_best'] ?? '0',
      status: map['status'] ?? '1',
      isSpecification: map['is_specification'] ?? '0',
      specifications: map['specifications'] != null
          ? List<ProductSpecification>.from((map['specifications'] as List)
              .map((x) => ProductSpecification.fromMap(x)))
          : [],
      state: const StoreProductInitial(),
    );
  }

  StoreProductStateModel clear() {
    return const StoreProductStateModel();
  }

  @override
  List<Object> get props {
    return [
      thumbImage,
      shortName,
      shortNameAr,
      name,
      nameAr,
      slug,
      category,
      subCategory,
      childCategory,
      brand,
      quantity,
      weight,
      shortDescription,
      shortDescriptionAr,
      longDescription,
      longDescriptionAr,
      sku,
      seoTitle,
      seoDescription,
      price,
      offerPrice,
      tags,
      isFeatured,
      newProduct,
      isTop,
      isBest,
      status,
      isSpecification,
      specifications,
      state,
    ];
  }
}

class ProductSpecification {
  final int? keyId;    // Make keyId nullable
  final String key;
  final String value;

  ProductSpecification({
    this.keyId,        // Remove required since it's nullable
    required this.key,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return {
      'key_id': keyId,
      'key': key,
      'value': value,
    };
  }

  factory ProductSpecification.fromMap(Map<String, dynamic> map) {
    return ProductSpecification(
      keyId: map['key_id'],  // No need for ?? 0 since keyId is nullable
      key: map['key'] ?? '',
      value: map['value'] ?? '',
    );
  }

  ProductSpecification copyWith({
    int? keyId,
    String? key,
    String? value,
  }) {
    return ProductSpecification(
      keyId: keyId ?? this.keyId,
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }
}