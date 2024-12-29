import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '/core/routes/routes_names.dart';
import '/modules/gallery/controller/get_gallery_cubit/get_all_gallery_cubit.dart';
import '/modules/order/model/product_model.dart';
import '/utils/constants.dart';
import '/utils/language_string.dart';
import '/utils/loading_widget.dart';
import '../../utils/utils.dart';
import '../../widgets/page_refresh.dart';
import '../../widgets/primary_button.dart';
import '../order/controller/orders_cubit/orders_cubit.dart';
import '../store_product/controller/store_product_bloc/store_product_bloc.dart';
import '../store_product/model/store_product_state_model.dart';
import '../update/controller/update_bloc/update_product_bloc.dart';
import '../update/model/update_product_model_state.dart';
import 'component/empty_product_button.dart';
import 'component/single_product_card.dart';

class MyShopScreen extends StatefulWidget {
  const MyShopScreen({super.key});

  @override
  State<MyShopScreen> createState() => _MyShopScreenState();
}

class _MyShopScreenState extends State<MyShopScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrdersCubit>().getAllProduct();

    //loaded below cubit because of gallery class may null for next screen
    context.read<GetAllGalleryCubit>().gallery;
  }

  final _className = "MyShopScreen";

  @override
  Widget build(BuildContext context) {
    final product = context.read<OrdersCubit>().productModel;
    // print(product!.singleProduct.length);
    // return Scaffold(
    //   backgroundColor: bgColor,
    //   //appBar: const CustomAppBar(title: Language.myShop),
    //   body: buildBlocConsumer(context, product),
    // );
    return Scaffold(
      body: PageRefresh(
        onRefresh: () async {
          context.read<OrdersCubit>().getAllProduct();
        },
        child: MultiBlocListener(
          listeners: [
            BlocListener<OrdersCubit, OrdersState>(listener: (_, state) {
              if (state is OrderStateError) {
                Utils.serviceUnAvailable(context, state.message);
              }
              if (state is DeletedStateError) {
                context.read<OrdersCubit>().getAllProduct();
                Utils.errorSnackBar(context, state.message);
              }
              if (state is DeletedSingleProduct) {
                Utils.showSnackBar(context, state.message);
              }
            }),
            BlocListener<StoreProductBloc, StoreProductStateModel>(
                listener: (_, state) {
              final storeBloc = state.state;
              if (storeBloc is StoreProductLoaded) {
                log(storeBloc.toString(), name: _className);
                context.read<OrdersCubit>().getAllProduct();
              }
            }),
            BlocListener<UpdateProductBloc, UpdateProductModelState>(
              listener: (_, state) {
                final updatedListener = state.updateState;
                if (updatedListener is UpdateProductLoaded) {
                  Utils.showSnackBar(context, updatedListener.message);
                  context.read<OrdersCubit>().getAllProduct();
                }
              },
            ),
          ],
          child: BlocBuilder<OrdersCubit, OrdersState>(
            builder: (context, state) {
              {
                if (state is OrderStateLoading) {
                  return LoadingWidget();
                } else if (state is OrderStateError) {
                  if (state.statusCode == 503) {
                    return LoadedProduct(productModel: product!);
                  } else {
                    return Center(
                      child: Text(state.message,
                          style: const TextStyle(color: redColor)),
                    );
                  }
                } else if (state is OrderStateLoaded) {
                  return LoadedProduct(productModel: state.productModel);
                }
                return const Center(child: Text(Language.somethingWentWrong));
              }
            },
          ),
        ),
      ),
    );
  }
}

class LoadedProduct extends StatelessWidget {
  const LoadedProduct({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    //print('PPPPPP: ${productModel.singleProduct.length}');
    if (productModel.singleProduct.isNotEmpty) {
      return CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          const SliverAppBar(
            floating: false,
            expandedHeight: 55.0,
            toolbarHeight: 55.0,
            backgroundColor: blackColor,
            automaticallyImplyLeading: false,
            pinned: true,
            title: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                Language.myShop,
                style: TextStyle(color: whiteColor),
              ),
            ),
            // centerTitle: true,
            // titleSpacing: 30.0,
            // flexibleSpace: FlexibleSpaceBar(
            //   centerTitle: false,
            //   title: Text(
            //     Language.myShop,
            //     style: TextStyle(color: blackColor),
            //   ),
            // ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20.0)),
          SliverToBoxAdapter(
            child: Container(
              height: 48.0,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
              // color: Utils.dynamicPrimaryColor(context),
              child: ElevatedButton.icon(
                style: ButtonStyle(
                    elevation: WidgetStateProperty.all(0.0),
                    splashFactory: NoSplash.splashFactory,
                    backgroundColor: WidgetStateProperty.all(
                        Utils.dynamicPrimaryColor(context))),
                onPressed: () =>
                    Navigator.pushNamed(context, RouteNames.storeProductScreen),
                icon: const Icon(
                  Icons.file_upload_outlined,
                  color: blackColor,
                ),
                label: const Text(
                  Language.uploadProduct,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0,
                    color: blackColor,
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(defaultPadding),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Text(
                    Language.shopInformation,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                      color: blackColor,
                    ),
                  ),
                  const SizedBox(width: 15.0),
                  Expanded(
                    child: Container(
                      height: 45.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: PrimaryButton(
                          text: 'Pending Product',
                          padding: Utils.all(),
                          fontSize: 12.0,
                          fontWeigh: FontWeight.w400,
                          minimumSize: const Size(double.infinity, 40.0),
                          bgColor: blackColor,
                          textColor: whiteColor,
                          onPressed: () => Navigator.pushNamed(
                              context, RouteNames.pendingProductScreen)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SingleProductCard(product: productModel.singleProduct),
          const SliverToBoxAdapter(child: SizedBox(height: 100.0)),
        ],
      );
    } else {
      return const EmptyProductButton();
    }
  }

  Widget buildTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
        isDense: false,
        isCollapsed: false,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        enabled: false,
        filled: true,
        fillColor: Colors.transparent,
        hintText: Language.searchProduct,
        hintStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w400, fontSize: 14.0, color: grayColor),
        prefixIcon: const Padding(
          padding: EdgeInsets.only(top: 5.0),
          child: Icon(
            Icons.search,
            color: grayColor,
            size: 20.0,
          ),
        ),
      ),
    );
  }
}
