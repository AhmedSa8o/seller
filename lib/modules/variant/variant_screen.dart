import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller_app/utils/utils.dart';

import '/modules/variant/model/product_variant-model.dart';
import '/utils/constants.dart';
import '/utils/loading_widget.dart';
import 'component/empty_variant.dart';
import 'component/variant_component.dart';
import 'controller/get_variant_cubit/variant_cubit.dart';
import 'controller/update_variant_cubit/update_variant_cubit.dart';
import 'controller/update_variant_cubit/update_variant_state_model.dart';
import 'controller/variant_status_change/variant_status_change_cubit.dart';
import 'model/variant_status_change_state_model.dart';

class VariantScreen extends StatefulWidget {
  const VariantScreen({super.key, required this.productId});
  final String productId;

  @override
  State<VariantScreen> createState() => _VariantScreenState();
}

class _VariantScreenState extends State<VariantScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<VariantProductCubit>()
        .getAllProductVariantById(widget.productId);
    context
        .read<VariantProductCubit>()
        .getAllProductVariantByVariantId(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    final variantProduct = context.read<VariantProductCubit>();
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'Variant Screen',
          style: TextStyle(color: whiteColor),
        ),
        backgroundColor: blackColor,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) =>
                        AddNewVariantDialog(productId: widget.productId));
              },
              child: const CircleAvatar(
                radius: 18.0,
                backgroundColor: blackColor,
                child: Icon(
                  Icons.add,
                  color: whiteColor,
                ),
              ),
            ),
          ),

          // IconButton(
          //   onPressed: () {
          //     showDialog<void>(
          //       context: context,
          //       barrierDismissible: false,
          //       // false = user must tap button, true = tap outside dialog
          //       builder: (BuildContext dialogContext) =>
          //           AddNewVariantDialog(productId: widget.productId),
          //     );
          //   },
          //   icon: const Icon(Icons.add),
          // )
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<VariantProductCubit, VariantState>(listener: (_, state) {
            if (state is VariantProductError) {
              if (state.statusCode == 503) {
                Utils.serviceUnAvailable(context, state.message);
              } else {
                Utils.errorSnackBar(context, state.message);
              }
            }
            // if (state is VariantProductStatusChange) {
            //   Utils.showSnackBar(context, state.message);
            // }
          }),
          BlocListener<VariantStatusChangeCubit, VariantStatusChangeStateModel>(
              listener: (_, state) {
            final stateStatus = state.statusChangeState;
            if (stateStatus is VPStatusChanged) {
              context
                  .read<VariantProductCubit>()
                  .getAllProductVariantById(widget.productId);
            }
          }),
          BlocListener<UpdateVariantCubit, UpdateVariantStateModel>(
              listener: (_, state) {
            final updateState = state.updateState;
            if (updateState is VariantProductUpdated) {
              context
                  .read<VariantProductCubit>()
                  .getAllProductVariantById(widget.productId);
            }
          }),
        ],
        child: BlocBuilder<VariantProductCubit, VariantState>(
          builder: (_, state) {
            if (state is VariantProductLoading) {
              return LoadingWidget();
            } else if (state is VariantProductError) {
              if (state.statusCode == 503) {
                // return LoadedVariantProductById(
                //     productVariant: variantProduct.productVariant!);
              } else {
                return Text(state.message);
              }
            }
            return variantProduct.productVariant != null
                ? LoadedVariantProductById(
                    productVariant: variantProduct.productVariant!)
                : const SizedBox();
          },
        ),
      ),
    );
  }
}

class LoadedVariantProductById extends StatelessWidget {
  const LoadedVariantProductById({super.key, required this.productVariant});
  final ProductVariantModel productVariant;

  @override
  Widget build(BuildContext context) {
    print('iddddd: ${productVariant.product!.id.toString()}');
    if (productVariant.variants.isNotEmpty) {
      return VariantComponent(productVariant: productVariant);
    } else {
      return EmptyVariant(productId: productVariant.product!.id.toString());
    }
  }
}
