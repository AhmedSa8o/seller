import 'package:equatable/equatable.dart';

import '../controller/update_bloc/update_product_bloc.dart';

class UpdateProductModelState extends Equatable {
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
  final UpdateProductState updateState;

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
    this.updateState = const UpdateProductInitial(),
  });

  UpdateProductModelState copyWith({
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
    UpdateProductState? updateState,
  }) {
    return UpdateProductModelState(
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
      updateState: updateState ?? this.updateState,
    );
  }

  factory UpdateProductModelState.init(UpdateProductModelState storeProduct) {
    return UpdateProductModelState(
      name: storeProduct.name,
      shortName: storeProduct.shortName,
      slug: storeProduct.slug,
      thumbImage: storeProduct.thumbImage,
      category: storeProduct.category,
      subCategory: storeProduct.subCategory,
      childCategory: storeProduct.childCategory,
      brand: storeProduct.brand,
      quantity: storeProduct.quantity,
      weight: storeProduct.weight,
      shortDescription: storeProduct.shortDescription,
      longDescription: storeProduct.longDescription,
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
      updateState: const UpdateProductInitial(),
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

  UpdateProductModelState clear() {
    return const UpdateProductModelState(
      name: '',
      shortName: '',
      slug: '',
      thumbImage: '',
      category: '',
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
      isFeatured: '',
      newProduct: '',
      isTop: '',
      isBest: '',
      status: '',
      isSpecification: '',
      updateState: UpdateProductInitial(),
    );
  }

  @override
  List<Object?> get props => [
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
        updateState,
      ];
}
