import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/routes/routes_names.dart';
import '../../utils/constants.dart';
import '../../utils/k_images.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/custom_text_style.dart';
import '../../widgets/primary_button.dart';
import 'password/password_cubit.dart';
import 'password/password_state_model.dart';

class UpdatePasswordScreen extends StatelessWidget {
  const UpdatePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final passwordCubit = context.read<PasswordCubit>();
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        physics: const BouncingScrollPhysics(),
        // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          SizedBox(height: size.height * 0.1),
          const CustomImage(path: KImages.forgotPassword),
          const SizedBox(height: 20.0),
          const LeagueSpartanTextStyle(
              text: 'Update Password',
              fontSize: 36.0,
              fontWeight: FontWeight.w700,
              color: blackColor),
          const SizedBox(height: 20.0),
          BlocBuilder<PasswordCubit, PasswordStateModel>(
            buildWhen: (pre, current) {
              print('pre ${pre.password}');
              print('current ${current.password}');
              return pre.passwordState != current.passwordState;
            },
            builder: (context, state) {
              return TextFormField(
                decoration: InputDecoration(
                  hintText: 'New Password',
                  suffixIcon: IconButton(
                    onPressed: () =>
                        passwordCubit.showPassword(state.showPassword),
                    icon: Icon(
                      state.showPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    color: blackColor,
                    splashRadius: 18.0,
                  ),
                ),
                initialValue: state.password,
                onChanged: (String text) => passwordCubit.passwordChange(text),
                keyboardType: TextInputType.visiblePassword,
                obscureText: state.showPassword,
              );
            },
          ),
          const SizedBox(height: 16.0),
          BlocBuilder<PasswordCubit, PasswordStateModel>(
            builder: (context, state) {
              return TextFormField(
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  suffixIcon: IconButton(
                    onPressed: () => passwordCubit
                        .showConfirmPassword(state.showConfirmPassword),
                    icon: Icon(
                      state.showConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    color: blackColor,
                    splashRadius: 18.0,
                  ),
                ),
                initialValue: state.confirmPassword,
                onChanged: (String text) =>
                    passwordCubit.confirmPasswordChange(text),
                keyboardType: TextInputType.visiblePassword,
                obscureText: state.showConfirmPassword,
              );
            },
          ),
          const SizedBox(height: 20.0),
          PrimaryButton(
            text: 'Update Password',
            onPressed: () => updatePassword(context),
          )
        ],
      ),
    );
  }

  updatePassword(BuildContext context) {
    return Utils.showCustomDialog(context,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 14.0, vertical: defaultPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomImage(path: KImages.done),
              const LeagueSpartanTextStyle(
                  text: 'Success',
                  fontSize: 30.0,
                  fontWeight: FontWeight.w700,
                  color: blackColor),
              const LeagueSpartanTextStyle(
                  text: 'Password changed successfully',
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: blackColor),
              const SizedBox(height: 20.0),
              PrimaryButton(
                text: 'Back to Login',
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamedAndRemoveUntil(
                      context, RouteNames.loginScreen, (route) => false);
                },
              )
            ],
          ),
        ));
  }
}
