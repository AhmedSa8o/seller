part of 'video_cubit.dart';

abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object> get props => [];
}

class VideoInitial extends VideoState {
  const VideoInitial();
}

class VideoDeleting extends VideoState {}

class VideoGetAllVideoLoading extends VideoState {}

class VideoGetAllVideoLoaded extends VideoState {
  const VideoGetAllVideoLoaded(this.videos);

  final List<VideoModel> videos;

  @override
  List<Object> get props => [videos];
}

class VideoDeleteStateError extends VideoState {
  final String message;
  final int statusCode;

  const VideoDeleteStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class VideoGetAllVideoError extends VideoState {
  final String message;
  final int statusCode;

  const VideoGetAllVideoError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class VideoDeleted extends VideoState {
  final String message;

  const VideoDeleted(this.message);

  @override
  List<Object> get props => [message];
}
