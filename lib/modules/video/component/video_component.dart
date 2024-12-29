import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/remote_urls.dart';
import '../../../utils/constants.dart';
import '../../../utils/language_string.dart';
import '../../../widgets/custom_image.dart';
import '../controller/video_cubit/video_cubit.dart';
import '../model/video_model.dart';
import 'video_status_switch.dart';

class VideoComponent extends StatelessWidget {
  const VideoComponent({super.key, required this.videos});

  final List<VideoModel> videos;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final videoCubit = context.read<VideoCubit>();
    return ListView.builder(
        itemCount: videos.length,
        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
        itemBuilder: (context, index) {
          final video = videos.reversed.toList()[index];
          return Stack(
            children: [
              VideoPlayWidget(video: video),
              Positioned(
                top: 10.0,
                right: 20.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: blackColor,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Row(
                    children: [
                      VideoStatusSwitch(video: video),
                      GestureDetector(
                        onTap: () => showDialog<void>(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext dialogContext) {
                            return AlertDialog(
                              title: const Text('Confirmation'),
                              content: const Text(Language.wantToDelete),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text(Language.cancel),
                                  onPressed: () async {
                                    Navigator.of(dialogContext).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text(Language.delete),
                                  onPressed: () async {
                                    //Navigator.of(dialogContext).pop();
                                    videoCubit.deleteVideo(video.id.toString());
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                        child: const CircleAvatar(
                          maxRadius: 18.0,
                          backgroundColor: redColor,
                          child: Icon(
                            Icons.delete,
                            color: whiteColor,
                            size: 22.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        });
  }
}

class VideoPlayWidget extends StatefulWidget {
  const VideoPlayWidget({super.key, required this.video});

  final VideoModel video;

  @override
  State<VideoPlayWidget> createState() => _VideoPlayWidgetState();
}

class _VideoPlayWidgetState extends State<VideoPlayWidget> {
  //late CustomVideoPlayerController _customVideoPlayerController;
  //late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    //initVideoController();
    super.initState();
  }

  // void initVideoController() {
  //   final videoUrl = RemoteUrls.videoUrl(widget.video.videoPath);
  //   print('videoUrl $videoUrl');
  //   _videoPlayerController = CachedVideoPlayerController.network(videoUrl)
  //     ..initialize().then((value) {
  //       setState(() {});
  //       debugPrint('initializing video');
  //     });
  //   _customVideoPlayerController = CustomVideoPlayerController(
  //     context: context,
  //     videoPlayerController: _videoPlayerController,
  //     customVideoPlayerSettings: const CustomVideoPlayerSettings(
  //       //thumbnailWidget: thumbnailWidget(),
  //       alwaysShowThumbnailOnVideoPaused: true,
  //       //placeholderWidget: thumbnailWidget(),
  //     ),
  //   );
  // }

  Widget thumbnailWidget() {
    return CustomImage(
      path: RemoteUrls.imageUrl(widget.video.videoThumbnail),
      fit: BoxFit.fitWidth,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width,
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0)
          .copyWith(top: 0.0),
      // child: CustomVideoPlayer(
      //   customVideoPlayerController: _customVideoPlayerController,
      // ),
    );
  }
}
