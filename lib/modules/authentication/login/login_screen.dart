import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/routes/routes_names.dart';
import '/utils/constants.dart';
import '/utils/k_images.dart';
import '/utils/utils.dart';
import '/widgets/custom_image.dart';
import '../../../core/remote_urls.dart';
import '../../on_boarding/controller/setting_cubit.dart';
import '../component/input_form_widget.dart';
import 'login_bloc/login_bloc.dart';
import 'model/login_state_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  final String _className = 'LoginScreen';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final settingCubit = context.read<SettingCubit>();
    //print('colorrrrrrrrrr ${settingCubit.settingModel!.themeOne}');
    return Scaffold(
      backgroundColor: whiteColor,
      body: WillPopScope(
        onWillPop: () async {
          Utils.exitFromAppDialog(context);
          return true;
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: BlocListener<LoginBloc, LoginStateModel>(
              listener: (context, state) {
                final s = state.loginState;
                if (s is LoginStateLoading) {
                  log(_className, name: s.toString());
                } else if (s is LoginStateError) {
                  Utils.errorSnackBar(context, s.message);
                } else if (s is LoginStateLoaded) {
                  // Navigator.pushReplacementNamed(
                  //     context, RouteNames.dashBoardScreen);
                  //Navigator.pushReplacementNamed(context, RouteNames.homeScreen);
                  Navigator.pushNamedAndRemoveUntil(
                      context, RouteNames.homeScreen, (route) => false);
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.14),
                  SizedBox(
                    height: 80.0,
                    width: 200.0,
                    child: CustomImage(
                      path: RemoteUrls.imageUrl(
                              settingCubit.settingModel!.setting.logo) ??
                          KImages.logo,
                    ),
                  ),
                  // const CustomImage(path: KImages.logo),
                  // const SizedBox(height: 5.0),
                  // const Text(
                  //   Language.mottoText,
                  //   style: TextStyle(
                  //     color: grayColor,
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                  SizedBox(height: size.height * 0.05),
                  const InputFormWidget(),
                  // TextButton(
                  //   onPressed: () => debugPrint('create store'),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: const [
                  //       Text(
                  //         Language.createStore,
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.w700,
                  //           fontSize: 18.0,
                  //           color: greenColor,
                  //           decoration: TextDecoration.underline,
                  //           decorationThickness: 2.0,
                  //         ),
                  //       ),
                  //       Icon(
                  //         Icons.arrow_forward,
                  //         color: greenColor,
                  //       )
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
