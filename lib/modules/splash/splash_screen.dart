import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_text_reveal/random_text_reveal.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../authentication/login/internet_status/internet_status_bloc.dart';
import '../on_boarding/controller/currency/currency_cubit.dart';
import '/modules/authentication/login/login_bloc/login_bloc.dart';
import '/utils/k_images.dart';
import '/widgets/custom_image.dart';
import '../../core/routes/routes_names.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../on_boarding/controller/setting_cubit.dart';

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({super.key});

  @override
  State<AnimatedSplashScreen> createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    initializeController();
    getSaveData();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> getSaveData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final email = pref.getString('email') ?? '';
    final password = pref.getString('password') ?? '';
    print('SavedEmail: $email');
    print('SavedPassword: $password');
  }

  initializeController() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeOut);
    controller.addListener(() {
      if (mounted) setState(() {});
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final loginBloc = context.read<LoginBloc>();
    final settingCubit = context.read<SettingCubit>();
    final cCubit = context.read<CurrencyCubit>();
    return WillPopScope(
      onWillPop: () async {
        Utils.exitFromAppDialog(context);
        return true;
      },
      child: Scaffold(
        body: MultiBlocListener(
          listeners: [
            BlocListener<InternetStatusBloc, InternetStatusState>(
              listener: (context, state) {
                if (state is InternetStatusBackState) {
                  // Utils.showSnackBar(context, state.message);
                  settingCubit.getSetting();
                } else if (state is InternetStatusLostState) {
                  print('no internet');
                  Utils.showSnackBar(context, state.message);
                }
              },
            ),
            BlocListener<SettingCubit, SettingState>(
              listener: (_, state) {
                if (state is SettingStateLoaded) {
                  print('isLoginTrue ${loginBloc.isLoggedIn}');
                  // MyCustomTheme.dynamicColor = Utils.dynamicPrimaryColor(context);
                  if (cCubit.state.currencies.isNotEmpty) {
                    cCubit.state.currencies.clear();
                  }
                  if (settingCubit.settingModel != null &&
                      settingCubit.settingModel!.currencies.isNotEmpty) {
                    final currency = settingCubit.settingModel!.currencies;
                    for (int i = 0; i < currency.length; i++) {
                      if (currency[i].isDefault.toLowerCase() == 'yes' &&
                          currency[i].status == 1) {
                        cCubit.addNewCurrency(currency[i]);
                      }
                    }
                  }
                  if (state.settingModel.maintainTextModel != null &&
                      state.settingModel.maintainTextModel!.status == 0) {
                    if (loginBloc.isLoggedIn) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, RouteNames.homeScreen, (route) => false);
                    } else if (settingCubit.showOnBoarding) {
                      debugPrint('skip onboarding....');
                      Navigator.pushNamedAndRemoveUntil(
                          context, RouteNames.loginScreen, (route) => false);
                    } else {
                      debugPrint('show on boarding');
                      Navigator.pushNamedAndRemoveUntil(context,
                          RouteNames.onBoardingScreen, (route) => false);
                    }
                  } else {
                    Navigator.pushNamedAndRemoveUntil(
                        context, RouteNames.maintainScreen, (route) => false);
                  }
                } else if (state is SettingStateError) {
                  Utils.errorSnackBar(context, state.message);
                }
              },
            ),
          ],
          child: _splashView(size, context),
        ),
      ),
    );
  }

  Widget _splashView(Size size, BuildContext context) {
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Stack(
        children: [
          Positioned(
            // left: 0.0,
            // top: -20.0,
            child: CustomImage(
              path: KImages.splashIcon01,
              height: animation.value * 300,
            ),
          ),
          Positioned(
            bottom: 100.0,
            left: 0.0,
            right: 0.0,
            child: CustomImage(
              path: KImages.splashIcon02,
              width: animation.value * 140,
            ),
          ),
          Positioned(
            bottom: 60.0,
            left: MediaQuery.of(context).size.width / 3.5,
            // right: 40.0,
            // alignment: Alignment.bottomCenter,
            child: RandomTextReveal(
              text: 'ShopO Seller App',
              duration: const Duration(seconds: 3),
              style: GoogleFonts.nunito(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
                color: grayColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SplashWidget extends StatelessWidget {
  const SplashWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      height: size.height,
      width: size.width,
      child: const CustomImage(
        path: KImages.celove,
      ),
    );
  }
}
