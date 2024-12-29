part of 'upload_video_cubit.dart';

abstract class UploadVideoState extends Equatable {
  const UploadVideoState();
  @override
  List<Object> get props => [];
}

class UploadVideoInitial extends UploadVideoState {
  const UploadVideoInitial();
}

class VideoUploaded extends UploadVideoState {
  final String message;

  const VideoUploaded(this.message);

  @override
  List<Object> get props => [message];
}

class VideoUploading extends UploadVideoState {}

class VideoStateFormError extends UploadVideoState {
  final Errors errors;

  const VideoStateFormError(this.errors);

  @override
  List<Object> get props => [errors];
}

class VideoUploadStateError extends UploadVideoState {
  final String message;
  final int statusCode;

  const VideoUploadStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class VideoStatusUpdating extends UploadVideoState {}

class VideoUpdateStateError extends UploadVideoState {
  final String message;
  final int statusCode;

  const VideoUpdateStateError(this.message, this.statusCode);

  @override
  List<Object> get props => [message, statusCode];
}

class VideoStatusUpdated extends UploadVideoState {
  final String message;

  const VideoStatusUpdated(this.message);

  @override
  List<Object> get props => [message];
}
