import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '/modules/variant_items/controller/get_variant_item_cubit/get_variant_item_cubit.dart';
import '/utils/language_string.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../variant/model/single_variant_item_model/single_variant_item_model.dart';
import '../controller/store_variant_items_cubit/store_variant_item_cubit.dart';
import '../model/store_variant_item_state_model.dart';
import 'update_product_variant_item.dart';

class ActiveVariantItemComponent extends StatelessWidget {
  const ActiveVariantItemComponent({super.key, required this.variantItem});
  final List<SingleVariantItemModel> variantItem;

  @override
  Widget build(BuildContext context) {
    final variantCubit = context.read<GetVariantItemCubit>();
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      // padding: const EdgeInsets.symmetric(horizontal: 20.0),
      itemCount: variantItem.length,
      itemBuilder: (context, index) {
        final item = variantItem[index];
        return Container(
          height: 170.0,
          alignment: Alignment.center,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: grayColor.withOpacity(0.3)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 65.0,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                margin:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: Utils.dynamicPrimaryColor(context).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.name,
                      style: GoogleFonts.inter(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                    VariantItemStatusChangeSwitch(itemModel: item),
                    //VariantItemStatusChangeSwitch(id: item.productId,status: item.status),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      Utils.formatAmount(context, item.price),
                      style: GoogleFonts.inter(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 16.0),
                    SizedBox(
                      width: 90.0,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Navigator.pushNamed(
                          //     context, RouteNames.updateProductVariantItemScreen,
                          //     arguments: {
                          //       "id": item.id,
                          //       "product_id": item.productId,
                          //       "product_variant_id": item.productVariantId,
                          //     });

                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) =>
                                  UpdateProductVariantItemScreen(item: item));

                          // Navigator.pushNamed(context,
                          //     RouteNames.updateProductVariantItemScreen,
                          //     arguments: item);
                        },
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all(EdgeInsets.zero),
                          shadowColor:
                              WidgetStateProperty.all(Colors.transparent),
                          splashFactory: NoSplash.splashFactory,
                          backgroundColor: WidgetStateProperty.all(
                              Utils.dynamicPrimaryColor(context)),
                          shape: WidgetStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero),
                          ),
                        ),
                        icon: const Icon(
                          Icons.edit,
                          color: blackColor,
                          size: 20.0,
                        ),
                        label: Text(
                          'Edit',
                          style: GoogleFonts.inter(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: blackColor),
                        ),
                      ),
                    ),

                    /* SizedBox(
                      width: 90.0,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RouteNames.storeVariantItemScreen,
                              arguments: {
                                "product_id": item.productId,
                                "product_variant_id": item.productVariantId,
                              });
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          backgroundColor:
                          MaterialStateProperty.all(Utils.dynamicPrimaryColor(context)),
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero),
                          ),
                        ),
                        icon: const Icon(Icons.add),
                        label: const Text('Add'),
                      ),
                    ),*/
                    const Spacer(),
                    GestureDetector(
                      onTap: () => showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        // false = user must tap button, true = tap outside dialog
                        builder: (BuildContext dialogContext) {
                          return AlertDialog(
                            title: Text(item.name),
                            content: const Text(Language.wantToDelete),
                            actions: <Widget>[
                              TextButton(
                                child: const Text(Language.cancel),
                                onPressed: () {
                                  Navigator.of(dialogContext)
                                      .pop(); // Dismiss alert dialog
                                },
                              ),
                              TextButton(
                                child: const Text(Language.delete),
                                onPressed: () {
                                  Navigator.of(dialogContext).pop();
                                  variantCubit.deleteVariantItemById(
                                      item.id.toString());
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      child: const CircleAvatar(
                        radius: 18.0,
                        backgroundColor: redColor,
                        child: Icon(Icons.delete_rounded,
                            size: 20.0, color: whiteColor),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class VariantItemStatusChangeSwitch extends StatelessWidget {
  const VariantItemStatusChangeSwitch({super.key, required this.itemModel});
  final SingleVariantItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<StoreVICubit>();
    String status = itemModel.status.toString();
    print('id: ${itemModel.id}');
    print('Status: $status');
    return BlocListener<StoreVICubit, StoreVIStateModel>(
      // listenWhen: (previous,current) => previous.status != current.status,
      listener: (context, state) {
        final s = state.itemState;
        print("sssss: $s");
        if (s is StoreVIStateLoading) {
          log(s.toString(), name: 'VariantItemStatusChangeSwitch');
        }
        if (s is StoreVIError) {
          log(s.toString(), name: 'VariantItemStatusChangeSwitch');
          Utils.errorSnackBar(context, s.message);
        }
        if (s is StoreVIStateStatusChanged) {
          log(s.toString(), name: 'VariantItemStatusChangeSwitch');
          Utils.showSnackBar(context, s.message);
        }
      },
      child: BlocBuilder<StoreVICubit, StoreVIStateModel>(
        // buildWhen: (previous,current){
        //   print('PreviousState: ${previous.status}');
        //   print('CurrentState: ${current.status}');
        //   return previous.status != current.status;
        // },
        builder: (context, state) {
          return Switch(
            activeColor: Utils.dynamicPrimaryColor(context),
            value: status == '1' ? true : false,
            onChanged: (bool? val) {
              if (val != null) {
                status = status == '0' ? '1' : '0';
                // cubit.statusChange(status);
                cubit.updateVIStatus(itemModel.id.toString());
              }
            },
          );
        },
      ),
    );
  }
}
