import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/remote_urls.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/error_text.dart';
import '../controller/update_bloc/update_product_bloc.dart';
import '../model/update_product_model_state.dart';

class GetUpdatedImage extends StatelessWidget {
  const GetUpdatedImage({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final updateBloc = context.read<UpdateProductBloc>();
    // context.read<UpdateProductBloc>().add(UpdateProductEventImage(RemoteUrls.imageUrl(image)));
    return BlocBuilder<UpdateProductBloc, UpdateProductModelState>(
      builder: (_, state) {
        print('Imagesss: ${state.thumbImage}');
        final errorState = state.updateState;
        final captureImage = state.thumbImage.isNotEmpty
            ? state.thumbImage
            : RemoteUrls.imageUrl(image);
        return Column(
          children: [
            Container(
              height: 180.0,
              width: size.width * 0.6,
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
                      isFile: state.thumbImage.isNotEmpty,
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
                          // final image = await Utils.pickMultipleImage();
                          updateBloc.add(UpdateProductEventImage(image ?? ''));
                          print(image);
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
            ),
            if (errorState is UpdateProductFormValidate) ...[
              if (errorState.errors.thumbImage.isNotEmpty)
                ErrorText(text: errorState.errors.thumbImage.first),
            ]
          ],
        );
      },
    );
  }
}
