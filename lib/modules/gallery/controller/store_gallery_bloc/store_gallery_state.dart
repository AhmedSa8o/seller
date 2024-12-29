part of 'store_gallery_bloc.dart';

abstract class StoreGalleryState extends Equatable {
  const StoreGalleryState();

  @override
  List<Object> get props => [];
}

class StoreGalleryInitial extends StoreGalleryState {
  const StoreGalleryInitial();
}

class StoreGalleryLoading extends StoreGalleryState {
  const StoreGalleryLoading();
}

class StoreGalleryLoaded extends StoreGalleryState {
  final String message;

  const StoreGalleryLoaded(this.message);

  @override
  List<Object> get props => [message];
}

class StoreGalleryError extends StoreGalleryState {
  final String message;
  final int statusCode;

  const StoreGalleryError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}
