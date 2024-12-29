import 'package:flutter/material.dart';

import '../../../utils/k_images.dart';
import '../../../utils/language_string.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/primary_button.dart';
import '../../variant/model/single_variant_model/single_variant_model.dart';
import 'store_variant_item_screen.dart';

class EmptyVariantItemComponent extends StatelessWidget {
  const EmptyVariantItemComponent({super.key, required this.variantItem});
  final SingleVariantModel variantItem;

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
          const CustomImage(path: KImages.emptyVariant),
          const SizedBox(height: 18.0),
          Text(
            Language.noVariantItem,
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20.0),
          ),
          const SizedBox(height: 24.0),
          PrimaryButton(
            text: Language.addVariantItem,
            onPressed: () {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) =>
                      StoreVariantItemScreen(variant: variantItem));
            },
          ),
          const SizedBox(height: 30.0),
        ],
      ),
    );
  }
}
