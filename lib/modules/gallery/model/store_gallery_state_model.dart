import 'package:equatable/equatable.dart';

import '../controller/store_gallery_bloc/store_gallery_bloc.dart';

class StoreGalleryStateModel extends Equatable {
  final List<String> images;
  final String productId;
  final StoreGalleryState galleryState;
  const StoreGalleryStateModel({
    required this.images,
    this.productId = '',
    this.galleryState = const StoreGalleryInitial(),
  });

  StoreGalleryStateModel copyWith({
    List<String>? images,
    String? productId,
    StoreGalleryState? galleryState,
  }) {
    return StoreGalleryStateModel(
      images: images ?? this.images,
      productId: productId ?? this.productId,
      galleryState: galleryState ?? this.galleryState,
    );
  }

  Map<String, String> toMap() {
    return <String, String>{
      'images': images.map((e) => e.toString()).toString(),

      ///changed....
      // 'images': images.map((x) => x.toMap()).toList(),
      'product_id': productId,
    };
  }

  StoreGalleryStateModel clearGallery() {
    return const StoreGalleryStateModel(
      images: [],
      productId: '',
      galleryState: StoreGalleryInitial(),
    );
  }

  @override
  List<Object> get props => [images, productId, galleryState];
}
