import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/remote_urls.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../controller/update_profile/update_profile_cubit.dart';
import '../controller/update_profile/update_profile_state_model.dart';
import '../model/seller_profile_model.dart';

class ProfileImages extends StatelessWidget {
  const ProfileImages({super.key, required this.seller});
  final SellerProfileModel seller;

  @override
  Widget build(BuildContext context) {
    final updateCubit = context.read<UpdateSellerProfileCubit>();
    return BlocBuilder<UpdateSellerProfileCubit, UpdateSellerProfileStateModel>(
      buildWhen: (previous, current) => previous.image != current.image,
      builder: (context, state) {
        String profileImage = seller.user!.image.isNotEmpty
            ? RemoteUrls.imageUrl(seller.user!.image)
            : RemoteUrls.imageUrl(seller.defaultProfile!.image);

        profileImage = state.image.isNotEmpty ? state.image : profileImage;

        // final captureImage = state.image.isNotEmpty
        //     ?state.image: RemoteUrls.imageUrl(image);

        // print('userImage: ${widget.seller.user!.image}');
        //print('defaul: ${widget.seller.defaultProfile!.image}');
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color(0xff333333).withOpacity(.18),
                blurRadius: 70,
              ),
            ],
          ),
          child: Center(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CustomImage(
                    path: profileImage,
                    height: 170,
                    width: 170,
                    fit: BoxFit.cover,
                    isFile: state.image.isNotEmpty,
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: InkWell(
                    onTap: () async {
                      final imageSourcePath = await Utils.pickSingleImage();
                      updateCubit.imageChange(imageSourcePath!);
                    },
                    child: CircleAvatar(
                      backgroundColor: Utils.dynamicPrimaryColor(context),
                      child: const Icon(Icons.edit, color: blackColor),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
