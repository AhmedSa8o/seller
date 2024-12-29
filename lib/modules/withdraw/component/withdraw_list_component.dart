import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/modules/withdraw/model/withdraw_model.dart';
import '/utils/status_code_string.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';

class WithdrawListComponent extends StatelessWidget {
  const WithdrawListComponent({super.key, required this.withdrawModel});
  final List<WithdrawModel> withdrawModel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)
            .copyWith(bottom: 0.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Withdraws',
              style: GoogleFonts.roboto(
                fontSize: 22.0,
                fontWeight: FontWeight.w500,
                color: blackColor,
              ),
            ),
            const SizedBox(height: 20.0),
            withdrawModel.isEmpty
                ? Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(vertical: 30.0),
                    child: const Text(
                      'No Withdraw List Found 😒',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: redColor,
                          fontSize: 20.0),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: withdrawModel.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final result = withdrawModel[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Utils.formatAmount(
                                      context, result.totalAmount),
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22.0,
                                    color: blackColor,
                                  ),
                                ),
                                Text(
                                  Utils.formatDate(result.createdAt),
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0,
                                    color: grayColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Transferred Amount',
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0,
                                    color: grayColor,
                                  ),
                                ),
                                Container(
                                  height: 35.0,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 4.0),
                                  decoration: BoxDecoration(
                                    color: AllStatusCode.getBackgroundColor(
                                        result.status.toString()),
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 4.0),
                                    child: Text(
                                      result.status == 0
                                          ? 'Pending'
                                          : 'Success',
                                      style: GoogleFonts.roboto(
                                        color: AllStatusCode.getTextColor(
                                            result.status.toString()),
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 1.0,
                              width: double.infinity,
                              margin:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              color: index == withdrawModel.length - 1
                                  ? transparent
                                  : grayColor.withOpacity(0.1),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
