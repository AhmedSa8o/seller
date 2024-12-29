import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../authentication/login/login_bloc/login_bloc.dart';
import '../../repository/gallery_repository.dart';
import '/modules/gallery/model/gallery_model.dart';

part 'get_all_gallery_state.dart';

class GetAllGalleryCubit extends Cubit<GetAllGalleryState> {
  final GalleryRepository _galleryRepository;
  final LoginBloc _loginBloc;

  GetAllGalleryCubit(
      {required GalleryRepository galleryRepository,
      required LoginBloc loginBloc})
      : _galleryRepository = galleryRepository,
        _loginBloc = loginBloc,
        super(GetAllGalleryLoading());

  GalleryModel? gallery;
  String? productId;

  Future<void> getAllGalleryImages(String id) async {
    emit(GetAllGalleryLoading());
    final result = await _galleryRepository.getAllGalleryImages(
        id, _loginBloc.userInformation!.accessToken);
    result.fold((failure) {
      emit(GetAllGalleryError(failure.message, failure.statusCode));
    }, (success) {
      gallery = success;
      emit(GetAllGalleryLoaded(success));
    });
  }

  Future<void> deleteSingleGalleryImage(int id) async {
    emit(GetAllGalleryLoading());
    final result = await _galleryRepository.deleteSingleGalleryImage(
        id, _loginBloc.userInformation!.accessToken);
    result.fold((failure) {
      emit(GetAllGalleryError(failure.message, failure.statusCode));
      return false;
    }, (deleted) {
      gallery!.gallery.removeWhere((element) => element.id == id);
      // final delete = DeletedGalleryImage(deleted);
      emit(DeletedGalleryImage(deleted));
      getAllGalleryImages(gallery!.product!.id.toString());
      return true;
    });
  }
}
