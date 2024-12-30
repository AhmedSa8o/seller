import 'package:equatable/equatable.dart';

import '../controller/update_bloc/update_product_bloc.dart';

class UpdateProductModelState extends Equatable {
  final String thumbImage;
  final String shortName;
  final String shortNameAr;
  final String nameAr;
  final String name;
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
  final UpdateProductState updateState;
  final List<UpdateSpecification > specifications; // Add this line

  const UpdateProductModelState({
    this.name = '',
    this.shortName = '',
    this.slug = '',
    this.thumbImage = '',
    this.category = '',
    this.subCategory = '',
    this.childCategory = '',
    this.brand = '',
    this.quantity = '',
    this.weight = '',
    this.shortDescription = '',
    this.longDescription = '',
    this.shortNameAr = '',
    this.nameAr = '',
    this.shortDescriptionAr = '',
    this.longDescriptionAr = '',
    this.sku = '',
    this.seoTitle = '',
    this.seoDescription = '',
    this.price = '',
    this.offerPrice = '',
    this.tags = '',
    this.isFeatured = '',
    this.newProduct = '',
    this.isTop = '',
    this.isBest = '',
    this.status = '',
    this.isSpecification = '',
    this.specifications = const [], // Add this line with default empty list
    this.updateState = const UpdateProductInitial(),
  });

  UpdateProductModelState copyWith({
    int? id,
    String? name,
    String? nameAr,
    String? shortName,
    String? shortNameAr,
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
    String? shortDescriptionAr,
    String? longDescription,
    String? longDescriptionAr,
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
    List<UpdateSpecification >? specifications,
    String? approveByAdmin,
    String? createdAt,
    String? updatedAt,
    double? averageRating,
    int? totalSold,
    UpdateProductState? updateState,
  }) {
    return UpdateProductModelState(
      name: name ?? this.name,
      nameAr: nameAr ?? this.nameAr,
      shortName: shortName ?? this.shortName,
      shortNameAr: shortNameAr ?? this.shortNameAr,
      slug: slug ?? this.slug,
      thumbImage: thumbImage ?? this.thumbImage,
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
      status: status ?? this.status,
      isSpecification: isSpecification ?? this.isSpecification,
      specifications: specifications ?? this.specifications,
      updateState: updateState ?? this.updateState,
    );
  }

  factory UpdateProductModelState.init(UpdateProductModelState storeProduct) {
    return UpdateProductModelState(
      name: storeProduct.name,
      nameAr: storeProduct.nameAr,
      shortName: storeProduct.shortName,
      shortNameAr: storeProduct.shortNameAr,
      slug: storeProduct.slug,
      thumbImage: storeProduct.thumbImage,
      category: storeProduct.category,
      subCategory: storeProduct.subCategory,
      childCategory: storeProduct.childCategory,
      brand: storeProduct.brand,
      quantity: storeProduct.quantity,
      weight: storeProduct.weight,
      shortDescription: storeProduct.shortDescription,
      shortDescriptionAr: storeProduct.shortDescriptionAr,
      longDescription: storeProduct.longDescription,
      longDescriptionAr: storeProduct.longDescriptionAr,
      sku: storeProduct.sku,
      seoTitle: storeProduct.seoTitle,
      seoDescription: storeProduct.seoDescription,
      price: storeProduct.price,
      offerPrice: storeProduct.offerPrice,
      tags: storeProduct.tags,
      isFeatured: storeProduct.isFeatured,
      newProduct: storeProduct.newProduct,
      isTop: storeProduct.isTop,
      isBest: storeProduct.isBest,
      status: storeProduct.status,
      isSpecification: storeProduct.isSpecification,
      specifications: storeProduct.specifications,
      updateState: const UpdateProductInitial(),
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> baseMap = {
      'name': name,
      'name_ar': nameAr,
      'short_name': shortName,
      'short_name_ar': shortNameAr,
      'slug': slug,
      'thumb_image': thumbImage,
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
      final List<String> keys =
          specifications.map((spec) => spec.keyId.toString()).toList();
      final List<String> values =
          specifications.map((spec) => spec.value).toList();
      final List<String?> specificationIds = specifications
          .map((spec) => spec.specificationId?.toString())
          .toList();

      return {
        ...baseMap,
        'keys': keys,
        'specifications': values,
        'specification_ids': specificationIds,
      };
    }

    return baseMap;
  }

  UpdateProductModelState clear() {
    return const UpdateProductModelState(
      name: '',
      nameAr: '',
      shortName: '',
      shortNameAr: '',
      slug: '',
      thumbImage: '',
      category: '',
      subCategory: '',
      childCategory: '',
      brand: '',
      quantity: '',
      weight: '',
      shortDescription: '',
      shortDescriptionAr: '',
      longDescription: '',
      longDescriptionAr: '',
      sku: '',
      seoTitle: '',
      seoDescription: '',
      price: '',
      offerPrice: '',
      tags: '',
      isFeatured: '',
      newProduct: '',
      isTop: '',
      isBest: '',
      status: '',
      isSpecification: '',
      specifications: [],
      updateState: UpdateProductInitial(),
    );
  }

  @override
  List<Object?> get props => [
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
        sku,
        price,
        offerPrice,
        quantity,
        shortDescription,
        shortDescriptionAr,
        longDescription,
        longDescriptionAr,
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
        specifications,
        updateState,
      ];
}

class UpdateSpecification  {
  final int? keyId;
  final String key;
  final String value;
  final int? specificationId; // For existing specifications

  UpdateSpecification ({
    this.keyId,
    required this.key,
    required this.value,
    this.specificationId,
  });

  Map<String, dynamic> toMap() {
    return {
      'key_id': keyId,
      'key': key,
      'value': value,
      'specification_id': specificationId,
    };
  }

  factory UpdateSpecification .fromMap(Map<String, dynamic> map) {
    return UpdateSpecification (
      keyId: map['key_id'],
      key: map['key'] ?? '',
      value: map['specification'] ??
          '', // Note: backend uses 'specification' for value
      specificationId: map['id'], // Get the existing specification ID
    );
  }

  UpdateSpecification  copyWith({
    int? keyId,
    String? key,
    String? value,
    int? specificationId,
  }) {
    return UpdateSpecification (
      keyId: keyId ?? this.keyId,
      key: key ?? this.key,
      value: value ?? this.value,
      specificationId: specificationId ?? this.specificationId,
    );
  }
}
