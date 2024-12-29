import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../controller/upload_video/upload_video_cubit.dart';
import '../controller/video_cubit/video_cubit.dart';
import '../controller/video_cubit/video_state_model.dart';
import '../model/video_model.dart';

class VideoStatusSwitch extends StatelessWidget {
  const VideoStatusSwitch({super.key, required this.video});

  final VideoModel video;

  @override
  Widget build(BuildContext context) {
    final variantStatus = context.read<VideoCubit>();
    final uploadVideo = context.read<UploadVideoCubit>();
    String videoStatus = video.status.toString();
    print('videoStatus $videoStatus');
    return BlocListener<UploadVideoCubit, VideoStateModel>(
      listener: (_, state) {
        final stateStatus = state.videoState;
        if (stateStatus is VideoStatusUpdating) {
          log(state.toString(), name: 'VideoStatusSwitch');
        }
        if (stateStatus is VideoUpdateStateError) {
          if (stateStatus.statusCode == 503) {
            Utils.serviceUnAvailable(context, stateStatus.message);
          } else {
            Utils.errorSnackBar(context, stateStatus.message);
          }
        }
        if (stateStatus is VideoStatusUpdated) {
          Utils.showSnackBar(context, stateStatus.message);
        }
      },
      child: BlocBuilder<UploadVideoCubit, VideoStateModel>(
        builder: (context, state) {
          return Transform.scale(
            scale: 1.2,
            child: Switch(
              value: videoStatus == '0' ? false : true,
              inactiveThumbColor: redColor,
              activeColor: greenColor,
              onChanged: (bool? val) {
                if (val != null) {
                  videoStatus = videoStatus == '1' ? '0' : '1';
                  uploadVideo.updateVideoStatus(video.id.toString());
                }
              },
            ),
          );
        },
      ),
    );
  }
}
