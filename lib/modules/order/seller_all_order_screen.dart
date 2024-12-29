import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/page_refresh.dart';
import '/modules/order/controller/seller_all_orders/seller_order_cubit.dart';
import '/utils/constants.dart';
import '/utils/loading_widget.dart';
import '../../utils/utils.dart';
import 'component/empty_order.dart';
import 'component/single_order_component.dart';

class SellerAllOrderScreen extends StatelessWidget {
  const SellerAllOrderScreen({super.key});

  final _className = 'SellerAllOrderScreen';

  @override
  Widget build(BuildContext context) {
    context.read<SellerOrderCubit>().getSellerAllOrders();
    context.read<SellerOrderCubit>().getSellerPendingOrders();
    context.read<SellerOrderCubit>().getSellerProgressOrders();
    context.read<SellerOrderCubit>().getSellerDeliveredOrders();
    context.read<SellerOrderCubit>().getSellerCompletedOrders();
    context.read<SellerOrderCubit>().getSellerDeclinedOrders();
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        title: const Text('All Orders', style: TextStyle(color: whiteColor)),
        backgroundColor: blackColor,
        automaticallyImplyLeading: false,
      ),
      body: PageRefresh(
        onRefresh: () async {
          context.read<SellerOrderCubit>().getSellerAllOrders();
          context.read<SellerOrderCubit>().getSellerPendingOrders();
          context.read<SellerOrderCubit>().getSellerProgressOrders();
          context.read<SellerOrderCubit>().getSellerDeliveredOrders();
          context.read<SellerOrderCubit>().getSellerCompletedOrders();
          context.read<SellerOrderCubit>().getSellerDeclinedOrders();
        },
        child: BlocConsumer<SellerOrderCubit, SellerOrderState>(
          listener: (_, state) {
            if (state is SellerOrderStateLoading) {
              log(state.toString(), name: _className);
            }
            if (state is SellerOrderStateLoaded) {
              log(state.toString(), name: _className);
            }
            if (state is SellerOrderStateError) {
              if (state.statusCode == 503) {
                Utils.serviceUnAvailable(context, state.message);
              }
            }
          },
          builder: (_, state) {
            if (state is SellerOrderStateLoading) {
              return LoadingWidget();
            } else if (state is SellerOrderStateError) {
              if (state.statusCode == 503) {
                return Container();
              } else {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: redColor),
                  ),
                );
              }
            } else if (state is SellerOrderStateLoaded) {
              return const SellerOrderLoaded();
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class SellerOrderLoaded extends StatefulWidget {
  const SellerOrderLoaded({super.key});

  @override
  State<SellerOrderLoaded> createState() => _SellerOrderLoadedState();
}

class _SellerOrderLoadedState extends State<SellerOrderLoaded> {
  int _currentIndex = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final sellerOrders = [
      context.read<SellerOrderCubit>().sellerOrders,
      context.read<SellerOrderCubit>().pendingOrders,
      context.read<SellerOrderCubit>().progressOrders,
      context.read<SellerOrderCubit>().deliveredOrders,
      context.read<SellerOrderCubit>().completedOrders,
      context.read<SellerOrderCubit>().declinedOrders,
    ];
    final items = [
      context.read<SellerOrderCubit>().sellerOrders!.orders!.data.length,
      context.read<SellerOrderCubit>().pendingOrders!.orders!.data.length,
      context.read<SellerOrderCubit>().progressOrders!.orders!.data.length,
      context.read<SellerOrderCubit>().deliveredOrders!.orders!.data.length,
      context.read<SellerOrderCubit>().completedOrders!.orders!.data.length,
      context.read<SellerOrderCubit>().declinedOrders!.orders!.data.length,
    ];

    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 10.0)),
        SliverToBoxAdapter(
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: Utils.symmetric(h: 10.0, v: 5.0),
            padding: Utils.symmetric(v: 10.0, h: 10.0),
            color: whiteColor,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              child: Row(
                children: List.generate(sellerOrders.length, (index) {
                  bool active = _currentIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentIndex = index;
                      });
                      _scrollToIndex(index);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(microseconds: 800),
                      height: 46.0,
                      alignment: Alignment.center,
                      // margin:  EdgeInsets.only( right:  index==sellerOrders.length -1 ?0.0: 10.0),
                      decoration: BoxDecoration(
                        color: active ? blackColor : transparent,
                        borderRadius: Utils.borderRadius(r: 6.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          '${sellerOrders[index]!.title} (${items[index]})',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0,
                            color: !active ? textGreyColor : whiteColor,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
        items[_currentIndex] == 0
            ? const EmptyOrderComponent()
            : SingleOrderComponent(orders: sellerOrders[_currentIndex]!),
        const SliverToBoxAdapter(child: SizedBox(height: 30.0)),
      ],
    );
  }

  void _scrollToIndex(int index) {
    const itemWidth = 200.0;
    final screenWidth = MediaQuery.of(context).size.width;

    final offset = index * itemWidth - (screenWidth - itemWidth) / 2;

    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
