import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../upload_video/upload_video_cubit.dart';

class VideoStateModel extends Equatable {
  final String video;
  final String thumbImage;
  final String productId;
  final UploadVideoState videoState;

  const VideoStateModel({
    this.video = '',
    this.thumbImage = '',
    this.productId = '',
    this.videoState = const UploadVideoInitial(),
  });

  VideoStateModel copyWith({
    String? video,
    String? thumbImage,
    String? productId,
    UploadVideoState? videoState,
  }) {
    return VideoStateModel(
      video: video ?? this.video,
      thumbImage: thumbImage ?? this.thumbImage,
      productId: productId ?? this.productId,
      videoState: videoState ?? this.videoState,
    );
  }

  Map<String, String> toMap() {
    return <String, String>{
      'video': video,
      'product_id': productId,
      'thumb_image': thumbImage,
    };
  }

  factory VideoStateModel.fromMap(Map<String, dynamic> map) {
    return VideoStateModel(
      video: map['video'] ?? '',
      productId: map['product_id'] ?? '',
      thumbImage: map['thumb_image'] ?? '',
    );
  }

  VideoStateModel clear() {
    return const VideoStateModel(
        video: '', thumbImage: '', videoState: UploadVideoInitial());
  }

  String toJson() => json.encode(toMap());

  factory VideoStateModel.fromJson(String source) =>
      VideoStateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [video, thumbImage, productId, videoState];
}
