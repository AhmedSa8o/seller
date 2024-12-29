import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/k_images.dart';
import '../../widgets/confirm_dialog.dart';
import '/modules/dashboard/dashboard_screen.dart';
import '/modules/my_shop/my_shop_screen.dart';
import '../../utils/utils.dart';
import '../dashboard/controller/dashboard_cubit.dart';
import '../order/seller_all_order_screen.dart';
import '../withdraw/withdraw_screen.dart';
import 'component/bottom_navigation_bar.dart';
import 'component/main_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeController = MainController();
  late List<Widget> screenList;

  @override
  void initState() {
    super.initState();
    screenList = [
      const DashboardScreen(),
      const MyShopScreen(),
      const SellerAllOrderScreen(),
      const WithdrawScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final dCubit = context.read<DashboardCubit>();
    return WillPopScope(
      onWillPop: () async {
         showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) =>
              ConfirmDialog(
                icon: KImages.logout,
                message: 'Are you sure,\nyou want Exit?',
                confirmText: 'Yes, Exit',
                cancelText: 'Cancel',
                onTap: () async {
                 SystemNavigator.pop();
                },
              ),
        );
        return true;
      },
      child: Scaffold(
        body: StreamBuilder<int>(
          initialData: 0,
          stream: _homeController.naveListener.stream,
          builder: (context, AsyncSnapshot<int> snapshot) {
            int item = snapshot.data ?? 0;
            return screenList[item];
          },
        ),
        bottomNavigationBar: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            if (state is DashboardStateLoaded) {
              return const MyBottomNavigationBar();
            }
            if (dCubit.dashboardModel != null) {
              return const MyBottomNavigationBar();
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
