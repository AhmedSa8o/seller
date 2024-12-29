import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/dummy_data/dummy_data.dart';
import '../../../core/routes/routes_names.dart';
import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';
import '../../../utils/language_string.dart';
import '../../../utils/loading_widget.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/error_text.dart';
import '../../../widgets/primary_button.dart';
import '../../my_shop/component/single_product_card.dart';
import '../controller/get_variant_cubit/variant_cubit.dart';
import '../controller/update_variant_cubit/update_variant_cubit.dart';
import '../controller/update_variant_cubit/update_variant_state_model.dart';
import '../controller/variant_status_change/variant_status_change_cubit.dart';
import '../model/product_variant-model.dart';
import '../model/single_variant_model/single_variant_model.dart';
import '../model/variant_status_change_state_model.dart';

class VariantComponent extends StatelessWidget {
  const VariantComponent({super.key, required this.productVariant});
  final ProductVariantModel productVariant;

  @override
  Widget build(BuildContext context) {
    final variantCubit = context.read<VariantProductCubit>();
    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Text(
            productVariant.product!.name,
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 24.0),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: productVariant.variants.length,
          itemBuilder: (context, index) {
            final result = productVariant.variants[index];
            return Container(
              height: 170.0,
              alignment: Alignment.center,
              width: double.infinity,
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: grayColor.withOpacity(0.3)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 65.0,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color:
                          Utils.dynamicPrimaryColor(context).withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          result.name,
                          style: GoogleFonts.inter(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: blackColor),
                        ),
                        //BlocBuilder<VariantProductCubit, VariantState>(builder: (_,state)=> VariantStatusChangeSwitch(variant: result)),
                        VariantStatusChangeSwitch(variant: result),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        EditButton(
                          title: 'Option',
                          icon: Icons.settings,
                          onTap: () => Navigator.pushNamed(
                              context, RouteNames.variantItemScreen,
                              arguments: result),

                          // onTap: () => Navigator.pushNamed(
                          //     context, RouteNames.variantItemScreen,
                          //     arguments: {
                          //       "product_id": result.productId,
                          //       "product_variant_id": result.id,
                          //     }),
                          iconTextColor: whiteColor,
                          bgColor: blackColor,
                        ),
                        const SizedBox(width: 10.0),
                        EditButton(
                            title: 'Edit',
                            icon: Icons.edit,
                            onTap: () => showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) =>
                                    UpdateVariantDialog(variant: result)),
                            iconTextColor: blackColor),
                        const SizedBox(width: 10.0),
                        GestureDetector(
                          onTap: () => showDialog<void>(
                            context: context,
                            barrierDismissible: true,
                            // false = user must tap button, true = tap outside dialog
                            builder: (BuildContext dialogContext) {
                              return AlertDialog(
                                title: const Text('Confirmation'),
                                content: const Text(Language.wantToDelete),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text(Language.cancel),
                                    onPressed: () async {
                                      Navigator.of(dialogContext).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text(Language.delete),
                                    onPressed: () async {
                                      Navigator.of(dialogContext).pop();
                                      variantCubit.deleteProductVariant(
                                          result.id.toString());
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class VariantStatusChangeSwitch extends StatelessWidget {
  const VariantStatusChangeSwitch({super.key, required this.variant});
  final SingleVariantModel variant;

  @override
  Widget build(BuildContext context) {
    final variantStatus = context.read<VariantStatusChangeCubit>();
    //print(variant.id);
    String status = variant.status.toString();
    //print(status);
    return BlocListener<VariantStatusChangeCubit,
        VariantStatusChangeStateModel>(
      listener: (_, state) {
        final stateStatus = state.statusChangeState;
        if (stateStatus is VPStatusChangeLoading) {
          log(state.toString(), name: 'VariantStatusChangeSwitch');
        }
        if (stateStatus is VPStatusChangeError) {
          if (stateStatus.statusCode == 503) {
            Utils.serviceUnAvailable(context, stateStatus.message);
          } else {
            Utils.errorSnackBar(context, stateStatus.message);
          }
        }
        if (stateStatus is VPStatusChanged) {
          Utils.showSnackBar(context, stateStatus.message);
        }
      },
      child:
          BlocBuilder<VariantStatusChangeCubit, VariantStatusChangeStateModel>(
        builder: (_, state) {
          return Transform.scale(
            scale: 1.2,
            child: Switch(
              value: status == '1' ? true : false,
              inactiveThumbColor: redColor,
              activeColor: Utils.dynamicPrimaryColor(context),
              onChanged: (bool? val) {
                if (val != null) {
                  status = status == '0' ? '1' : '0';
                  variantStatus
                      .variantProductStatusChange(variant.id.toString());
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class UpdateVariantDialog extends StatefulWidget {
  const UpdateVariantDialog({super.key, required this.variant});
  final SingleVariantModel variant;

  @override
  State<UpdateVariantDialog> createState() => _UpdateVariantDialogState();
}

class _UpdateVariantDialogState extends State<UpdateVariantDialog> {
  late List<ProductStatusModel> status;
  late String statusValue;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    status = productStatusModel;
    //statusValue =  context.read<UpdateVariantCubit>().statusUpdate(widget.variant.status);
    statusValue = widget.variant.status.toString();
    context.read<UpdateVariantCubit>().nameUpdate(widget.variant.name);

    context
        .read<UpdateVariantCubit>()
        .productIdUpdate(widget.variant.productId.toString());
    context
        .read<UpdateVariantCubit>()
        .statusUpdate(widget.variant.status.toString());
  }

  final _className = "UpdateVariantDialog";

  @override
  Widget build(BuildContext context) {
    print('variantId: ${widget.variant.id}');
    final updateVariantCubit = context.read<UpdateVariantCubit>();
    return AlertDialog(
      content: BlocListener<UpdateVariantCubit, UpdateVariantStateModel>(
        listener: (context, state) {
          final update = state.updateState;
          if (update is UpdateVariantLoading) {
            log(update.toString(), name: _className);
          } else if (update is UpdateVariantError) {
            Navigator.of(context).pop();
            Utils.errorSnackBar(context, update.message);
          } else if (update is VariantProductUpdated) {
            Navigator.of(context).pop(true);
            Utils.showSnackBar(context, update.message);
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(Language.updateVariantProduct),
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
            BlocBuilder<UpdateVariantCubit, UpdateVariantStateModel>(
                builder: (_, state) {
              print(state.name);
              print(state.productId);
              print(state.status);
              final validate = state.updateState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    initialValue: state.name,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(hintText: 'Name'),
                    onChanged: (String name) =>
                        updateVariantCubit.nameUpdate(name),
                  ),
                  // ErrorText(text: 'Nam'),
                  if (validate is UpdateVariantFormError) ...[
                    if (validate.errors.name.isNotEmpty)
                      ErrorText(text: validate.errors.name.first),
                  ]
                ],
              );
            }),
            const SizedBox(height: 16.0),
            BlocBuilder<UpdateVariantCubit, UpdateVariantStateModel>(
                builder: (_, state) {
              return Container(
                height: 50.0,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                decoration: BoxDecoration(
                  border: Border.all(color: grayColor.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: DropdownButton<String>(
                  hint: const Text('Status'),
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  underline: const SizedBox(),
                  value: statusValue,
                  onChanged: (newValue) {
                    statusValue = newValue!;
                    updateVariantCubit.statusUpdate(statusValue);
                    print(statusValue);
                  },
                  items: status
                      .map(
                        (e) => DropdownMenuItem<String>(
                          value: e.id,
                          child: Text(e.title),
                        ),
                      )
                      .toList(),
                ),
              );
            }),
            const SizedBox(height: 20.0),
            BlocBuilder<UpdateVariantCubit, UpdateVariantStateModel>(
              builder: (context, state) {
                final variant = state.updateState;
                if (variant is UpdateVariantLoading) {
                  return LoadingWidget();
                }
                return PrimaryButton(
                    text: Language.updateVariant,
                    onPressed: () {
                      Utils.closeKeyBoard(context);
                      updateVariantCubit
                          .updateVariantProduct(widget.variant.id.toString());
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
