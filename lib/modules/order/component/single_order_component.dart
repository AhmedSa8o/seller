import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/modules/dashboard/model/today_order_model.dart';
import '/modules/order/model/seller_all_order_model.dart';
import '/utils/language_string.dart';
import '/utils/status_code_string.dart';
import '/widgets/primary_button.dart';
import '../../../core/routes/routes_names.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';

class SingleOrderComponent extends StatelessWidget {
  const SingleOrderComponent({super.key, required this.orders});
  final SellerAllOrdersModel orders;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final result = orders.orders!.data[index];
          return Container(
            // height: 280.0,
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0)
                    .copyWith(bottom: 10.0),
            margin:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                topSection(result, context),
                middleSection(result, context),
                lastSection(result),
                const SizedBox(height: 6.0),
                PrimaryButton(
                  text: Language.details,
                  onPressed: () => Navigator.pushNamed(
                    context,
                    RouteNames.orderDetailsScreen,
                    arguments: result.id.toString(),
                  ),
                  minimumSize: const Size(double.infinity, 44.0),
                  bgColor: blackColor,
                  textColor: whiteColor,
                )
              ],
            ),
          );
        },
        childCount: orders.orders!.data.length,
      ),
    );
  }

  Widget lastSection(TodayOrderedModel result) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              Language.orderStatus,
              style: GoogleFonts.inter(
                fontSize: 16.0,
                color: grayColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            Chip(
              label: Text(
                AllStatusCode.getOrderStatus(result.orderStatus),
                style: const TextStyle(color: redColor),
              ),
              shape: RoundedRectangleBorder(side: const BorderSide(color: transparent),borderRadius: Utils.borderRadius(r: 2.0)),
              backgroundColor: const Color(0xFFFEEEEE),
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(Language.paymentStatus,
                style: GoogleFonts.inter(
                  fontSize: 16.0,
                  color: grayColor,
                  fontWeight: FontWeight.w400,
                )),
            Chip(
              label: Text(
                AllStatusCode.getPaymentStatus(result.paymentStatus),
                style: const TextStyle(color: greenColor),
              ),
              shape: RoundedRectangleBorder(side: const BorderSide(color: transparent),borderRadius: Utils.borderRadius(r: 2.0)),
              backgroundColor: greenColor.withOpacity(0.16),
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            )
          ],
        ),
      ],
    );
  }

  Widget middleSection(TodayOrderedModel result, BuildContext context) {
    return Container(
      // height: 64.0,
      margin: const EdgeInsets.only(top: 12.0, bottom: 6.0),
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7E7),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Text(
              Language.amount,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
                color: grayColor,
              ),
            ),
            const SizedBox(height: 6.0),
            Text(Utils.formatAmount(context, result.totalAmount),
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                  color: blackColor,
                ))
          ]),
          Container(
            height: 55.0,
            width: 1.0,
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            color: blackColor.withOpacity(0.2),
          ),
          Column(children: [
            Text(
              Language.quantity,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
                color: grayColor,
              ),
            ),
            const SizedBox(height: 6.0),
            Text(result.productQuantity.toString().padLeft(2, '0'),
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                  color: blackColor,
                ))
          ]),
        ],
      ),
    );
  }

  Widget topSection(TodayOrderedModel result, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Utils.formatDate(result.createdAt),
              style: GoogleFonts.inter(
                fontSize: 16.0,
                color: grayColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 10.0),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: '${Language.orderId} :',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: blackColor,
                    ),
                  ),
                  TextSpan(
                    text: result.orderId,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Utils.dynamicPrimaryColor(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(Language.customerName,
                style: GoogleFonts.inter(
                  fontSize: 16.0,
                  color: grayColor,
                  fontWeight: FontWeight.w400,
                )),
            const SizedBox(height: 6.0),
            Text(
              result.user != null && result.user!.name.isNotEmpty? result.user!.name:'-----',
              style: GoogleFonts.inter(
                fontSize: 16.0,
                color: blackColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
