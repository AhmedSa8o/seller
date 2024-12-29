import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/modules/gallery/model/gallery_model.dart';
import '/utils/loading_widget.dart';
import '/widgets/custom_image.dart';
import '/widgets/primary_button.dart';
import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';
import '../../../utils/language_string.dart';
import '../../../utils/utils.dart';
import '../controller/get_gallery_cubit/get_all_gallery_cubit.dart';
import '../controller/store_gallery_bloc/store_gallery_bloc.dart';
import '../model/store_gallery_state_model.dart';

class UploadGalleryImageDialog extends StatefulWidget {
  const UploadGalleryImageDialog({super.key, required this.galleryModel});

  final GalleryModel galleryModel;

  @override
  State<UploadGalleryImageDialog> createState() =>
      _UploadGalleryImageDialogState();
}

class _UploadGalleryImageDialogState extends State<UploadGalleryImageDialog> {
  @override
  void initState() {
    super.initState();
    //loadProductId();
  }

  loadProductId() {
    context.read<StoreGalleryBloc>().add(
        StoreGalleryEventProductId(widget.galleryModel.product!.id.toString()));
  }

  final String _class = "UploadGalleryImageDialog";

  @override
  Widget build(BuildContext context) {
    final gBloc = context.read<StoreGalleryBloc>();
    return BlocListener<StoreGalleryBloc, StoreGalleryStateModel>(
      listener: (_, state) {
        final uploadState = state.galleryState;
        if (uploadState is StoreGalleryLoading) {
          log(uploadState.toString(), name: _class);
        } else if (uploadState is StoreGalleryError) {
          Navigator.of(context).pop();
          Utils.errorSnackBar(context, uploadState.message);
        } else if (uploadState is StoreGalleryLoaded) {
          Navigator.of(context).pop();
          context
              .read<GetAllGalleryCubit>()
              .getAllGalleryImages(widget.galleryModel.product!.id.toString());
          Utils.showSnackBar(context, uploadState.message);
          gBloc.add(StoreGalleryEventClear());
        }
      },
      child: Dialog(
        insetPadding: Utils.symmetric(h: 14.0),
        child: Container(
          width: double.infinity,
          padding: Utils.symmetric(h: 0.0, v: 20.0),
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          child: BlocBuilder<StoreGalleryBloc, StoreGalleryStateModel>(
            builder: (context, state) {
              final uploadImage = state.images.isNotEmpty;
              // // final capture = state.images;
              // print('capturedImage: ${state.images.length}');
              // List<String> imageList = [];
              // print('UploadImage: $uploadImage');
              // print('state image: ${state.images.length}');
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            if (state.images.isNotEmpty) {
                              state.images.clear();
                              print('removed images');
                            }
                          },
                          child: const CustomImage(path: KImages.cancel)),
                    ],
                  ),
                  Container(
                    height: 150.0,
                    margin: const EdgeInsets.only(top: 14.0, bottom: 6.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0XFFEBEBEB),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: state.images.isNotEmpty
                        ? GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemCount: state.images.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 100.0,
                                width: 100.0,
                                alignment: Alignment.center,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 6.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  border: Border.all(
                                      color: grayColor.withOpacity(0.5)),
                                ),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    CustomImage(
                                        path: state.images[index],
                                        height: 90.0,
                                        width: 90.0,
                                        fit: BoxFit.cover,
                                        isFile: uploadImage),
                                    Positioned(
                                        right: -6.0,
                                        top: -6.0,
                                        child: GestureDetector(
                                          onTap: () {
                                            gBloc.add(
                                                DeleteGalleryEventImage(index));
                                          },
                                          child: const CircleAvatar(
                                            backgroundColor: redColor,
                                            radius: 10.0,
                                            child: Icon(
                                              Icons.delete,
                                              size: 16.0,
                                              color: whiteColor,
                                            ),
                                          ),
                                        )),
                                    Positioned(
                                        left: -6.0,
                                        top: -6.0,
                                        child: GestureDetector(
                                          onTap: () async {
                                            final image =
                                                await Utils.pickSingleImage();
                                            if (image != null &&
                                                image.isNotEmpty) {
                                              gBloc.add(UpdateGalleryEventImage(
                                                  image, index));
                                            }
                                          },
                                          child: const CircleAvatar(
                                            backgroundColor: greenColor,
                                            radius: 10.0,
                                            child: Icon(
                                              Icons.edit,
                                              size: 16.0,
                                              color: whiteColor,
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              );
                            },
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CustomImage(path: KImages.placeHolderImage),
                              const SizedBox(width: 20.0),
                              GestureDetector(
                                onTap: () async {
                                  final images =
                                      await Utils.pickMultipleImage();
                                  for (int i = 0; i < images.length; i++) {
                                    if (images[i] != null &&
                                        images[i]!.isNotEmpty) {
                                      gBloc.add(
                                          StoreGalleryEventImage(images[i]!));
                                    }
                                  }
                                },
                                child: const Text(
                                  Language.browseImage,
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
                  const SizedBox(height: 24.0),
                  if (state.images.isNotEmpty) ...[
                    PrimaryButton(
                        text: 'Add More Image',
                        onPressed: () async {
                          final images = await Utils.pickMultipleImage();
                          for (int i = 0; i < images.length; i++) {
                            if (images[i] != null && images[i]!.isNotEmpty) {
                              gBloc.add(StoreGalleryEventImage(images[i]!));
                            }
                          }
                        }),
                  ],
                  SizedBox(height: state.images.isNotEmpty ? 10.0 : 0.0),
                  BlocBuilder<StoreGalleryBloc, StoreGalleryStateModel>(
                    builder: (context, state) {
                      final uploadState = state.galleryState;
                      final img = state.images.isNotEmpty;
                      if (uploadState is StoreGalleryLoading) {
                        return LoadingWidget();
                      }
                      return PrimaryButton(
                          text: img?  'Upload Image':'Please add images',
                          onPressed: () async{
                            if(img){
                              gBloc.add(StoreGalleryEventProductId(widget.galleryModel.product!.id.toString()));
                              gBloc.add(StoreGalleryEventSubmit());
                            }else{
                              final images = await Utils.pickMultipleImage();
                              for (int i = 0; i < images.length; i++) {
                                if (images[i] != null && images[i]!.isNotEmpty) {
                                  gBloc.add(StoreGalleryEventImage(images[i]!));
                                }
                              }
                            }

                          });
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
