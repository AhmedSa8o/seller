import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/modules/variant/model/single_variant_item_model/single_variant_item_model.dart';
import '/utils/utils.dart';
import '../../../utils/k_images.dart';
import '../../../utils/loading_widget.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/error_text.dart';
import '../../../widgets/primary_button.dart';
import '../controller/store_bloc/update_variant_item_bloc.dart';
import '../controller/store_bloc/update_variant_item_state_model.dart';

class UpdateProductVariantItemScreen extends StatefulWidget {
  const UpdateProductVariantItemScreen({super.key, required this.item});
  final SingleVariantItemModel item;

  @override
  State<UpdateProductVariantItemScreen> createState() =>
      _UpdateProductVariantItemScreenState();
}

class _UpdateProductVariantItemScreenState
    extends State<UpdateProductVariantItemScreen> {
  final _className = "_UpdateProductVariantItemScreenState";

  @override
  void initState() {
    super.initState();
    loadExistingData();
  }

  loadExistingData() {
    context
        .read<UpdateVariantItemBloc>()
        .add(UpdateVIProductIdChangeEvent(widget.item.productId.toString()));
    context.read<UpdateVariantItemBloc>().add(
        UpdateVIVariantIdChangeEvent(widget.item.productVariantId.toString()));
    context
        .read<UpdateVariantItemBloc>()
        .add(UpdateVIStatusChangeEvent(widget.item.status.toString()));
    context
        .read<UpdateVariantItemBloc>()
        .add(UpdateVINameChangeEvent(widget.item.name));
    context
        .read<UpdateVariantItemBloc>()
        .add(UpdateVIPriceChangeEvent(widget.item.price.toString()));
  }

  @override
  Widget build(BuildContext context) {
    final updateCubit = context.read<UpdateVariantItemBloc>();

    print('id: ${widget.item.id}');
    print('product_id: ${widget.item.productId}');
    print('product_variant_id: ${widget.item.productVariantId}');
    return AlertDialog(
      // contentPadding: EdgeInsets.zero,
      content: BlocListener<UpdateVariantItemBloc, UpdateVariantItemStateModel>(
        listener: (context, state) {
          final storeState = state.updateVIState;
          if (storeState is UpdateVariantItemInitial) {
            log(storeState.toString(), name: _className);
          } else if (storeState is UpdateVariantItemLoading) {
            log(storeState.toString(), name: _className);
          } else if (storeState is UpdateVariantItemError) {
            if (storeState.statusCode == 503) {
              // context.read<GetVariantItemCubit>().getVIByVPIdAndVId(
              //     widget.item.productId, widget.item.id.toString());
            } else {
              Navigator.of(context).pop();
              Utils.errorSnackBar(context, storeState.message);
            }
          } else if (storeState is UpdateVariantItemLoaded) {
            Navigator.of(context).pop(true);
            //Utils.showSnackBar(context, storeState.message);
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Update Variant Item'),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const CustomImage(
                    path: KImages.cancel,
                    height: 15.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            BlocBuilder<UpdateVariantItemBloc, UpdateVariantItemStateModel>(
                builder: (_, state) {
              final s = state.updateVIState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    onChanged: (String name) {
                      updateCubit.add(UpdateVINameChangeEvent(name));
                      print(name);
                    },
                    initialValue: widget.item.name,
                  ),
                  if (s is UpdateVariantItemFormValidate) ...[
                    if (s.errors.name.isNotEmpty)
                      ErrorText(text: s.errors.name.first)
                  ]
                ],
              );
            }),
            const SizedBox(height: 15.0),
            BlocBuilder<UpdateVariantItemBloc, UpdateVariantItemStateModel>(
                builder: (_, state) {
              final s = state.updateVIState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    onChanged: (String price) {
                      updateCubit.add(UpdateVIPriceChangeEvent(price));
                      print(price);
                    },
                    initialValue: widget.item.price.toString(),
                    keyboardType: TextInputType.number,
                  ),
                  if (s is UpdateVariantItemFormValidate) ...[
                    if (s.errors.price.isNotEmpty)
                      ErrorText(text: s.errors.price.first)
                  ]
                ],
              );
            }),
            const SizedBox(height: 15.0),
            BlocBuilder<UpdateVariantItemBloc, UpdateVariantItemStateModel>(
              builder: (context, state) {
                final s = state.updateVIState;
                if (s is UpdateVariantItemLoading) {
                  return LoadingWidget();
                }
                return PrimaryButton(
                  text: 'Update Item',
                  onPressed: () {
                    Utils.closeKeyBoard(context);
                    updateCubit
                        .add(UpdateVISubmitEvent(widget.item.id.toString()));
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
