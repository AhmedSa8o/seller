import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/video_model.dart';
import '../../repository/video_repository.dart';

part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  final VideoRepository _repository;

  VideoCubit({
    required VideoRepository repository,
  })  : _repository = repository,
        super(const VideoInitial());

  List<VideoModel> videos = [];

  Future<void> getAllVideos(String productId) async {
    emit(VideoGetAllVideoLoading());
    final result = await _repository.getAllVideos(productId);
    result.fold((failure) {
      emit(
        VideoGetAllVideoError(failure.message, failure.statusCode),
      );
    }, (success) {
      videos = success;
      final successState = VideoGetAllVideoLoaded(videos);
      emit(successState);
    });
  }

  Future<void> deleteVideo(String productId) async {
    emit(VideoDeleting());
    final result = await _repository.deleteVideo(productId);
    result.fold((failure) {
      emit(VideoDeleteStateError(failure.message, failure.statusCode));
      return false;
    }, (success) {
      videos.removeWhere((element) => element.id.toString() == productId);
      final successState = VideoDeleted(success);
      emit(successState);
      return true;
    });
  }
}
