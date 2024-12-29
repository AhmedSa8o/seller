import 'package:flutter/material.dart';

import '../../../utils/k_images.dart';
import '../../../utils/language_string.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/primary_button.dart';
import 'video_thumb_dialog.dart';

class EmptyVideoWidget extends StatelessWidget {
  const EmptyVideoWidget({super.key, required this.productId});
  final String productId;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      alignment: Alignment.center,
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(height: size.height / 6.0),
          const CustomImage(path: KImages.emptyVideo),
          const SizedBox(height: 18.0),
          Text(
            Language.noVideo,
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20.0),
          ),
          const SizedBox(height: 24.0),
          PrimaryButton(
            text: Language.addVideo,
            onPressed: () =>
                VideoFileImage.uploadVideoFileImage(context, productId),
            // onPressed: () {
            //   showDialog(
            //       context: context,
            //       barrierDismissible: false,
            //       builder: (context) =>
            //           StoreVariantItemScreen(variant: variantItem));
            // },
          ),
          const SizedBox(height: 30.0),
        ],
      ),
    );
  }
}
