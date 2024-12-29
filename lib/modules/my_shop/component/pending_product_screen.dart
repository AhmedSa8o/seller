import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/page_refresh.dart';
import '/modules/my_shop/component/single_product_card.dart';
import '/modules/order/model/product_model.dart';
import '/utils/constants.dart';
import '/utils/loading_widget.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../order/controller/orders_cubit/orders_cubit.dart';
import '../../order/controller/pending_product/pending_product_cubit.dart';
import '../../store_product/controller/store_product_bloc/store_product_bloc.dart';
import '../../store_product/model/store_product_state_model.dart';

class PendingProductScreen extends StatefulWidget {
  const PendingProductScreen({super.key});

  @override
  State<PendingProductScreen> createState() => _PendingProductScreenState();
}

class _PendingProductScreenState extends State<PendingProductScreen> {
  final _className = "PendingProductScreen";

  @override
  Widget build(BuildContext context) {
    final pendingCubit = context.read<PendingProductCubit>();
    pendingCubit.getAllPendingProduct();
    return Scaffold(
      // appBar: AppBar(title: const Text('All Pending Product'),
      //   backgroundColor: Utils.dynamicPrimaryColor(context)),
      body: PageRefresh(
        onRefresh: ()async{
          pendingCubit.getAllPendingProduct();
        },
        child: MultiBlocListener(
          listeners: [
            BlocListener<PendingProductCubit, PendingProductState>(
                listener: (_, state) {}),
            BlocListener<StoreProductBloc, StoreProductStateModel>(
              listener: (_, state) {
                final status = state.state;
                if (status is StoreProductLoading) {
                  log(status.toString(), name: _className);
                } else if (status is StoreProductLoadError) {
                  if (status.statusCode == 503) {
                    Utils.serviceUnAvailable(context, status.message);
                  } else {
                    Utils.errorSnackBar(context, status.message);
                  }
                } else if (status is StoreProductStatusUpdated) {
                  Utils.showSnackBar(context, status.message);
                  context.read<PendingProductCubit>().getAllPendingProduct();
                }
              },
            ),
            BlocListener<OrdersCubit, OrdersState>(listener: (_, state) {
              if (state is DeletedSingleProduct) {
                context.read<PendingProductCubit>().getAllPendingProduct();
              }
            }),
          ],
          child: BlocBuilder<PendingProductCubit, PendingProductState>(
              builder: (_, state) {
            if (state is PendingProductInitial ||
                state is PendingProductLoading) {
              return LoadingWidget();
            } else if (state is PendingProductError) {
              if (state.statusCode == 503) {
                return LoadedPendingProduct(product: pendingCubit.productModel!);
              } else {
                return Center(child: Text(state.message));
              }
            } else if (state is PendingProductLoaded) {
              return LoadedPendingProduct(product: state.product);
            }
            return const Center(child: Text('Something went wrong'));
          }),
        ),
      ),
    );
  }
}

class LoadedPendingProduct extends StatelessWidget {
  const LoadedPendingProduct({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const SliverAppBar(
          backgroundColor: blackColor,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'All Pending Product',
              style: TextStyle(color: whiteColor),
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 20.0),
        ),
        product.singleProduct.isNotEmpty
            ? SingleProductCard(product: product.singleProduct)
            : SliverToBoxAdapter(
                child: Container(
                  height: size.height * 0.7,
                  width: size.width,
                  alignment: Alignment.center,
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomImage(
                        path: KImages.emptyOrder,
                      ),
                      SizedBox(height: 20.0),
                      Text('No Product Available!')
                    ],
                  ),
                ),
              ),
        const SliverToBoxAdapter(child: SizedBox(height: 20.0))
      ],
    );
  }
}
