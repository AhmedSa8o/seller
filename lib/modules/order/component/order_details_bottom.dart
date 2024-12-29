import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seller_app/utils/utils.dart';

import '/modules/order/controller/orders_cubit/orders_cubit.dart';
import '../../../utils/constants.dart';

class BottomOrderDetails extends StatelessWidget {
  const BottomOrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        if (state is OrderStateLoaded) {
          return const Center(
            child: Text('Loading....'),
          );
        }
        if (state is OrderDetailsProductLoaded) {
          final order = state.orders;
          return Card(
            elevation: 10.0,
            margin: EdgeInsets.zero,
            child: Container(
                height: 220.0,
                width: double.infinity,
                // color: Colors.red,
                padding: const EdgeInsets.only(top: 10.0),
                margin: const EdgeInsets.symmetric(horizontal: 20.0)
                    .copyWith(top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bill Details',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: const Color(0xFF0B2C3D),
                        )),
                    const SizedBox(height: 12.0),
                    _billInfo(
                        'SubTotal',
                        Utils.formatAmount(
                            context, order.totalAmount.toStringAsFixed(2)),
                        const Color(0xFF2E2E2E),
                        const Color(0xFF2E2E2E)),
                    const SizedBox(height: 12.0),
                    _billInfo(
                        'Coupon Coast',
                        Utils.formatAmount(
                            context, order.couponCoast.toStringAsFixed(2)),
                        const Color(0xFF2E2E2E),
                        const Color(0xFF2E2E2E)),
                    // _billInfo(
                    //     'Coupon Coast',
                    //     '\$${double.parse(order.couponCoast).toStringAsFixed(2)}',
                    //     redColor,
                    //     redColor),
                    const SizedBox(height: 12.0),
                    _billInfo(
                        'Delivery Cost',
                        Utils.formatAmount(
                            context, order.shippingCost.toStringAsFixed(2)),
                        const Color(0xFF2E2E2E),
                        greenColor),
                    const SizedBox(height: 20.0),
                    const DottedLine(
                      dashColor: blackColor,
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0,
                              color: const Color(0xFF2E2E2E)),
                        ),
                        Text(
                          Utils.formatAmount(context, order.totalAmount),
                          style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0,
                              color: const Color(0xFF2E2E2E)),
                        ),
                      ],
                    ),
                    // _billInfo(
                    //     'Total',
                    //     '\$${double.parse(order.totalAmount).toStringAsFixed(2)}',
                    //     const Color(0xFF2E2E2E),
                    //     const Color(0xFF2E2E2E)),
                    // _billInfo(
                    //     'Discount',
                    //     '\$${order.discountPrice.toStringAsFixed(2)}',
                    //     redColor,
                    //     redColor),
                  ],
                )),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _billInfo(String title, String price, Color color, Color color2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textStyle(color),
        ),
        Text(
          price,
          style: textStyle(color2),
        ),
      ],
    );
  }

  textStyle(Color color) {
    return GoogleFonts.roboto(
        fontWeight: FontWeight.w400, fontSize: 16.0, color: color);
  }

  totalAmountStyle() {
    return GoogleFonts.roboto(
        fontWeight: FontWeight.w700,
        fontSize: 18.0,
        color: const Color(0xFF2E2E2E));
  }
}
