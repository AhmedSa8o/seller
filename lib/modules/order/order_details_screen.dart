import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/page_refresh.dart';
import '/modules/order/model/order_models.dart';
import '../../utils/constants.dart';
import '../../utils/loading_widget.dart';
import '../../utils/utils.dart';
import '../dashboard/model/today_model/today_order_product.dart';
import 'component/order_details_bottom.dart';
import 'controller/orders_cubit/orders_cubit.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key, required this.id});

  final String id;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrdersCubit>().getSingleOrderDetailsProduct(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    // final orderCubit = context.read<SellerOrderCubit>();
    return Scaffold(
        backgroundColor: const Color(0xFFF8F8F8),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: whiteColor),
            title: const Text('Order Details',
                style: TextStyle(color: whiteColor)),
            backgroundColor: blackColor),
        body: PageRefresh(
          onRefresh: () async {
            context.read<OrdersCubit>().getSingleOrderDetailsProduct(widget.id);
          },
          child: BlocConsumer<OrdersCubit, OrdersState>(
            listener: (_, state) {},
            builder: (_, state) {
              if (state is OrderStateLoading) {
                return LoadingWidget();
              } else if (state is OrderStateError) {
                if (state.statusCode == 503) {
                  //return LoadedOrderDetails(orders: orderCubit.orderModel!);
                } else {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: redColor),
                    ),
                  );
                }
              } else if (state is OrderDetailsProductLoaded) {
                return LoadedOrderDetails(orders: state.orders);
              }
              return const Center(
                child: Text('Something went wrong'),
              );
            },
          ),
        ),
        bottomNavigationBar: const BottomOrderDetails());
  }
}

class LoadedOrderDetails extends StatefulWidget {
  const LoadedOrderDetails({super.key, required this.orders});

  final OrderModel orders;

  @override
  State<LoadedOrderDetails> createState() => _LoadedOrderDetailsState();
}

class _LoadedOrderDetailsState extends State<LoadedOrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100.0,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      //padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 14.0),
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: Utils.borderRadius(r: 12.0),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0.0, 0.0),
                spreadRadius: 0.0,
                blurRadius: 0.0,
                // color: whiteColor
                color: const Color(0xFF000000).withOpacity(0.4)),
          ]),
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        shrinkWrap: true,
        children: [
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                '${widget.orders.orderProducts.length.toString()} Item Order'
                    .padLeft(2, '0'),
                style: const TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 18.0),
              )),
          ListView.builder(
            itemCount: widget.orders.orderProducts.length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            itemBuilder: (context, index) {
              final e = widget.orders.orderProducts[index];
              return Container(
                color: const Color(0xFFF8F8F8),
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      e.productName,
                      style: GoogleFonts.inter(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: blackColor,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(Utils.formatAmount(context, e.unitPrice),
                        style: GoogleFonts.inter(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: redColor,
                        )),
                    const SizedBox(height: 4.0),
                    Text.rich(TextSpan(children: [
                      const TextSpan(text: 'Quantity: '),
                      TextSpan(
                          text: e.quantity.toString().padLeft(2, '0'),
                          style: GoogleFonts.inter(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            color: blackColor,
                          ))
                    ])),
                    // Text()
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  ExpansionPanelList buildExpansionPanelList() {
    return ExpansionPanelList(
      expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 15.0),
      expansionCallback: ((panelIndex, isExpanded) {
        widget.orders.orderProducts.asMap().forEach((key, value) {
          widget.orders.orderProducts[key] =
              widget.orders.orderProducts[key].copyWith(isExpanded: false);
        });
        widget.orders.orderProducts[panelIndex] = widget
            .orders.orderProducts[panelIndex]
            .copyWith(isExpanded: !isExpanded);
        setState(() {});
      }),
      // expandedHeaderPadding: EdgeInsets.zero,
      // dividerColor: borderColor.withOpacity(.4),
      elevation: 0,
      children: widget.orders.orderProducts
          .map(
            (SingleOrderedProductModel product) => ExpansionPanel(
              isExpanded: product.isExpanded,
              canTapOnHeader: true,
              headerBuilder: (context, bool expand) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      Text(
                        product.productName,
                        style: GoogleFonts.inter(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          color: blackColor,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(Utils.formatAmount(context, product.unitPrice),
                          style: GoogleFonts.inter(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: blackColor,
                          )),
                      const SizedBox(height: 4.0),
                      Text.rich(TextSpan(children: [
                        const TextSpan(text: 'Quantity: '),
                        TextSpan(
                            text: product.quantity.toString().padLeft(2, '0'),
                            style: GoogleFonts.inter(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                              color: blackColor,
                            ))
                      ]))
                    ],
                  ),
                );
              },
              body: const SizedBox(),
              // body: Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     // crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(product.productName),
              //     ],
              //   ),
              // ),
            ),
          )
          .toList(),
    );
  }

  Container buildContainer(SingleOrderedProductModel product) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Text(product.productName));
  }
}
