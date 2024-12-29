import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/k_images.dart';
import '../../../widgets/confirm_dialog.dart';
import '/core/routes/routes_names.dart';
import '/modules/order/controller/orders_cubit/orders_cubit.dart';
import '/utils/language_string.dart';
import '/utils/utils.dart';
import '../../../core/remote_urls.dart';
import '../../../utils/constants.dart';
import '../../../widgets/custom_image.dart';
import '../../order/model/single_product_model/single_product_model.dart';
import '../../store_product/controller/store_product_bloc/store_product_bloc.dart';
import '../../store_product/model/store_product_state_model.dart';
import 'gallery_variant_dialog.dart';

class SingleProductCard extends StatelessWidget {
  const SingleProductCard({super.key, required this.product});

  final List<SingleProductModel> product;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 20.0,
          // childAspectRatio: 0.625,
          mainAxisExtent: 280.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final result = product[index];
            return Container(
              width: 185.0,
              decoration: BoxDecoration(
                  color: whiteColor, borderRadius: BorderRadius.circular(2.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    // fit: StackFit.expand,
                    children: [
                      Container(
                        height: 170.0,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(4),
                        width: double.infinity,
                        // color: Colors.yellow,
                        child: CustomImage(
                          path: RemoteUrls.imageUrl(result.thumbImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                          left: 0.0,
                          top: 0.0,
                          child: _showActiveStatus(context,
                              result.id.toString(), result.status.toString())),
                      //child: _showActiveStatus(AllStatusCode.isStatus(result.status))),
                      Positioned(
                        right: 12.0,
                        top: 12.0,
                        child: GestureDetector(
                          onTap: () async {
                            await showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => ConfirmDialog(
                                icon: KImages.deleteIcon2,
                                message: 'Do you want to Delete\nthis Product?',
                                confirmText: 'Yes, Delete',
                                cancelText: 'No',
                                onTap: () async {
                                  context
                                      .read<OrdersCubit>()
                                      .deleteSingleProduct(
                                          result.id.toString());
                                },
                              ),
                            );

                          },
                          child: Container(
                            height: 26.0,
                            width: 26.0,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: redColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.delete,
                              color: whiteColor,
                              size: 18.0,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  // SizedBox(
                  //   height: 22.0,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: [
                  //       _highlightedText(
                  //           AllStatusCode.isFeature(result.isFeatured),
                  //           greenColor,
                  //           const Color.fromRGBO(39, 174, 96, 0.07)),
                  //       _highlightedText(
                  //           AllStatusCode.isTop(result.isTop),
                  //           Utils.dynamicPrimaryColor(context),
                  //           const Color.fromRGBO(255, 187, 56, 0.15)),
                  //       _highlightedText(
                  //           AllStatusCode.isNew(result.newProduct),
                  //           greenColor,
                  //           const Color.fromRGBO(39, 174, 96, 0.07)),
                  //       _highlightedText(
                  //           AllStatusCode.isBest(result.isBest),
                  //           Utils.dynamicPrimaryColor(context),
                  //           const Color.fromRGBO(255, 187, 56, 0.15)),
                  //     ],
                  //   ),
                  // ),
                  Container(
                    // height: 50.0,
                    // color: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          // 'Hello bangladesh, how are you,what are you doing',
                          result.name,
                          minFontSize: 16.0,
                          maxFontSize: 16.0,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              color: grayColor,
                              height: 1.4),
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (result.offerPrice != 0.0) ...[
                              Flexible(
                                child: Text(
                                  Utils.formatAmount(
                                      context, result.offerPrice),
                                  maxLines: 1,
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0,
                                    color: redColor,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                            Flexible(
                              child: Text(
                                Utils.formatAmount(context, result.price),
                                maxLines: 1,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0,
                                  color: redColor,
                                  height: 1.4,
                                  decoration: result.offerPrice != 0.0
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.blue,
                    height: 55.0,
                    alignment: Alignment.bottomCenter,
                    // margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        EditButton(
                          title: Language.edit,
                          icon: Icons.edit,
                          onTap: () => Navigator.pushNamed(
                            context,
                            RouteNames.updateProductScreen,
                            arguments: result,
                          ),
                          iconTextColor: blackColor,
                        ),
                        EditButton(
                          title: Language.option,
                          icon: Icons.settings,
                          // onTap: () => showPopupMenuButton(context),
                          onTap: () => showDialog<void>(
                            context: context,
                            barrierDismissible: false,
                            // false = user must tap button, true = tap outside dialog
                            builder: (BuildContext dialogContext) {
                              return GalleryVariantDialog(product: result);
                            },
                          ),
                          bgColor: blackColor,
                          iconTextColor: whiteColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          childCount: product.length,
        ),
      ),
    );
  }

  // Widget _highlightedText(String test, tColor, bColor) {
  //   return test.isNotEmpty
  //       ? Container(
  //           height: 20.0,
  //           alignment: Alignment.center,
  //           margin: const EdgeInsets.symmetric(horizontal: 0.0),
  //           decoration: BoxDecoration(
  //             color: bColor,
  //             borderRadius: BorderRadius.circular(24.0),
  //           ),
  //           child: Padding(
  //             padding:
  //                 const EdgeInsets.symmetric(vertical: 0.0, horizontal: 6.0),
  //             child: Text(test,
  //                 style: GoogleFonts.roboto(
  //                   fontSize: 10.0,
  //                   color: tColor,
  //                   fontWeight: FontWeight.w400,
  //                 )),
  //           ),
  //         )
  //       : const SizedBox();
  // }

  Widget _showActiveStatus(BuildContext context, String id, String status) {
    return BlocListener<StoreProductBloc, StoreProductStateModel>(
      listener: (_, state) {
        final status = state.state;
        if (status is StoreProductLoading) {
          log(status.toString(), name: '_showActiveStatus');
        } else if (status is StoreProductLoadError) {
          if (status.statusCode == 503) {
            Utils.serviceUnAvailable(context, status.message);
          } else {
            Utils.errorSnackBar(context, status.message);
          }
        } else if (status is StoreProductStatusUpdated) {
          Utils.showSnackBar(context, status.message);
          context.read<OrdersCubit>().getAllProduct();
        }
      },
      child: BlocBuilder<StoreProductBloc, StoreProductStateModel>(
          builder: (_, state) {
        return Transform.scale(
          scale: 0.9,
          child: Switch(
              activeColor: greenColor,
              value: status == '1' ? true : false,
              inactiveThumbColor: redColor,
              onChanged: (bool? val) {
                if (val != null) {
                  status = status == '0' ? '1' : '0';
                  context
                      .read<StoreProductBloc>()
                      .add(StoreProductUpdateStatusEvent(id));
                }
              }),
        );
      }),
    );
  }
}

// ignore: must_be_immutable
class EditButton extends StatelessWidget {
  EditButton(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap,
      required this.iconTextColor,
      this.bgColor = primaryColor});

  final String title;
  final IconData icon;
  Color bgColor;
  final Color iconTextColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // bgColor = Utils.dynamicPrimaryColor(context);
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: onTap,
        style: ButtonStyle(
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          backgroundColor: WidgetStateProperty.all(bgColor),
          shadowColor: WidgetStateProperty.all(Colors.transparent),
          splashFactory: NoSplash.splashFactory,
          shape: WidgetStateProperty.all(
            const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
        ),
        icon: Padding(
          padding: EdgeInsets.zero,
          child: Icon(icon, size: 20.0, color: iconTextColor),
        ),
        label: FittedBox(
          child: Text(
            title,
            style: TextStyle(
              color: iconTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
