import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '/utils/utils.dart';
import '/widgets/error_text.dart';
import '../../utils/constants.dart';
import '../../utils/language_string.dart';
import '../../utils/loading_widget.dart';
import '../../widgets/primary_button.dart';
import '../order/model/single_product_model/single_product_model.dart';
import '../store_product/component/required_text_field.dart';
import 'component/get_updated_category.dart';
import 'component/get_updated_image.dart';
import 'component/get_updated_status.dart';
import 'controller/update_bloc/update_product_bloc.dart';
import 'model/update_product_model_state.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key, required this.product});

  // final String productId;
  final SingleProductModel product;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final spacer = const SizedBox(height: 20.0);
  final _className = "UpdateProductScreen";

  //late EditProductModel editProduct;

  @override
  void initState() {
    super.initState();

    // Future.microtask(() => context
    //     .read<EditProductCubit>()
    //     .getEditProduct(widget.product.id.toString()));
    //editProduct = context.read<EditProductCubit>().editProductModel!;

    loadAllEventData();
  }

  loadAllEventData() {
    //context.read<UpdateProductBloc>().add(UpdateProductEventImage(widget.product.thumbImage));
    context
        .read<UpdateProductBloc>()
        .add(UpdateProductEventShortName(widget.product.shortName));
    context
        .read<UpdateProductBloc>()
        .add(UpdateProductEventName(widget.product.name));
    context
        .read<UpdateProductBloc>()
        .add(UpdateProductEventSlug(widget.product.slug));
    context.read<UpdateProductBloc>().add(
        UpdateProductEventCategory(widget.product.category!.id.toString()));
    context
        .read<UpdateProductBloc>()
        .add(UpdateProductEventPrice(widget.product.price.toString()));
    context.read<UpdateProductBloc>().add(
        UpdateProductEventOfferPrice(widget.product.offerPrice.toString()));
    context
        .read<UpdateProductBloc>()
        .add(UpdateProductEventQuantity(widget.product.qty.toString()));
    context
        .read<UpdateProductBloc>()
        .add(UpdateProductEventWeight(widget.product.weight));
    context
        .read<UpdateProductBloc>()
        .add(UpdateProductEventShortDes(widget.product.shortDescription));
    context
        .read<UpdateProductBloc>()
        .add(UpdateProductEventLongDes(widget.product.longDescription));
    context
        .read<UpdateProductBloc>()
        .add(UpdateProductEventStatus(widget.product.status.toString()));

    context
        .read<UpdateProductBloc>()
        .add(UpdateProductEventTop(widget.product.isTop.toString()));

    context
        .read<UpdateProductBloc>()
        .add(UpdateProductEventBestProduct(widget.product.isBest.toString()));
    context.read<UpdateProductBloc>().add(UpdateProductEventNewArrivalProduct(
        widget.product.newProduct.toString()));
    context
        .read<UpdateProductBloc>()
        .add(UpdateProductEventFeatured(widget.product.isFeatured.toString()));

    context
        .read<UpdateProductBloc>()
        .add(UpdateProductEventSeoTitle(widget.product.seoTitle));

    context
        .read<UpdateProductBloc>()
        .add(UpdateProductEventSeoDescription(widget.product.seoDescription));

    context
        .read<UpdateProductBloc>()
        .add(UpdateProductEventSku(widget.product.sku));

    context
        .read<UpdateProductBloc>()
        .add(UpdateProductEventTags(widget.product.tags));
  }

  @override
  Widget build(BuildContext context) {
    final updateBloc = context.read<UpdateProductBloc>();
    final product = widget.product;
    // print('ProductId: ${product.id}');
    //final editProduct = context.read<EditProductCubit>().editProductModel;
    // print(product.shortName);
    // print(product.category!.name);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Product',
          style: TextStyle(color: whiteColor),
        ),
        backgroundColor: blackColor,
      ),
      body: BlocListener<UpdateProductBloc, UpdateProductModelState>(
        listener: (_, state) {
          final updateState = state.updateState;
          if (updateState is UpdateProductInitial) {
            log(_className, name: updateState.toString());
          } else if (updateState is UpdateProductLoading) {
            log(_className, name: updateState.toString());
          } else if (updateState is UpdateProductError) {
            // log(_className,name: updateState.toString());
            Utils.errorSnackBar(context, updateState.message);
          } else if (updateState is UpdateProductLoaded) {
            Navigator.of(context).pop(true);
            //Utils.showSnackBar(context, updateState.message);
            // Navigator.of(context).pop(true);
          }
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          physics: const BouncingScrollPhysics(),
          children: [
            spacer,
            GetUpdatedImage(image: widget.product.thumbImage),
            spacer,
            BlocBuilder<UpdateProductBloc, UpdateProductModelState>(
              builder: (context, state) {
                print('SN: ${state.shortName}');
                final s = state.updateState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RequiredTextField(
                      title: Language.shortName,
                      initialValue: product.shortName,
                      onChange: (String shortName) {
                        updateBloc.add(UpdateProductEventShortName(shortName));
                        print(shortName);
                      },
                    ),
                    if (s is UpdateProductFormValidate) ...[
                      if (s.errors.shortName.isNotEmpty)
                        ErrorText(text: s.errors.shortName.first)
                    ]
                  ],
                );
              },
            ),
            spacer,
            BlocBuilder<UpdateProductBloc, UpdateProductModelState>(
              builder: (context, state) {
                final s = state.updateState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RequiredTextField(
                        title: 'Name',
                        initialValue: product.name,
                        onChange: (name) {
                          updateBloc.add(UpdateProductEventName(name));
                          print(name);
                        }),
                    if (s is UpdateProductFormValidate) ...[
                      if (s.errors.name.isNotEmpty)
                        ErrorText(text: s.errors.name.first)
                    ]
                  ],
                );
              },
            ),
            spacer,
            BlocBuilder<UpdateProductBloc, UpdateProductModelState>(
              builder: (context, state) {
                final s = state.updateState;
                print('slugName: ${state.slug}');
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RequiredTextField(
                        title: 'Slug',
                        initialValue: product.slug,
                        onChange: (slug) {
                          updateBloc.add(UpdateProductEventSlug(slug));
                          print(slug);
                        }),
                    if (s is UpdateProductFormValidate) ...[
                      if (s.errors.slug.isNotEmpty)
                        ErrorText(text: s.errors.slug.first)
                    ]
                  ],
                );
              },
            ),
            spacer,
            GetUpdatedCategory(categoryId: product.category!.id.toString()),
            spacer,
            BlocBuilder<UpdateProductBloc, UpdateProductModelState>(
                builder: (_, state) {
              final s = state.updateState;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RequiredTextField(
                      onChange: (price) {
                        updateBloc.add(UpdateProductEventPrice(price));
                        print(price);
                      },
                      initialValue: product.price.toString(),
                      title: 'Price',
                      type: TextInputType.number),
                  if (s is UpdateProductFormValidate) ...[
                    if (s.errors.price.isNotEmpty)
                      ErrorText(text: s.errors.price.first)
                  ]
                ],
              );
            }),
            spacer,
            BlocBuilder<UpdateProductBloc, UpdateProductModelState>(
              builder: (context, state) => RequiredTextField(
                onChange: (offerPrice) {
                  updateBloc.add(UpdateProductEventOfferPrice(offerPrice));
                  print(offerPrice);
                },
                initialValue: product.offerPrice.toString(),
                title: 'Offer Price',
                type: TextInputType.number,
                isStar: false,
              ),
            ),
            spacer,
            BlocBuilder<UpdateProductBloc, UpdateProductModelState>(
              builder: (context, state) {
                final s = state.updateState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RequiredTextField(
                      initialValue: product.qty.toString(),
                      onChange: (qty) {
                        updateBloc.add(UpdateProductEventQuantity(qty));
                        print('qty: $qty');
                      },
                      title: 'Quantity',
                      type: TextInputType.number,
                    ),
                    if (s is UpdateProductFormValidate) ...[
                      if (s.errors.quantity.isNotEmpty)
                        ErrorText(text: s.errors.quantity.first)
                    ]
                  ],
                );
              },
            ),
            spacer,
            BlocBuilder<UpdateProductBloc, UpdateProductModelState>(
              builder: (context, state) {
                final s = state.updateState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RequiredTextField(
                      onChange: (weight) {
                        updateBloc.add(UpdateProductEventWeight(weight));
                        print('weight: $weight');
                      },
                      initialValue: product.weight,
                      title: 'Weight',
                      isStar: true,
                    ),
                    if (s is UpdateProductFormValidate) ...[
                      if (s.errors.weight.isNotEmpty)
                        ErrorText(text: s.errors.weight.first)
                    ]
                  ],
                );
              },
            ),
            spacer,
            BlocBuilder<UpdateProductBloc, UpdateProductModelState>(
              builder: (context, state) {
                final s = state.updateState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Short Description',
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400, fontSize: 14.0),
                          ),
                          const TextSpan(
                              text: ' *', style: TextStyle(color: redColor))
                        ],
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    SizedBox(
                      height: 110.0,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          // contentPadding: EdgeInsets.symmetric(vertical: 100.0,horizontal: 10.0),
                          hintText: 'Short Description',
                          alignLabelWithHint: true,
                        ),
                        onChanged: (des) {
                          updateBloc.add(UpdateProductEventShortDes(des));
                          print('s.des: $des');
                        },
                        initialValue: product.shortDescription,
                        maxLines: 6,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    if (s is UpdateProductFormValidate) ...[
                      if (s.errors.shortDescription.isNotEmpty)
                        ErrorText(text: s.errors.shortDescription.first)
                    ]
                  ],
                );
              },
            ),
            spacer,
            BlocBuilder<UpdateProductBloc, UpdateProductModelState>(
              // buildWhen: (p,c)=>p.shortDescription != c.shortDescription,
              builder: (context, state) {
                final s = state.updateState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Long Description',
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400, fontSize: 14.0),
                          ),
                          const TextSpan(
                              text: ' *', style: TextStyle(color: redColor))
                        ],
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    SizedBox(
                      height: 110.0,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          // contentPadding: EdgeInsets.symmetric(vertical: 100.0,horizontal: 10.0),
                          hintText: 'Long Description',
                          alignLabelWithHint: true,
                        ),
                        onChanged: (longDes) {
                          updateBloc.add(UpdateProductEventLongDes(longDes));
                        },
                        initialValue: product.longDescription,
                        maxLines: 10,
                        textAlign: TextAlign.justify,
                        // style: TextStyle(),
                      ),
                    ),
                    if (s is UpdateProductFormValidate) ...[
                      if (s.errors.longDescription.isNotEmpty)
                        ErrorText(text: s.errors.longDescription.first)
                    ]
                  ],
                );
              },
            ),
            spacer,
            GetUpdatedStatus(statusId: product.status.toString()),
            spacer,
            BlocBuilder<UpdateProductBloc, UpdateProductModelState>(
              builder: (context, state) => RequiredTextField(
                onChange: (sku) {
                  updateBloc.add(UpdateProductEventSku(sku));
                  print(sku);
                },
                initialValue: product.sku,
                title: 'Sku',
                type: TextInputType.text,
                isStar: false,
              ),
            ),
            spacer,
            BlocBuilder<UpdateProductBloc, UpdateProductModelState>(
              builder: (context, state) => RequiredTextField(
                onChange: (tags) {
                  updateBloc.add(UpdateProductEventTags(tags));
                  print(tags);
                },
                initialValue: product.tags,
                title: 'Tags',
                type: TextInputType.text,
                isStar: false,
              ),
            ),
            spacer,
            BlocBuilder<UpdateProductBloc, UpdateProductModelState>(
              builder: (context, state) => RequiredTextField(
                onChange: (tags) {
                  updateBloc.add(UpdateProductEventSeoTitle(tags));
                  print(tags);
                },
                initialValue: product.seoTitle,
                title: 'Seo Title',
                type: TextInputType.text,
                isStar: false,
              ),
            ),
            spacer,
            BlocBuilder<UpdateProductBloc, UpdateProductModelState>(
              builder: (context, state) => RequiredTextField(
                onChange: (tags) {
                  updateBloc.add(UpdateProductEventSeoDescription(tags));
                  print(tags);
                },
                initialValue: product.seoDescription,
                title: 'Sku',
                type: TextInputType.text,
                isStar: false,
              ),
            ),
            spacer,
            BlocBuilder<UpdateProductBloc, UpdateProductModelState>(
              builder: (context, state) {
                // print('isTop : ${state.isTop}');
                String isTop = state.isTop;
                String isBest = state.isBest;
                String newProduct = state.newProduct;
                String isFeatured = state.isFeatured;
                return Row(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                            activeColor: Utils.dynamicPrimaryColor(context),
                            value: isTop == '1' ? true : false,
                            onChanged: (bool? val) {
                              if (val != null) {
                                isTop = isTop == '0' ? '1' : '0';
                                updateBloc.add(UpdateProductEventTop(isTop));
                                print('isTop : $isTop');
                              }
                            }),
                        const Text('Top')
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            activeColor: Utils.dynamicPrimaryColor(context),
                            value: isBest == '1' ? true : false,
                            onChanged: (bool? val) {
                              if (val != null) {
                                isBest = isBest == '0' ? '1' : '0';
                                updateBloc
                                    .add(UpdateProductEventBestProduct(isBest));
                                print('isBest : $isBest');
                              }
                            }),
                        const Text('Best')
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            activeColor: Utils.dynamicPrimaryColor(context),
                            value: newProduct == '1' ? true : false,
                            onChanged: (bool? val) {
                              if (val != null) {
                                newProduct = newProduct == '0' ? '1' : '0';
                                updateBloc.add(
                                    UpdateProductEventNewArrivalProduct(
                                        newProduct));
                                print('newProduct : $newProduct');
                              }
                            }),
                        const Text('New')
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                            activeColor: Utils.dynamicPrimaryColor(context),
                            value: isFeatured == '1' ? true : false,
                            onChanged: (bool? val) {
                              if (val != null) {
                                isFeatured = isFeatured == '0' ? '1' : '0';
                                updateBloc.add(
                                    UpdateProductEventFeatured(isFeatured));
                                print('isFeatured : $isFeatured');
                              }
                            }),
                        const Text('Featured')
                      ],
                    ),
                  ],
                );
              },
            ),
            spacer,
            BlocBuilder<UpdateProductBloc, UpdateProductModelState>(
                builder: (_, state) {
              final submit = state.updateState;
              if (submit is UpdateProductLoading) {
                return LoadingWidget();
              }
              return PrimaryButton(
                  text: Language.updateProduct,
                  onPressed: () {
                    Utils.closeKeyBoard(context);
                    updateBloc
                        .add(UpdateProductSubmitEvent(product.id.toString()));
                  });
              //return const SizedBox();
            }),
            const SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }
}
