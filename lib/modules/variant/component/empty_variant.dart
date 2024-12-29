import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller_app/utils/language_string.dart';
import 'package:seller_app/utils/utils.dart';
import 'package:seller_app/widgets/custom_image.dart';
import 'package:seller_app/widgets/error_text.dart';

import '../../../core/dummy_data/dummy_data.dart';
import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';
import '../../../utils/loading_widget.dart';
import '../../../widgets/primary_button.dart';
import '../controller/create_variant_bloc/create_variant_bloc.dart';
import '../controller/get_variant_cubit/variant_cubit.dart';
import '../model/create_variant_state_model.dart';

class EmptyVariant extends StatelessWidget {
  const EmptyVariant({super.key, required this.productId});
  final String productId;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      // height: size.height,
      width: size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(height: size.height / 6.0),
          const CustomImage(path: KImages.emptyVariant),
          const SizedBox(height: 18.0),
          Text(
            Language.noVariantProduct,
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20.0),
          ),
          const SizedBox(height: 24.0),
          PrimaryButton(
              text: Language.addVariant,
              onPressed: () => showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => AddNewVariantDialog(productId: productId))),
        ],
      ),
    );
  }
}

class AddNewVariantDialog extends StatefulWidget {
  const AddNewVariantDialog({super.key, required this.productId});
  final String productId;

  @override
  State<AddNewVariantDialog> createState() => _AddNewVariantDialogState();
}

class _AddNewVariantDialogState extends State<AddNewVariantDialog> {
  late List<ProductStatusModel> status;
  late String statusValue;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    status = productStatusModel;
    statusValue = status.first.id;
    context
        .read<CreateVariantBloc>()
        .add(CreateVariantProductIdEvent(widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    final variantBloc = context.read<CreateVariantBloc>();
    return AlertDialog(
      content: BlocListener<CreateVariantBloc, CreateVariantStateModel>(
        listener: (context, state) {
          print('product_id: ${state.productId}');
          final variant = state.createState;
          if (variant is CreateVariantLoading) {
            Utils.closeKeyBoard(context);
            log(variant.toString(), name: "AddNewVariantDialog");
          }
          if (variant is CreateVariantError) {
            Navigator.of(context).pop();
            Utils.errorSnackBar(context, variant.message);
          }
          if (variant is CreateVariantLoaded) {
            Navigator.of(context).pop(true);
            Utils.showSnackBar(context, variant.message);
            context
                .read<VariantProductCubit>()
                .getAllProductVariantById(widget.productId);

            // variantBloc.close();
          }
          // if(variant is CreateVariantFormValidate){
          //   // Utils.closeKeyBoard(context);
          //   Utils.showSnackBar(context, variant.errors.name.first);
          // }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(Language.addVariant),
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
            BlocBuilder<CreateVariantBloc, CreateVariantStateModel>(
                builder: (_, state) {
              final validate = state.createState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    initialValue: state.name,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(hintText: 'Name'),
                    onChanged: (String name) => variantBloc.add(
                      CreateVariantNameEvent(name),
                    ),
                  ),
                  // ErrorText(text: 'Nam'),
                  if (validate is CreateVariantFormValidate) ...[
                    if (validate.errors.name.isNotEmpty)
                      ErrorText(text: validate.errors.name.first),
                  ]
                ],
              );
            }),
            const SizedBox(height: 16.0),
            BlocBuilder<CreateVariantBloc, CreateVariantStateModel>(
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
                    variantBloc.add(CreateVariantStatusEvent(statusValue));
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
            BlocBuilder<CreateVariantBloc, CreateVariantStateModel>(
              builder: (context, state) {
                final variant = state.createState;
                if (variant is CreateVariantLoading) {
                  return LoadingWidget();
                }
                return PrimaryButton(
                    text: Language.saveVariant,
                    onPressed: () {
                      // variantBloc.add(CreateVariantProductIdEvent(widget.productId));
                      variantBloc.add(const CreateVariantSubmitWithIdEvent());
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
