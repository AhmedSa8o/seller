import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/remote_urls.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../controller/update_seller_shop/update_seller_shop_cubit.dart';
import '../controller/update_seller_shop/update_seller_shop_state_model.dart';

class SellerUpdatedImage extends StatelessWidget {
  const SellerUpdatedImage({super.key,required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final updateBloc = context.read<UpdateSellerShopCubit>();
    return BlocBuilder<UpdateSellerShopCubit, UpdateSellerShopStateModel>(
      builder: (_, state) {
        print('Imagesss ${state.bannerImage}');
        final errorState = state.bannerImage;
        final captureImage = state.bannerImage.isNotEmpty
            ?state.bannerImage: RemoteUrls.imageUrl(image);
        return Container(
          height: 180.0,
          width: size.width * 0.8,
          margin: const EdgeInsets.symmetric(horizontal: 40.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: grayColor),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: CustomImage(
                  path: captureImage,
                  fit: BoxFit.cover,
                  isFile: state.bannerImage.isNotEmpty,
                ),
              ),
              Positioned(
                top: 6.0,
                right: 10.0,
                child: Container(
                  height: 30.0,
                  width: 30.0,
                  decoration: BoxDecoration(
                    color: blackColor,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: IconButton(
                    onPressed: () async {
                      final image = await Utils.pickSingleImage();
                      updateBloc.bannerImageChange(image!);
                      print('galleryImages: $image');
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: whiteColor,
                      size: 20.0,
                    ),
                    splashRadius: 20.0,
                    padding: EdgeInsets.zero,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
