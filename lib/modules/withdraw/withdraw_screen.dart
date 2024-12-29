import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/page_refresh.dart';
import '/modules/dashboard/controller/dashboard_cubit.dart';
import '../../utils/constants.dart';
import '../../utils/k_images.dart';
import '../../utils/language_string.dart';
import '../../utils/loading_widget.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_image.dart';
import 'component/withdraw_dialog.dart';
import 'component/withdraw_list_component.dart';
import 'controller/account_info/account_info_cubit.dart';
import 'controller/create_withdraw/create_withdraw_cubit.dart';
import 'controller/create_withdraw/create_withdraw_state_model.dart';
import 'controller/withdraw_list/withdraw_list_cubit.dart';
import 'model/withdraw_model.dart';

class WithdrawScreen extends StatelessWidget {
  const WithdrawScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AccountInfoCubit>().getAllMethodList();
    print('methodList: ${context.read<AccountInfoCubit>().accountInfo}');
    final withdraw = context.read<WithdrawListCubit>();
    withdraw.getAllWithdrawList();
    final dashboard = context.read<DashboardCubit>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blackColor,
        // backgroundColor: Utils.dynamicPrimaryColor(context),
        title: const Text(
          'Wallet',
          style: TextStyle(color: whiteColor),
        ),
        automaticallyImplyLeading: false,
      ),
      body: PageRefresh(
        onRefresh: () async {
          // context.read<AccountInfoCubit>().getAllMethodList();
          withdraw.getAllWithdrawList();
        },
        child: BlocListener<CreateWithdrawCubit, CreateWithdrawStateModel>(
          listener: (context, state) {
            final createWithdraw = state.withdrawState;
            if (createWithdraw is CreateWithdrawLoaded) {
              withdraw.getAllWithdrawList();
            }
          },
          child: BlocBuilder<WithdrawListCubit, WithdrawListState>(
            builder: (context, state) {
              if (state is WithdrawListInitial ||
                  state is WithdrawListLoading) {
                return LoadingWidget();
              } else if (state is WithdrawListError) {
                if (state.statusCode == 503) {
                  return LoadedWithdraw(
                      dashboard: dashboard,
                      withdrawModel: withdraw.withdrawList);
                } else {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: redColor),
                    ),
                  );
                }
              } else if (state is WithdrawListLoaded) {
                return LoadedWithdraw(
                    dashboard: dashboard, withdrawModel: state.withdrawList);
              }
              return const Center(
                  child: Text('Something went wrong',
                      style: TextStyle(color: redColor)));
            },
          ),
        ),
      ),
    );
  }
}

class LoadedWithdraw extends StatelessWidget {
  const LoadedWithdraw(
      {super.key, required this.dashboard, required this.withdrawModel});

  final DashboardCubit dashboard;
  final List<WithdrawModel> withdrawModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _withdrawWidget(dashboard, context),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _earningCard('Current Balance', KImages.totalEarning,
                dashboard.dashboardModel!.todayEarning.toString(), context),
            const SizedBox(width: 14.0),
            _earningCard(Language.totalEarning, KImages.totalEarning,
                dashboard.dashboardModel!.totalEarning.toString(), context),
          ],
        ),
        WithdrawListComponent(withdrawModel: withdrawModel),
      ],
    );
  }

  Widget _withdrawWidget(DashboardCubit dashboard, BuildContext context) {
    return Container(
      height: 90.0,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
      decoration: BoxDecoration(
        color: Utils.dynamicPrimaryColor(context),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Language.currentBalance,
                style: GoogleFonts.inter(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF001B38).withOpacity(0.7)),
              ),
              const SizedBox(height: 4.0),
              Text(
                Utils.formatAmount(
                    context, dashboard.dashboardModel!.todayEarning),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 30.0,
                ),
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const WithdrawDialog(),
              );
            },
            child: Container(
              height: 40.0,
              width: 104.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: greenColor,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                Language.withdraw,
                style: GoogleFonts.inter(
                  color: whiteColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _earningCard(
      String title, String image, String earn, BuildContext context) {
    return Container(
      height: 140.0,
      width: 170.0,
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomImage(path: image),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                color: grayColor,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            Utils.formatAmount(context, earn),
            style: GoogleFonts.inter(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: blackColor,
            ),
          ),
        ],
      ),
    );
  }
}
