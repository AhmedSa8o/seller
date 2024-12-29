part of 'store_gallery_bloc.dart';

abstract class StoreGalleryEvent extends Equatable {
  const StoreGalleryEvent();

  @override
  List<Object?> get props => [];
}

class StoreGalleryEventImage extends StoreGalleryEvent {
  final String image;

  const StoreGalleryEventImage(this.image);

  @override
  List<Object?> get props => [image];
}
class UpdateGalleryEventImage extends StoreGalleryEvent {
  final String image;
  final int index;

  const UpdateGalleryEventImage(this.image,this.index);

  @override
  List<Object?> get props => [image,index];
}
class DeleteGalleryEventImage extends StoreGalleryEvent {
  final int index;

  const DeleteGalleryEventImage(this.index);

  @override
  List<Object?> get props => [index];
}

class StoreGalleryEventProductId extends StoreGalleryEvent {
  final String productId;

  const StoreGalleryEventProductId(this.productId);

  @override
  List<Object?> get props => [productId];
}

class StoreGalleryEventSubmit extends StoreGalleryEvent {
  // // final String images;
  // final String productId;
  // const StoreGalleryEventSubmit(this.productId);
  // @override
  // List<Object?> get props => [productId];
}
class StoreGalleryEventClear extends StoreGalleryEvent {}
