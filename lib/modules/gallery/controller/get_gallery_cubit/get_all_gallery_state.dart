part of 'get_all_gallery_cubit.dart';

abstract class GetAllGalleryState extends Equatable {
  const GetAllGalleryState();

  @override
  List<Object> get props => [];
}

class GetAllGalleryLoading extends GetAllGalleryState {}

class GetAllGalleryLoaded extends GetAllGalleryState {
  final GalleryModel gallery;

  const GetAllGalleryLoaded(this.gallery);

  @override
  List<Object> get props => [gallery];
}

class GetAllGalleryError extends GetAllGalleryState {
  final String message;
  final int statusCode;

  const GetAllGalleryError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class DeletedGalleryImage extends GetAllGalleryState {
  final String message;

  const DeletedGalleryImage(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
