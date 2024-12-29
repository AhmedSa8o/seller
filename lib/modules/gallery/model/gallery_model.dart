import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../order/model/single_product_model/single_product_model.dart';
import 'single_gallery_model/single_gallery_model.dart';

class GalleryModel extends Equatable {
  final SingleProductModel? product;
  final List<SingleGalleryModel> gallery;

  const GalleryModel({
    this.product,
    required this.gallery,
  });

  GalleryModel copyWith({
    SingleProductModel? product,
    List<SingleGalleryModel>? gallery,
  }) {
    return GalleryModel(
      product: product ?? this.product,
      gallery: gallery ?? this.gallery,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product?.toMap(),
      'gallery': gallery.map((x) => x.toMap()).toList(),
    };
  }

  factory GalleryModel.fromMap(Map<String, dynamic> map) {
    return GalleryModel(
      product: map['product'] != null
          ? SingleProductModel.fromMap(map['product'] as Map<String, dynamic>)
          : null,
      gallery: map['gallery'] != null
          ? List<SingleGalleryModel>.from(
              (map['gallery'] as List<dynamic>).map<SingleGalleryModel>(
                (x) => SingleGalleryModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory GalleryModel.fromJson(String source) =>
      GalleryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [product!, gallery];
}
