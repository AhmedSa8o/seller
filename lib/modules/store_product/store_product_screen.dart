import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '/modules/store_product/component/get_category.dart';
import '/modules/store_product/component/get_status.dart';
import '/widgets/error_text.dart';
import '../../utils/constants.dart';
import '../../utils/language_string.dart';
import '../../utils/loading_widget.dart';
import '../../utils/utils.dart';
import '../../widgets/primary_button.dart';
import 'component/get_image_from_gallery.dart';
import 'component/required_text_field.dart';
import 'controller/store_product_bloc/store_product_bloc.dart';
import 'model/store_product_state_model.dart';

class StoreProductScreen extends StatefulWidget {
  const StoreProductScreen({super.key});

  @override
  State<StoreProductScreen> createState() => _StoreProductScreenState();
}

class _StoreProductScreenState extends State<StoreProductScreen> {
  final String _class = 'StoreProductScreen';

  @override
  Widget build(BuildContext context) {
    // print('catVal : $value');
    // print('statusVal : $statusValue');
    final storeProduct = context.read<StoreProductBloc>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blackColor,
        title: const Text(
          'Create New Product',
          style: TextStyle(color: whiteColor),
        ),
      ),
      body: BlocListener<StoreProductBloc, StoreProductStateModel>(
        listener: (context, state) {
          final listenState = state.state;
          if (listenState is StoreProductInitial) {
            log(listenState.toString(), name: _class);
          } else if (listenState is StoreProductLoading) {
            log(listenState.toString(), name: _class);
          } else if (listenState is StoreProductLoadError) {
            Utils.errorSnackBar(context, listenState.message);
          } else if (listenState is StoreProductLoaded) {
            log(listenState.toString(), name: _class);
            Navigator.of(context).pop(true);
            Utils.showSnackBar(context, listenState.notification);
            // Navigator.pop(context);
          }
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          physics: const ClampingScrollPhysics(),
          children: [
            const GetImageFromGallery(),
            BlocBuilder<StoreProductBloc, StoreProductStateModel>(
              builder: (context, state) {
                final s = state.state;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RequiredTextField(
                        title: Language.shortName,
                        initialValue: state.shortName,
                        onChange: (shortName) {
                          storeProduct
                              .add(StoreProductEventShortName(shortName));
                          print(shortName);
                        }),
                    if (s is StoreProductLoadFormValidate) ...[
                      if (s.errors.shortName.isNotEmpty)
                        ErrorText(text: s.errors.shortName.first)
                    ]
                  ],
                );
              },
            ),
            const SizedBox(height: 16.0),
            BlocBuilder<StoreProductBloc, StoreProductStateModel>(
              builder: (context, state) {
                final s = state.state;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RequiredTextField(
                        title: 'Name',
                        initialValue: state.name,
                        onChange: (name) {
                          storeProduct.add(StoreProductEventName(name));
                          print(name);
                        }),
                    if (s is StoreProductLoadFormValidate) ...[
                      if (s.errors.name.isNotEmpty)
                        ErrorText(text: s.errors.name.first)
                    ]
                  ],
                );
              },
            ),
            const SizedBox(height: 16.0),
            BlocBuilder<StoreProductBloc, StoreProductStateModel>(
              builder: (context, state) {
                final s = state.state;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RequiredTextField(
                        title: 'Slug',
                        initialValue: state.slug,
                        onChange: (slug) {
                          storeProduct.add(StoreProductEventSlug(slug));
                          print(slug);
                        }),
                    if (s is StoreProductLoadFormValidate) ...[
                      if (s.errors.slug.isNotEmpty)
                        ErrorText(text: s.errors.slug.first)
                    ]
                  ],
                );
              },
            ),
            const SizedBox(height: 16.0),
            const GetCategory(),
            const SizedBox(height: 16.0),
            BlocBuilder<StoreProductBloc, StoreProductStateModel>(
                builder: (_, state) {
              final s = state.state;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RequiredTextField(
                      onChange: (price) {
                        storeProduct.add(StoreProductEventPrice(price));
                        print(price);
                      },
                      initialValue: state.price,
                      title: 'Price',
                      type: TextInputType.number),
                  if (s is StoreProductLoadFormValidate) ...[
                    if (s.errors.price.isNotEmpty)
                      ErrorText(text: s.errors.price.first)
                  ]
                ],
              );
            }),
            const SizedBox(height: 16.0),
            BlocBuilder<StoreProductBloc, StoreProductStateModel>(
              builder: (context, state) => RequiredTextField(
                onChange: (offerPrice) {
                  storeProduct.add(StoreProductEventOfferPrice(offerPrice));
                  print(offerPrice);
                },
                initialValue: state.offerPrice,
                title: 'Offer Price',
                type: TextInputType.number,
                isStar: false,
              ),
            ),
            const SizedBox(height: 16.0),
            BlocBuilder<StoreProductBloc, StoreProductStateModel>(
              builder: (context, state) {
                final s = state.state;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RequiredTextField(
                      initialValue: state.quantity,
                      onChange: (qty) {
                        storeProduct.add(StoreProductEventQuantity(qty));
                        print('qty: $qty');
                      },
                      title: 'Quantity',
                      type: TextInputType.number,
                    ),
                    if (s is StoreProductLoadFormValidate) ...[
                      if (s.errors.quantity.isNotEmpty)
                        ErrorText(text: s.errors.quantity.first)
                    ]
                  ],
                );
              },
            ),
            const SizedBox(height: 16.0),
            BlocBuilder<StoreProductBloc, StoreProductStateModel>(
              builder: (context, state) {
                final s = state.state;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RequiredTextField(
                      onChange: (widget) {
                        storeProduct.add(StoreProductEventWeight(widget));
                        print('widget: $widget');
                      },
                      initialValue: state.weight,
                      title: 'Weight',
                      isStar: true,
                    ),
                    if (s is StoreProductLoadFormValidate) ...[
                      if (s.errors.weight.isNotEmpty)
                        ErrorText(text: s.errors.weight.first)
                    ]
                  ],
                );
              },
            ),
            const SizedBox(height: 20.0),
            BlocBuilder<StoreProductBloc, StoreProductStateModel>(
              builder: (context, state) {
                final s = state.state;
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
                          storeProduct.add(StoreProductEventShortDes(des));
                          print('s.des: $des');
                        },
                        initialValue: state.shortDescription,
                        maxLines: 6,
                      ),
                    ),
                    if (s is StoreProductLoadFormValidate) ...[
                      if (s.errors.shortDescription.isNotEmpty)
                        ErrorText(text: s.errors.shortDescription.first)
                    ]
                  ],
                );
              },
            ),
            const SizedBox(height: 20.0),
            BlocBuilder<StoreProductBloc, StoreProductStateModel>(
              builder: (context, state) {
                final s = state.state;
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
                          storeProduct.add(StoreProductEventLongDes(longDes));
                        },
                        initialValue: state.longDescription,
                        maxLines: 10,
                      ),
                    ),
                    if (s is StoreProductLoadFormValidate) ...[
                      if (s.errors.longDescription.isNotEmpty)
                        ErrorText(text: s.errors.longDescription.first)
                    ]
                  ],
                );
              },
            ),
            const SizedBox(height: 20.0),

            ///start
            BlocBuilder<StoreProductBloc, StoreProductStateModel>(
              builder: (context, state) => RequiredTextField(
                onChange: (sku) {
                  storeProduct.add(StoreProductEventSku(sku));
                  print(sku);
                },
                initialValue: state.sku,
                title: 'Sku',
                type: TextInputType.text,
                isStar: false,
              ),
            ),
            const SizedBox(height: 20.0),
            const GetStatus(),
            BlocBuilder<StoreProductBloc, StoreProductStateModel>(
              builder: (context, state) => RequiredTextField(
                onChange: (tags) {
                  storeProduct.add(StoreProductEventTags(tags));
                  print(tags);
                },
                initialValue: state.tags,
                title: 'Tag',
                type: TextInputType.text,
                isStar: false,
              ),
            ),
            const SizedBox(height: 20.0),
            BlocBuilder<StoreProductBloc, StoreProductStateModel>(
              builder: (context, state) => RequiredTextField(
                onChange: (seoTitle) {
                  storeProduct.add(StoreProductEventSeoTitle(seoTitle));
                  print(seoTitle);
                },
                initialValue: state.seoTitle,
                title: 'Seo Title',
                type: TextInputType.text,
                isStar: false,
              ),
            ),
            const SizedBox(height: 20.0),
            BlocBuilder<StoreProductBloc, StoreProductStateModel>(
              builder: (context, state) => RequiredTextField(
                onChange: (description) {
                  storeProduct
                      .add(StoreProductEventSeoDescription(description));
                  print(description);
                },
                initialValue: state.seoDescription,
                title: 'Seo Description',
                type: TextInputType.text,
                isStar: false,
              ),
            ),
            const SizedBox(height: 20.0),

            BlocBuilder<StoreProductBloc, StoreProductStateModel>(
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
                                storeProduct.add(StoreProductEventTop(isTop));
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
                                storeProduct.add(StoreProductEventBest(isBest));
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
                                storeProduct.add(
                                    StoreProductEventNewProduct(newProduct));
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
                                storeProduct
                                    .add(StoreProductEventFeature(isFeatured));
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
            const SizedBox(height: 20.0),
            ////
            BlocBuilder<StoreProductBloc, StoreProductStateModel>(
              builder: (context, state) {
                String isSpecification = state.isSpecification;
                return Row(
                  children: [
                    Switch(
                        activeColor: Utils.dynamicPrimaryColor(context),
                        value: isSpecification == '0' ? false : true,
                        onChanged: (bool? val) {
                          isSpecification = isSpecification == '0' ? '1' : '0';
                          storeProduct.add(
                              StoreProductEventSpecification(isSpecification));
                          print('isSpecification : $isSpecification');
                        }),
                    const Text('Specification'),
                  ],
                );
              },
            ),

            ///end
            const SizedBox(height: 20.0),
            BlocBuilder<StoreProductBloc, StoreProductStateModel>(
                builder: (_, state) {
              final submit = state.state;
              print(submit);
              if (submit is StoreProductLoading) {
                return LoadingWidget();
              }
              return PrimaryButton(
                  text: Language.uploadProduct,
                  onPressed: () {
                    Utils.closeKeyBoard(context);
                    storeProduct.add(StoreProductSubmitEvent());
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
