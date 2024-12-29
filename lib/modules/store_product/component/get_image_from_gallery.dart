import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';
import '../../../utils/language_string.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/error_text.dart';
import '../controller/store_product_bloc/store_product_bloc.dart';
import '../model/store_product_state_model.dart';

class GetImageFromGallery extends StatelessWidget {
  const GetImageFromGallery({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<StoreProductBloc>();
    return BlocBuilder<StoreProductBloc, StoreProductStateModel>(
      buildWhen: (previous, current) =>
          previous.thumbImage != current.thumbImage,
      builder: (context, state) {
        final isImage = state.thumbImage.isNotEmpty;
        final capturedImage = state.thumbImage;
        final s = state.state;
        print('IMAGE: $capturedImage');

        return Column(
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
              child: isImage
                  ? CustomImage(
                      path: capturedImage,
                      fit: BoxFit.cover,
                      isFile: isImage,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomImage(path: KImages.placeHolderImage),
                        const SizedBox(width: 16.0),
                        GestureDetector(
                          onTap: () async {
                            final image = await Utils.pickSingleImage();
                            bloc.add(StoreProductEventImage(image ?? ''));
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
                        )
                      ],
                    ),
            ),
            if (s is StoreProductLoadFormValidate) ...[
              if (s.errors.thumbImage.isNotEmpty)
                ErrorText(text: s.errors.thumbImage.first)
            ],
            const SizedBox(height: 20.0),
          ],
        );
      },
    );
  }
}
