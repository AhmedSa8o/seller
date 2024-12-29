import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/constants.dart';
import '../../utils/loading_widget.dart';
import '../../utils/utils.dart';
import 'component/empty_video_widget.dart';
import 'component/video_component.dart';
import 'component/video_thumb_dialog.dart';
import 'controller/upload_video/upload_video_cubit.dart';
import 'controller/video_cubit/video_cubit.dart';
import 'model/video_model.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    print('productId $productId');
    final videoCubit = context.read<VideoCubit>();
    final uploadCubit = context.read<UploadVideoCubit>();
    uploadCubit.changeProductId(productId);
    videoCubit.getAllVideos(productId);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Video Screen',
          style: TextStyle(color: blackColor),
        ),
        backgroundColor: Utils.dynamicPrimaryColor(context),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: GestureDetector(
              onTap: () =>
                  VideoFileImage.uploadVideoFileImage(context, productId),
              child: const CircleAvatar(
                radius: 18.0,
                backgroundColor: blackColor,
                child: Icon(
                  Icons.add,
                  color: whiteColor,
                ),
              ),
            ),
          ),
        ],
      ),
      body: BlocConsumer<VideoCubit, VideoState>(
        listener: (context, state) {
          final video = state;
          if (video is VideoDeleting) {
            Utils.loadingDialog(context);
          } else {
            Utils.closeDialog(context);
            //Navigator.pop(context);
            if (video is VideoDeleteStateError) {
              Utils.errorSnackBar(context, video.message);
            } else if (video is VideoDeleted) {
              Navigator.pop(context);
              Utils.showSnackBar(context, video.message);
              videoCubit.getAllVideos(productId);
            }
          }
        },
        // listenWhen: (previous, current) {
        //   print('previous $previous');
        //   print('current $current');
        //   return previous != current;
        // },
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          final video = state;
          if (video is VideoGetAllVideoLoading) {
            return LoadingWidget();
          } else if (video is VideoGetAllVideoError) {
            if (video.statusCode == 503) {
              return LoadedVideoWidget(
                  videos: videoCubit.videos, productId: productId);
            }
            return Center(
              child: Text(
                video.message,
                style: const TextStyle(color: redColor),
              ),
            );
          } else if (video is VideoGetAllVideoLoaded) {
            return LoadedVideoWidget(
                videos: video.videos, productId: productId);
          }
          if (videoCubit.videos.isNotEmpty) {
            return LoadedVideoWidget(
                videos: videoCubit.videos, productId: productId);
          } else {
            return const Center(
                child: Text(
              'Something went wrong!',
              style: TextStyle(color: redColor),
            ));
          }
        },
      ),
    );
  }
}

class LoadedVideoWidget extends StatelessWidget {
  const LoadedVideoWidget(
      {super.key, required this.videos, required this.productId});

  final List<VideoModel> videos;
  final String productId;

  @override
  Widget build(BuildContext context) {
    if (videos.isNotEmpty) {
      return VideoComponent(videos: videos);
    } else {
      return EmptyVideoWidget(productId: productId);
    }
  }
}
