import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/modules/variant/model/single_variant_model/single_variant_model.dart';
import '/modules/variant_items/component/active_variant_item_component.dart';
import '/modules/variant_items/controller/get_variant_item_cubit/get_variant_item_cubit.dart';
import '/utils/constants.dart';
import '/utils/loading_widget.dart';
import '/utils/utils.dart';
import '../variant/model/single_variant_item_model/single_variant_item_model.dart';
import 'component/empty_variant_item_component.dart';
import 'component/store_variant_item_screen.dart';
import 'controller/store_bloc/update_variant_item_bloc.dart';
import 'controller/store_bloc/update_variant_item_state_model.dart';
import 'controller/store_variant_items_cubit/store_variant_item_cubit.dart';
import 'model/store_variant_item_state_model.dart';

class VariantItemScreen extends StatefulWidget {
  const VariantItemScreen({super.key, required this.variant});
  final SingleVariantModel variant;

  @override
  State<VariantItemScreen> createState() => _VariantItemScreenState();
}

class _VariantItemScreenState extends State<VariantItemScreen> {
  @override
  Widget build(BuildContext context) {
    // final route =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // print(route.runtimeType);
    // final productId = route["product_id"];
    // final variantId = route["product_variant_id"].toString();
    final item = widget.variant;
    print('product_id: ${item.productId} ${item.productId.runtimeType}');
    print('product_variant_id: ${item.id} ${item.id.runtimeType}');
    context
        .read<GetVariantItemCubit>()
        .getVIByVPIdAndVId(item.productId.toString(), item.id.toString());
    final variantItemCubit = context.read<GetVariantItemCubit>();
    // context.read<GetVariantItemCubit>().getVariantItemById();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Variant Item Screen',
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
                        StoreVariantItemScreen(variant: item));
              },
              child: const CircleAvatar(
                radius: 18.0,
                backgroundColor: blackColor,
                child: Icon(Icons.add,color: whiteColor),
              ),
            ),
          ),
          // IconButton(onPressed: (){}, icon: const Icon(Icons.add))
          // IconButton(
          //     onPressed: () => Navigator.pushNamed(
          //         context, RouteNames.storeVariantItemScreen,
          //         arguments: item),
          //     icon: const Icon(Icons.add))
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<GetVariantItemCubit, GetVariantItemState>(
              listener: (_, state) {
            if (state is GetVariantItemDeleted) {
              log(state.message, name: 'VariantItemScreen');
              variantItemCubit.getVIByVPIdAndVId(
                  item.productId.toString(), item.id.toString());
              Utils.showSnackBar(context, state.message);
            }
            if (state is GetVariantItemDeletedError) {
              Utils.errorSnackBar(context, state.message);
            }
          }),
          BlocListener<StoreVICubit, StoreVIStateModel>(listener: (_, state) {
            final storeState = state.itemState;
            if (storeState is StoreVIInitial) {
              print('initial');
            } else if (storeState is StoreVIStateLoading) {
              print('loading');
            } else if (storeState is StoreVIError) {
              print('error');
            } else if (storeState is StoreVIStateUpdated) {
              context.read<GetVariantItemCubit>().getVIByVPIdAndVId(
                  item.productId.toString(), item.id.toString());
            } else if (storeState is StoreVIStateStored) {
              context.read<GetVariantItemCubit>().getVIByVPIdAndVId(
                  item.productId.toString(), item.id.toString());
            }
          }),
          BlocListener<UpdateVariantItemBloc, UpdateVariantItemStateModel>(
              listener: (_, state) {
            final updateItem = state.updateVIState;
            if (updateItem is UpdateVariantItemLoaded) {
              Utils.showSnackBar(context, updateItem.message);
              variantItemCubit.getVIByVPIdAndVId(
                  item.productId.toString(), item.id.toString());
            }
          }),
        ],
        child: BlocBuilder<GetVariantItemCubit, GetVariantItemState>(
          builder: (context, state) {
            if (state is GetVariantItemLoading1) {
              return LoadingWidget();
            } else if (state is GetVariantItemByVPIdError) {
              if (state.statusCode == 503) {
                return LoadedVariantItemList(
                  variantItem: variantItemCubit.variantItemModel!.variantItems,
                  singleVariantModel: item,
                );
              } else {
                return Center(
                  child: Text(state.message,
                      style: const TextStyle(color: redColor)),
                );
              }
            } else if (state is GetVariantItemByVPIdLoaded) {
              return LoadedVariantItemList(
                  variantItem: state.variantItemModel.variantItems,
                  singleVariantModel: item);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class LoadedVariantItemList extends StatelessWidget {
  const LoadedVariantItemList(
      {super.key, required this.variantItem, required this.singleVariantModel});
  final List<SingleVariantItemModel> variantItem;
  final SingleVariantModel singleVariantModel;

  @override
  Widget build(BuildContext context) {
    if (variantItem.isNotEmpty) {
      return ActiveVariantItemComponent(variantItem: variantItem);
    } else {
      return EmptyVariantItemComponent(variantItem: singleVariantModel);
    }
  }
}
