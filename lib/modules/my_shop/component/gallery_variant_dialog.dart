import 'package:flutter/material.dart';

import '/core/routes/routes_names.dart';
import '/utils/constants.dart';
import '/utils/k_images.dart';
import '/utils/language_string.dart';
import '/widgets/custom_image.dart';
import '../../../utils/utils.dart';
import '../../order/model/single_product_model/single_product_model.dart';

class GalleryVariantDialog extends StatelessWidget {
  const GalleryVariantDialog({super.key, required this.product});
  final SingleProductModel product;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: Utils.symmetric(v: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('More Options'),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const CustomImage(
                    path: KImages.cancel,
                    height: 15.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            _option(Language.imageGallery, KImages.galleryIcon,
                const Color.fromRGBO(255, 187, 56, 0.1), () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, RouteNames.galleryScreen,
                  arguments: product.id.toString());
            }, context),
            _option(Language.productVariant, KImages.settingIcon,
                const Color(0xFFF1F1F1), () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, RouteNames.variantScreen,
                  arguments: product.id.toString());
            }, context),
            // _option(
            //     Language.productVideo, KImages.videoIcon, const Color(0xFFF1F1F1),
            //     () {
            //   Navigator.of(context).pop();
            //   Navigator.pushNamed(context, RouteNames.videoScreen,
            //       arguments: product.id.toString());
            // }, context),
          ],
        ),
      ),
    );
  }

  Widget _option(String title, String icon, Color bgColor, VoidCallback onTap,
      BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.0,
        alignment: Alignment.center,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
            color: bgColor, borderRadius: BorderRadius.circular(4.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CustomImage(path: icon),
                const SizedBox(width: 14.0),
                Text(title),
              ],
            ),
            CircleAvatar(
              radius: 14.0,
              backgroundColor: Utils.dynamicPrimaryColor(context),
              child: const Icon(
                Icons.arrow_forward_ios,
                size: 16.0,
                color: blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
