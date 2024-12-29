import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../../core/routes/routes_names.dart';
import '../../utils/constants.dart';
import '../../utils/k_images.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/custom_text_style.dart';
import 'password/password_cubit.dart';
import 'password/password_state_model.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final passwordCubit = context.read<PasswordCubit>();
    return Scaffold(
      body: BlocListener<PasswordCubit, PasswordStateModel>(
        listener: (context, state) {
          final password = state.passwordState;
          if (password is PasswordCodeLoading) {
            Utils.loadingDialog(context);
          } else {
            Utils.closeDialog(context);
            if (password is PasswordCodeError) {
              Utils.errorSnackBar(context, password.message);
            } else if (password is PasswordCodeLoaded) {
              //Utils.showSnackBar(context, 'Success');
              Navigator.pushNamed(context, RouteNames.updatePasswordScreen);
            }
          }
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          children: [
            SizedBox(height: size.height * 0.2),
            const CustomImage(path: KImages.forgotPassword),
            const SizedBox(height: 20.0),
            const LeagueSpartanTextStyle(
                text: 'Verification Code',
                fontSize: 36.0,
                fontWeight: FontWeight.w700,
                color: blackColor),
            const SizedBox(height: 20.0),
            Pinput(
              controller: passwordCubit.pinCodeController,
              defaultPinTheme: PinTheme(
                height: 54.0,
                width: 54.0,
                textStyle: GoogleFonts.leagueSpartan(
                  fontWeight: FontWeight.w700,
                  color: blackColor,
                  fontSize: 26.0,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFCF6),
                  border: Border.all(color: borderColor),
                ),
              ),
              onChanged: (String? text) {
                print('onChange');
              },
              onCompleted: (String? text) {
                print('onComplete');
                passwordCubit.forgotPasswordCodeCheck();
              },
              onSubmitted: (String? text) {
                print('onSubmint');
              },
              length: 6,
            ),
            const SizedBox(height: 20.0),
            // PrimaryButton(
            //     text: 'Verify Code',
            //     onPressed: () => Navigator.pushNamed(
            //         context, RouteNames.updatePasswordScreen))
          ],
        ),
      ),
    );
  }
}
