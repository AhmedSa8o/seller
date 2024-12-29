import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/modules/gallery/model/gallery_model.dart';

import '/modules/authentication/login/login_bloc/login_bloc.dart';
import '../../model/gallery_status_change_state_model.dart';
import '../../repository/gallery_repository.dart';

part 'status_change_state.dart';

class StatusChangeCubit extends Cubit<GalleryStatusChangeStateModel> {
  final GalleryRepository _galleryRepository;
  final LoginBloc _loginBloc;

  StatusChangeCubit(
      {required GalleryRepository galleryRepository,
      required LoginBloc loginBloc})
      : _galleryRepository = galleryRepository,
        _loginBloc = loginBloc,
        super(const GalleryStatusChangeStateModel());

  GalleryModel? gallery;

  void changeStatus(String statusId) {
    emit(state.copyWith(status: statusId));
  }

  Future<void> galleryStatusChange(int id) async {
    emit(state.copyWith(statusState: const StatusChangeLoading()));
    final body = state.toMap();
    print('BODY: $body');
    final result = await _galleryRepository.galleryStatusChange(
        id, _loginBloc.userInformation!.accessToken);
    result.fold((failure) {
      emit(state.copyWith(
          statusState: StatusChangeError(failure.message, failure.statusCode)));
    }, (statusChanged) {
      emit(state.copyWith(statusState: StatusChangeLoaded(statusChanged)));
    });
  }
}
