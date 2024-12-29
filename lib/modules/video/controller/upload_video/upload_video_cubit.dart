import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../dependency_injection_packages.dart';
import '../../../../utils/errors_model.dart';
import '../video_cubit/video_state_model.dart';

part 'upload_video_state.dart';

class UploadVideoCubit extends Cubit<VideoStateModel> {
  final VideoRepository _repository;

  UploadVideoCubit({required VideoRepository repository})
      : _repository = repository,
        super(
          const VideoStateModel(),
        );

  void changeVideoFile(String text) {
    emit(state.copyWith(video: text, videoState: const UploadVideoInitial()));
  }

  void changeThumbImage(String text) {
    emit(state.copyWith(
        thumbImage: text, videoState: const UploadVideoInitial()));
  }

  void changeProductId(String text) {
    emit(state.copyWith(
        productId: text, videoState: const UploadVideoInitial()));
  }

  Future<void> storeVideo() async {
    emit(state.copyWith(videoState: VideoUploading()));
    print('video-body $state');
    final result = await _repository.storeVideo(state);
    result.fold((failure) {
      if (failure is InvalidAuthData) {
        emit(state.copyWith(videoState: VideoStateFormError(failure.errors)));
      } else {
        emit(state.copyWith(
            videoState:
                VideoUploadStateError(failure.message, failure.statusCode)));
      }
    }, (success) {
      final successState = VideoUploaded(success);
      emit(state.copyWith(videoState: successState));
    });
  }

  Future<void> updateVideoStatus(String productId) async {
    emit(state.copyWith(videoState: VideoStatusUpdating()));
    final result = await _repository.updateVideoStatus(productId);
    result.fold((failure) {
      emit(state.copyWith(
          videoState:
              VideoUpdateStateError(failure.message, failure.statusCode)));
    }, (success) {
      final successState = VideoStatusUpdated(success);
      emit(state.copyWith(videoState: successState));
    });
  }

  void clear() {
    emit(state.clear());
  }
}
