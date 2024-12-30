import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seller_app/modules/store_product/controller/category_brand_cubit/category_brand_cubit.dart';

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
                        title: 'Short Name (Arabic)',
                        initialValue: state.shortNameAr,
                        onChange: (shortNameAr) {
                          storeProduct
                              .add(StoreProductEventShortNameAr(shortNameAr));
                        }),
                    if (s is StoreProductLoadFormValidate) ...[
                      if (s.errors.shortNameAr.isNotEmpty)
                        ErrorText(text: s.errors.shortNameAr.first)
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
                        title: 'Name (Arabic)',
                        initialValue: state.nameAr,
                        onChange: (nameAr) {
                          storeProduct.add(StoreProductEventNameAr(nameAr));
                        }),
                    if (s is StoreProductLoadFormValidate) ...[
                      if (s.errors.nameAr.isNotEmpty)
                        ErrorText(text: s.errors.nameAr.first)
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
                                    text: 'Short Description (Arabic)',
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.0),
                                  ),
                                  const TextSpan(
                                      text: ' *',
                                      style: TextStyle(color: redColor))
                                ],
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            SizedBox(
                              height: 110.0,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Short Description (Arabic)',
                                  alignLabelWithHint: true,
                                ),
                                onChanged: (desAr) {
                                  storeProduct
                                      .add(StoreProductEventShortDesAr(desAr));
                                },
                                initialValue: state.shortDescriptionAr,
                                maxLines: 6,
                              ),
                            ),
                            if (s is StoreProductLoadFormValidate) ...[
                              if (s.errors.shortDescriptionAr.isNotEmpty)
                                ErrorText(
                                    text: s.errors.shortDescriptionAr.first)
                            ]
                          ],
                        );
                      },
                    ),
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
                    const SizedBox(height: 8.0),
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
                                    text: 'Long Description (Arabic)',
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.0),
                                  ),
                                  const TextSpan(
                                      text: ' *',
                                      style: TextStyle(color: redColor))
                                ],
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            SizedBox(
                              height: 110.0,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Long Description (Arabic)',
                                  alignLabelWithHint: true,
                                ),
                                onChanged: (longDesAr) {
                                  storeProduct.add(
                                      StoreProductEventLongDesAr(longDesAr));
                                },
                                initialValue: state.longDescriptionAr,
                                maxLines: 10,
                              ),
                            ),
                            if (s is StoreProductLoadFormValidate) ...[
                              if (s.errors.longDescriptionAr.isNotEmpty)
                                ErrorText(
                                    text: s.errors.longDescriptionAr.first)
                            ]
                          ],
                        );
                      },
                    ),
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

// In your UI, after the Switch widget:
            BlocBuilder<StoreProductBloc, StoreProductStateModel>(
              builder: (context, state) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Switch(
                            activeColor: Utils.dynamicPrimaryColor(context),
                            value: state.isSpecification == '1',
                            onChanged: (bool? val) {
                              final newValue = val! ? '1' : '0';
                              context.read<StoreProductBloc>().add(
                                    StoreProductEventSpecification(newValue),
                                  );
                            }),
                        const Text('المواصفات'),
                      ],
                    ),
                    // Add the SpecificationsSection here
                    const SpecificationsSection(),
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

class SpecificationsSection extends StatelessWidget {
  const SpecificationsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreProductBloc, StoreProductStateModel>(
      builder: (context, state) {
        final specificationKeys = context
            .read<CategoryBrandCubit>()
            .categoryBrandModel
            .specificationKey;

        if (state.isSpecification != '1') return const SizedBox();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              'المواصفات',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.specifications.length,
              itemBuilder: (context, index) {
                final spec = state.specifications[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<int>(
                            value: spec.keyId,
                            hint: const Text('اختر المواصفة'),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 12),
                            ),
                            items: specificationKeys.map((specKey) {
                              return DropdownMenuItem(
                                value: specKey.id,
                                child: Text(specKey.key),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                final newSpecs =
                                    List<ProductSpecification>.from(
                                        state.specifications);
                                newSpecs[index] = ProductSpecification(
                                  keyId: value,
                                  key: specificationKeys
                                      .firstWhere(
                                          (element) => element.id == value)
                                      .key,
                                  value: spec.value,
                                );
                                // Correct way to add the event
                                context.read<StoreProductBloc>().add(
                                    StoreProductEventSpecifications(newSpecs));
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextFormField(
                            initialValue: spec.value,
                            decoration: const InputDecoration(
                              hintText: 'أدخل القيمة',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              final newSpecs = List<ProductSpecification>.from(
                                  state.specifications);
                              newSpecs[index] = spec.copyWith(value: value);
                              // Correct way to add the event
                              context.read<StoreProductBloc>().add(
                                  StoreProductEventSpecifications(newSpecs));
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline,
                              color: Colors.red),
                          onPressed: () {
                            final newSpecs = List<ProductSpecification>.from(
                                state.specifications);
                            newSpecs.removeAt(index);
                            // Correct way to add the event
                            context
                                .read<StoreProductBloc>()
                                .add(StoreProductEventSpecifications(newSpecs));
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
// When adding a new specification
            ElevatedButton.icon(
              onPressed: () {
                final newSpecs =
                    List<ProductSpecification>.from(state.specifications);
                newSpecs.add(ProductSpecification(
                  keyId: null, // Now this is valid since keyId is nullable
                  key: '',
                  value: '',
                ));
                context
                    .read<StoreProductBloc>()
                    .add(StoreProductEventSpecifications(newSpecs));
              },
              icon: const Icon(Icons.add),
              label: const Text('إضافة مواصفة'),
            ),
          ],
        );
      },
    );
  }
}
