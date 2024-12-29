import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/login/login_bloc/login_bloc.dart';
import '../../model/store_gallery_state_model.dart';
import '../../repository/gallery_repository.dart';

part 'store_gallery_event.dart';

part 'store_gallery_state.dart';

class StoreGalleryBloc extends Bloc<StoreGalleryEvent, StoreGalleryStateModel> {
  final GalleryRepository _galleryRepository;
  final LoginBloc _loginBloc;

  StoreGalleryBloc(
      {required GalleryRepository galleryRepository,
      required LoginBloc loginBloc})
      : _galleryRepository = galleryRepository,
        _loginBloc = loginBloc,
        super(const StoreGalleryStateModel(images: [])) {
    on<StoreGalleryEventImage>((event, emit) {
      final imagePath = event.image.split('/').last;
      if (!state.images.any((img) => img.split('/').last == imagePath)) {
        final updatedImg = List.of(state.images)..add(event.image);
        log('not-existing ${event.image}');
        emit(state.copyWith(images: updatedImg));
      }
    });

    on<UpdateGalleryEventImage>((event, emit) {
      final imagePath = event.image.split('/').last;

      final updatedImg = List.of(state.images);
      if (event.index >= 0 && event.index < updatedImg.length) {
        if (updatedImg[event.index] != imagePath) {
          updatedImg[event.index] = event.image;
          emit(state.copyWith(images: updatedImg));
        }
      }
    });
    on<DeleteGalleryEventImage>((event, emit) {
      final updatedImg = List.of(state.images)..removeAt(event.index);
      emit(state.copyWith(images: updatedImg));
    });

    on<StoreGalleryEventProductId>((event, emit) {
      emit(state.copyWith(productId: event.productId));
    });

    on<StoreGalleryEventSubmit>(_storeGalleryEventSubmit);
    on<StoreGalleryEventClear>(_storeGalleryEventClear);
  }

  Future<void> _storeGalleryEventSubmit(StoreGalleryEventSubmit event,
      Emitter<StoreGalleryStateModel> emit) async {
    emit(state.copyWith(galleryState: const StoreGalleryLoading()));
    final body = state;
    print('GalleryBody: $body');
    final result = await _galleryRepository.storeGalleryImages(
        body, _loginBloc.userInformation!.accessToken);
    result.fold(
      (f) {
        final errors = StoreGalleryError(f.message, f.statusCode);
        emit(state.copyWith(galleryState: errors));
      },
      (success) {
        final stored = StoreGalleryLoaded(success);
        emit(state.copyWith(galleryState: stored));
      },
    );
  }

  Future<void> _storeGalleryEventClear(StoreGalleryEventClear event,
      Emitter<StoreGalleryStateModel> emit) async {
    emit(state.clearGallery());
  }
}
