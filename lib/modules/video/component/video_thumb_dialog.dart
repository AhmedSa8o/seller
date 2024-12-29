import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';
import '../../../utils/language_string.dart';
import '../../../utils/loading_widget.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/error_text.dart';
import '../../../widgets/primary_button.dart';
import '../controller/upload_video/upload_video_cubit.dart';
import '../controller/video_cubit/video_cubit.dart';
import '../controller/video_cubit/video_state_model.dart';

class VideoFileImage {
  static uploadVideoFileImage(BuildContext context, String productId) {
    Utils.uploadVideoFile(context,
        child: VideoThumbImageComponent(productId: productId));
  }
}

class VideoThumbImageComponent extends StatelessWidget {
  const VideoThumbImageComponent({super.key, required this.productId});

  final String productId;

  final _class = 'VideoThumbImageComponent';

  @override
  Widget build(BuildContext context) {
    final imageUpload = context.read<UploadVideoCubit>();
    final videoCubit = context.read<VideoCubit>();
    imageUpload.changeProductId(productId);
    return BlocListener<UploadVideoCubit, VideoStateModel>(
      listener: (_, state) {
        final uploadState = state.videoState;
        if (uploadState is VideoUploading) {
          log(uploadState.toString(), name: _class);
        } else if (uploadState is VideoUploadStateError) {
          //Navigator.of(context).pop();
          Utils.errorSnackBar(context, uploadState.message);
        } else if (uploadState is VideoUploaded) {
          Navigator.of(context).pop();
          Utils.showSnackBar(context, uploadState.message);
          videoCubit.getAllVideos(imageUpload.state.productId);
          imageUpload.clear();
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12.0),
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      if (imageUpload.state.video.isNotEmpty ||
                          imageUpload.state.thumbImage.isNotEmpty) {
                        imageUpload.clear();
                      }
                    },
                    child: const CustomImage(path: KImages.cancel)),
              ],
            ),
            const SizedBox(height: 10.0),
            const UploadVideoFile(),
            const SizedBox(height: 10.0),
            const ThumbImage(),
            const SizedBox(height: 20.0),
            BlocBuilder<UploadVideoCubit, VideoStateModel>(
              builder: (context, state) {
                final uploadState = state.videoState;
                if (uploadState is VideoUploading) {
                  return LoadingWidget();
                }
                return PrimaryButton(
                    text: 'Upload', onPressed: () => imageUpload.storeVideo());
              },
            )
          ],
        ),
      ),
    );
  }
}

class UploadVideoFile extends StatelessWidget {
  const UploadVideoFile({super.key});

  @override
  Widget build(BuildContext context) {
    final videoCubit = context.read<UploadVideoCubit>();
    return BlocBuilder<UploadVideoCubit, VideoStateModel>(
      builder: (context, state) {
        final fileName = state.video.split('/').last;
        final validate = state.videoState;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 60.0,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: blackColor,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Row(
                children: [
                  OutlinedButton(
                    onPressed: () async {
                      final file = await Utils.pickSingleFile();
                      debugPrint('picked-filed $file');
                      if (file != null || file!.isNotEmpty) {
                        videoCubit.changeVideoFile(file);
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          const WidgetStatePropertyAll(Color(0xFF383838)),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                      elevation: const WidgetStatePropertyAll(0.0),
                      splashFactory: NoSplash.splashFactory,
                      shadowColor: const WidgetStatePropertyAll(transparent),
                    ),
                    child: const Text(
                      'Choose File',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                          color: whiteColor),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      fileName.isNotEmpty ? fileName : 'No File Selected',
                      style: const TextStyle(color: whiteColor),
                    ),
                  ),
                ],
              ),
            ),
            if (validate is VideoStateFormError) ...[
              if (validate.errors.video.isNotEmpty)
                ErrorText(text: validate.errors.video.first),
            ]
          ],
        );
      },
    );
  }
}

class ThumbImage extends StatelessWidget {
  const ThumbImage({super.key});

  @override
  Widget build(BuildContext context) {
    final imageUpload = context.read<UploadVideoCubit>();
    return BlocBuilder<UploadVideoCubit, VideoStateModel>(
      builder: (context, state) {
        final validate = state.videoState;
        final uploadImage = state.thumbImage.isNotEmpty;
        final capture = state.thumbImage;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150.0,
              margin: const EdgeInsets.only(top: 14.0, bottom: 6.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0XFFEBEBEB),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: uploadImage
                  ? Stack(
                      fit: StackFit.expand,
                      children: [
                        CustomImage(
                          path: capture,
                          isFile: state.thumbImage.isNotEmpty,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          right: 10.0,
                          top: 5.0,
                          child: GestureDetector(
                            onTap: () async {
                              final image = await Utils.pickSingleImage();
                              print('thumbImage from gallery $image');
                              if (image != null || image!.isNotEmpty) {
                                imageUpload.changeThumbImage(image);
                              }
                            },
                            child: CircleAvatar(
                              maxRadius: 18.0,
                              backgroundColor:
                                  Utils.dynamicPrimaryColor(context)
                                      .withOpacity(0.5),
                              child: const Icon(
                                Icons.edit,
                                size: 20.0,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomImage(path: KImages.placeHolderImage),
                        const SizedBox(width: 20.0),
                        GestureDetector(
                          onTap: () async {
                            final image = await Utils.pickSingleImage();
                            print('thumbImage from gallery $image');
                            if (image != null || image!.isNotEmpty) {
                              imageUpload.changeThumbImage(image);
                            }
                          },
                          child: const Text(
                            Language.browseThumbImage,
                            style: TextStyle(
                              color: blueColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                              decoration: TextDecoration.underline,
                              decorationColor: blueColor,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
            if (validate is VideoStateFormError) ...[
              if (validate.errors.thumbImage.isNotEmpty)
                ErrorText(text: validate.errors.thumbImage.first),
            ]
          ],
        );
      },
    );
  }
}
