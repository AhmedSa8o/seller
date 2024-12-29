import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';
import '../../../utils/loading_widget.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/error_text.dart';
import '../../../widgets/primary_button.dart';
import '../controller/account_info/account_info_cubit.dart';
import '../controller/create_withdraw/create_withdraw_cubit.dart';
import '../controller/create_withdraw/create_withdraw_state_model.dart';
import '../model/account_info_model.dart';

class WithdrawDialog extends StatelessWidget {
  const WithdrawDialog({super.key});

  final _className = 'WithdrawDialog';

  @override
  Widget build(BuildContext context) {
    final withdrawCubit = context.read<CreateWithdrawCubit>();
    final accountCubit = context.read<AccountInfoCubit>();
    final methodList = context.read<AccountInfoCubit>().accountInfo;
    return Dialog(
insetPadding: Utils.symmetric(h:15.0),
      child: MultiBlocListener(
        listeners: [
          BlocListener<CreateWithdrawCubit, CreateWithdrawStateModel>(
            listener: (_, state) {
              final withdraw = state.withdrawState;
              if (withdraw is CreateWithdrawError) {
                Navigator.of(context).pop(true);
                Utils.errorSnackBar(context, withdraw.message);
              } else if (withdraw is CreateWithdrawLoaded) {
                Navigator.of(context).pop(true);
                Utils.showSnackBar(context, withdraw.message);
              }
            },
          ),
          BlocListener<AccountInfoCubit, AccountInfoState>(
            listener: (context, state) {
              if (state is AccountInfoLoading) {
                log(state.toString(), name: _className);
              } else if (state is AccountInfoError) {
                Utils.errorSnackBar(context, state.message);
              } else if (state is AccountInfoLoaded) {
                print('account loaded...');
                // showDialog<void>(
                //   context: context,
                //   barrierDismissible: true,
                //   builder: (BuildContext dialogContext) {
                //     return AccountInfoDialog(accountInfo: state.accountInfo);
                //   },
                // );
                accountInformationDialog(context, state.accountInfo);
              }
            },
          ),
        ],
        child: Padding(
          padding: Utils.symmetric(v: 26.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('New Withdraw'),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      withdrawCubit.clear();
                    },
                    child: const CustomImage(
                      path: KImages.cancel,
                      height: 15.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              BlocBuilder<CreateWithdrawCubit, CreateWithdrawStateModel>(
                builder: (context, state) {
                  final amount = state.withdrawState;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButtonFormField<AccountInfoModel>(
                        hint: const Text('Select Method'),
                        items: methodList
                            .map<DropdownMenuItem<AccountInfoModel>>(
                                (account) => DropdownMenuItem(
                                      value: account,
                                      child: Text(account.name),
                                    ))
                            .toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          withdrawCubit.changeMethodId(value.id.toString());
                          accountCubit.getAccountInformation(value.id.toString());
                        },
                        icon: const Icon(Icons.keyboard_arrow_down),
                        isDense: true,
                        isExpanded: true,
                      ),
                      if (amount is CreateWithdrawFormError) ...[
                        if (amount.errors.methodId.isNotEmpty)
                          ErrorText(text: amount.errors.methodId.first)
                      ]
                    ],
                  );
                },
              ),
              const SizedBox(height: 14.0),
              BlocBuilder<CreateWithdrawCubit, CreateWithdrawStateModel>(
                builder: (context, state) {
                  final amount = state.withdrawState;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration:
                            const InputDecoration(hintText: 'Withdraw Amount'),
                        keyboardType: TextInputType.number,
                        initialValue: state.withdrawAmount,
                        onChanged: (String amount) =>
                            withdrawCubit.changeAmount(amount),
                      ),
                      if (amount is CreateWithdrawFormError) ...[
                        if (amount.errors.withdrawAmount.isNotEmpty)
                          ErrorText(text: amount.errors.withdrawAmount.first)
                      ]
                    ],
                  );
                },
              ),
              const SizedBox(height: 14.0),
              BlocBuilder<CreateWithdrawCubit, CreateWithdrawStateModel>(
                builder: (context, state) {
                  final amount = state.withdrawState;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Account Information'),
                        keyboardType: TextInputType.text,
                        initialValue: state.accountInfo,
                        onChanged: (String amount) =>
                            withdrawCubit.changeBankInfo(amount),
                        maxLines: 3,
                      ),
                      if (amount is CreateWithdrawFormError) ...[
                        if (amount.errors.accountInfo.isNotEmpty)
                          ErrorText(text: amount.errors.accountInfo.first)
                      ]
                    ],
                  );
                },
              ),
              const SizedBox(height: 14.0),
              BlocBuilder<CreateWithdrawCubit, CreateWithdrawStateModel>(
                builder: (context, state) {
                  final amount = state.withdrawState;
                  if (amount is CreateWithdrawLoading) {
                    return LoadingWidget();
                  }
                  return PrimaryButton(
                    onPressed: () {
                      Utils.closeKeyBoard(context);
                      withdrawCubit.createWithdrawMethod();
                    },
                    text: 'Withdraw',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  accountInformationDialog(BuildContext context, AccountInfoModel accountInfo) {
    const space = SizedBox(height: 8.0);
    return Utils.showCustomDialog(
      context,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  accountInfo.name,
                  style: const TextStyle(fontSize: 20.0,color: blackColor),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const CustomImage(
                    path: KImages.cancel,
                    height: 15.0,
                  ),
                ),
              ],
            ),
            Container(
              height: 1.0,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              color: const Color(0xFFE3E3E3),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Min Amount'),
                Text(
                  Utils.formatAmount(context, accountInfo.minAmount),
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0,
                    color: blackColor,
                  ),
                ),
              ],
            ),
            space,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Max Amount'),
                Text(
                  Utils.formatAmount(context, accountInfo.maxAmount),
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0,
                    color: blackColor,
                  ),
                ),
              ],
            ),
            space,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Withdraw Charge'),
                Text(
                  '${accountInfo.withdrawCharge}%',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    fontSize: 16.0,
                    color: blackColor,
                  ),
                ),
              ],
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              margin: const EdgeInsets.symmetric(vertical: 6.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(color: borderColor)),
              child: Html(
                data: accountInfo.description,
                style: {
                  "p": Style(
                      color: blackColor,
                      padding: HtmlPaddings.zero,
                      margin: Margins.zero,
                      textAlign: TextAlign.start,
                      lineHeight: LineHeight.em(1.2),
                      whiteSpace: WhiteSpace.normal)
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
