import 'package:flutter/material.dart';

import '/utils/k_images.dart';
import '/widgets/custom_image.dart';
import '/widgets/primary_button.dart';
import '../../core/routes/routes_names.dart';
import '../../utils/constants.dart';
import '../../utils/language_string.dart';
import '../../widgets/custom_text_style.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: size.height * 0.2),
          const CustomImage(path: KImages.forgotPassword),
          const SizedBox(height: 20.0),
          const LeagueSpartanTextStyle(
              text: 'Forgot Password',
              fontSize: 36.0,
              fontWeight: FontWeight.w700,
              color: blackColor),
          const SizedBox(height: 20.0),
          TextFormField(
            decoration: const InputDecoration(
              hintText: Language.sellerEmail,
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20.0),
          PrimaryButton(
              text: 'Send Code',
              onPressed: () =>
                  Navigator.pushNamed(context, RouteNames.verificationScreen))
        ],
      ),
    );
  }
}
