import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/utils/loading_widget.dart';
import '/utils/utils.dart';
import '/widgets/error_text.dart';
import '/widgets/primary_button.dart';
import '../../../utils/k_images.dart';
import '../../../widgets/custom_image.dart';
import '../../variant/model/single_variant_model/single_variant_model.dart';
import '../controller/store_variant_items_cubit/store_variant_item_cubit.dart';
import '../model/store_variant_item_state_model.dart';

class StoreVariantItemScreen extends StatefulWidget {
  const StoreVariantItemScreen({super.key, required this.variant});
  final SingleVariantModel variant;

  @override
  State<StoreVariantItemScreen> createState() => _StoreVariantItemScreenState();
}

class _StoreVariantItemScreenState extends State<StoreVariantItemScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<StoreVICubit>()
        .productIdChange(widget.variant.productId.toString());
    context.read<StoreVICubit>().variantIdChange(widget.variant.id.toString());
    context.read<StoreVICubit>().statusChange('1');
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.variant;
    print('product_id: ${item.productId}');
    print('variant_id: ${item.id}');
    final storeCubit = context.read<StoreVICubit>();
    // storeCubit.productIdChange(productId);
    // storeCubit.variantIdChange(variantId);
    // storeCubit.statusChange('1');

    // print('name: ${state.name}');
    // print('price: ${state.price}');
    // print('PI: ${state.productId}');
    // print('VI: ${state.variantId}');
    // print('status: ${state.status}');
    return AlertDialog(
      // contentPadding: EdgeInsets.zero,
      content: BlocListener<StoreVICubit, StoreVIStateModel>(
        listener: (_, state) {
          final storeState = state.itemState;
          if (storeState is StoreVIInitial) {
            print('initial');
          } else if (storeState is StoreVIStateLoading) {
            print('loading');
          } else if (storeState is StoreVIError) {
            print('error');
            Navigator.of(context).pop();
            Utils.errorSnackBar(context, storeState.message);
          } else if (storeState is StoreVIStateStored) {
            Navigator.of(context).pop(true);
            // context
            //     .read<GetVariantItemCubit>()
            //     .getVIByVPIdAndVId(item.productId, item.id.toString());
          }
        },
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 14.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Add Variant Item'),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const CustomImage(
                    path: KImages.cancel,
                    height: 15.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14.0),
            BlocBuilder<StoreVICubit, StoreVIStateModel>(builder: (_, state) {
              final s = state.itemState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Name',
                    ),
                    onChanged: (String name) {
                      storeCubit.nameChange(name);
                      print(name);
                    },
                    initialValue: state.name,
                  ),
                  if (s is StoreVIStateFormValidate) ...[
                    if (s.errors.name.isNotEmpty)
                      ErrorText(text: s.errors.name.first)
                  ]
                ],
              );
            }),
            const SizedBox(height: 14.0),
            BlocBuilder<StoreVICubit, StoreVIStateModel>(builder: (_, state) {
              final s = state.itemState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Price',
                    ),
                    onChanged: (String price) {
                      storeCubit.priceChange(price);
                      print(price);
                    },
                    initialValue: state.price,
                    keyboardType: TextInputType.number,
                  ),
                  if (s is StoreVIStateFormValidate) ...[
                    if (s.errors.price.isNotEmpty)
                      ErrorText(text: s.errors.price.first)
                  ]
                ],
              );
            }),
            const SizedBox(height: 14.0),
            BlocBuilder<StoreVICubit, StoreVIStateModel>(
              builder: (context, state) {
                final s = state.itemState;
                if (s is StoreVIStateLoading) {
                  return LoadingWidget();
                }
                return PrimaryButton(
                  text: 'Store Items',
                  onPressed: () {
                    Utils.closeKeyBoard(context);
                    storeCubit.storeVariantItem();
                  },
                );
              },
            ),
            // const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
