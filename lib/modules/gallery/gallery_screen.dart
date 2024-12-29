import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/k_images.dart';
import '../../widgets/confirm_dialog.dart';
import '/core/remote_urls.dart';
import '/modules/gallery/controller/get_gallery_cubit/get_all_gallery_cubit.dart';
import '/modules/gallery/model/gallery_model.dart';
import '/modules/gallery/model/single_gallery_model/single_gallery_model.dart';
import '/utils/constants.dart';
import '/utils/language_string.dart';
import '/utils/loading_widget.dart';
import '/widgets/custom_image.dart';
import '../../utils/utils.dart';
import 'component/upload_gallery_image_dialog.dart';
import 'controller/status_change_cubit/status_change_cubit.dart';
import 'controller/store_gallery_bloc/store_gallery_bloc.dart';
import 'model/gallery_status_change_state_model.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key, required this.id});

  final String id;
  final String _className = "GalleryScreen";

  @override
  Widget build(BuildContext context) {
    context.read<GetAllGalleryCubit>().getAllGalleryImages(id);
    final galleyCubit = context.read<GetAllGalleryCubit>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(Language.imageGallery,
            style: TextStyle(color: whiteColor)),
        backgroundColor: blackColor,
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: BlocConsumer<GetAllGalleryCubit, GetAllGalleryState>(
          listener: (_, state) {
            if (state is DeletedGalleryImage) {
              Utils.showSnackBar(context, state.message);
              // log(state.toString(), name: _className);
            }
            if (state is GetAllGalleryError) {
              Utils.errorSnackBar(context, state.message);
            }
            // else if (state is GetAllGalleryLoaded) {
            //   log(state.toString(), name: _className);
            // }
            //else if (state is GetAllGalleryError) {
            //   if (state.statusCode == 503) {
            //     Utils.serviceUnAvailable(context, state.message);
            //   } else {
            //     Utils.errorSnackBar(context, state.message);
            //   }
            // }
          },
          builder: (_, state) {
            if (state is GetAllGalleryLoading) {
              return LoadingWidget();
            } else if (state is GetAllGalleryError) {
              if (state.statusCode == 503) {
                return LoadedGallery(
                    gallery: galleyCubit.gallery!, productId: id);
              } else {
                return Center(
                    child: Text(
                  state.message,
                  style: const TextStyle(color: redColor),
                ));
              }
            } else if (state is GetAllGalleryLoaded) {
              return LoadedGallery(gallery: state.gallery, productId: id);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class LoadedGallery extends StatefulWidget {
  const LoadedGallery(
      {super.key, required this.gallery, required this.productId});

  final GalleryModel gallery;
  final String productId;

  @override
  State<LoadedGallery> createState() => _LoadedGalleryState();
}

class _LoadedGalleryState extends State<LoadedGallery> {
  @override
  Widget build(BuildContext context) {
    final statusCubit = context.read<GetAllGalleryCubit>();
    final storeGallery = context.read<StoreGalleryBloc>();
    return BlocListener<GetAllGalleryCubit, GetAllGalleryState>(
      listener: (_, state) {
        if (state is GetAllGalleryLoading) {
          log(state.toString(), name: 'GetAllGallery');
        } else if (state is DeletedGalleryImage) {
          statusCubit.getAllGalleryImages(widget.productId);
          Utils.showSnackBar(context, state.message);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: [
            Text(
              widget.gallery.product!.name,
              style: GoogleFonts.roboto(
                  fontSize: 20.0, fontWeight: FontWeight.w500),
            ),
            Container(
              height: 48.0,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 20.0),
              // color: Utils.dynamicPrimaryColor(context),
              child: ElevatedButton.icon(
                style: ButtonStyle(
                    splashFactory: NoSplash.splashFactory,
                    elevation: WidgetStateProperty.all(0.0),
                    backgroundColor: WidgetStateProperty.all(
                        Utils.dynamicPrimaryColor(context))),
                onPressed: () async {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => UploadGalleryImageDialog(
                          galleryModel: widget.gallery));
                  // final images = await Utils.pickSingleImage();
                  // storeGallery.add(StoreGalleryEventImage(images ?? ''));
                  // print(images);
                },
                icon: const Icon(
                  Icons.file_upload_outlined,
                  color: blackColor,
                ),
                label: const Text(
                  Language.uploadMoreImage,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0,
                    color: blackColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            widget.gallery.gallery.isNotEmpty
                ? Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: widget.gallery.gallery.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 0.86,
                      ),
                      itemBuilder: (context, index) {
                        final sGallery = widget.gallery.gallery[index];
                        return Container(
                          // padding: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(4.0),
                            // border: Border.all(color: grayColor),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                height: 140.0,
                                width: double.infinity,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    CustomImage(
                                      path: RemoteUrls.imageUrl(sGallery.image),
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      left: 5.0,
                                      top: 10.0,
                                      child: GestureDetector(
                                        onTap: () async {
                                          await showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (context) => ConfirmDialog(
                                              icon: KImages.deleteIcon2,
                                              message:
                                                  'Do you want to Delete\nthis Image',
                                              confirmText: 'Yes, Delete',
                                              cancelText: 'No',
                                              onTap: () async {
                                                Navigator.of(context).pop();
                                                statusCubit
                                                    .deleteSingleGalleryImage(
                                                        sGallery.id);
                                              },
                                            ),
                                          );
                                        },
                                        child: const CircleAvatar(
                                          radius: 18.0,
                                          backgroundColor: redColor,
                                          child: Icon(
                                            Icons.delete,
                                            color: whiteColor,
                                            size: 20.0,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(Language.changeStatus),
                                    StatusChangeSwitchButton(gallery: sGallery),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : Container(
                    alignment: Alignment.center,
                    child: const Text('No Image Available'),
                  ),
          ],
        ),
      ),
    );
  }
}

class StatusChangeSwitchButton extends StatelessWidget {
  const StatusChangeSwitchButton({super.key, required this.gallery});

  final SingleGalleryModel gallery;
  final _className = "StatusChangeSwitchButton";

  @override
  Widget build(BuildContext context) {
    final statusCubit = context.read<StatusChangeCubit>();
    String statusId = gallery.status.toString();
    return BlocListener<StatusChangeCubit, GalleryStatusChangeStateModel>(
      listener: (_, state) {
        final status = state.statusState;
        if (status is StatusChangeLoading) {
          log(status.toString(), name: _className);
        } else if (status is StatusChangeError) {
          Utils.errorSnackBar(context, status.message);
        } else if (status is StatusChangeLoaded) {
          Utils.showSnackBar(context, status.message);
        }
      },
      child: BlocBuilder<StatusChangeCubit, GalleryStatusChangeStateModel>(
          builder: (_, state) {
        return Transform.scale(
          scale: 0.8,
          child: Switch(
            value: statusId == '1' ? true : false,
            activeColor: Utils.dynamicPrimaryColor(context),
            onChanged: (bool? val) {
              if (val != null) {
                statusId = statusId == '0' ? '1' : '0';
                // statusCubit.changeStatus(statusId);
                statusCubit.galleryStatusChange(gallery.id);
                print(gallery.id);
              }
            },
          ),
        );
      }),
    );
  }
}
