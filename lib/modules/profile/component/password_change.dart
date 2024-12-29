import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';
import '../../../utils/loading_widget.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/error_text.dart';
import '../../../widgets/primary_button.dart';
import '../controller/password_change/password_change_cubit.dart';
import '../controller/password_change/password_change_state_model.dart';

class PasswordChange extends StatefulWidget {
  const PasswordChange({super.key});

  @override
  State<PasswordChange> createState() => _PasswordChangeState();
}

class _PasswordChangeState extends State<PasswordChange> {
  bool _password = false;
  bool _confirmPassword = false;
  final _className = "PasswordChange";

  @override
  Widget build(BuildContext context) {
    final passwordCubit = context.read<PasswordChangeCubit>();
    return AlertDialog(
      // title: const Text('Change You Credentials'),
      content: BlocListener<PasswordChangeCubit, PasswordChangeModel>(
        listener: (context, state) {
          final password = state.passwordState;
          if (password is PasswordChangeLoading) {
            log(password.toString(), name: _className);
          } else if (password is PasswordChangeError) {
            Navigator.of(context).pop();
            Utils.errorSnackBar(context, password.message);
          } else if (password is PasswordChangeLoaded) {
            Navigator.of(context).pop();
            Utils.showSnackBar(context, password.notification);
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Change Your Credentials'),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    passwordCubit.clearErrorMessage();
                  },
                  child: const CustomImage(
                    path: KImages.cancel,
                    height: 15.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            BlocBuilder<PasswordChangeCubit, PasswordChangeModel>(
              builder: (context, state) {
                final s = state.passwordState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      // controller: passwordController,

                      decoration: InputDecoration(
                          hintText: 'Password',
                          suffixIcon: IconButton(
                              splashRadius: 18.0,
                              onPressed: () =>
                                  setState(() => _password = !_password),
                              icon: Icon(
                                  _password
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: blackColor))),
                      obscureText: _password,
                      initialValue: state.password,
                      onChanged: (String password) =>
                          passwordCubit.password(password),
                    ),
                    if (s is PasswordChangeFormError) ...[
                      if (s.errors.password.isNotEmpty)
                        ErrorText(text: s.errors.password.first)
                    ]
                  ],
                );
              },
            ),
            const SizedBox(height: 12.0),
            BlocBuilder<PasswordChangeCubit, PasswordChangeModel>(
              builder: (context, state) {
                final s = state.passwordState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      // controller: confirmPasswordController,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        suffixIcon: IconButton(
                            splashRadius: 18.0,
                            onPressed: () => setState(
                                () => _confirmPassword = !_confirmPassword),
                            icon: Icon(
                                _confirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: blackColor)),
                      ),

                      onChanged: (String password) =>
                          passwordCubit.confirmPassword(password),
                      obscureText: _confirmPassword,
                    ),
                    if (s is PasswordChangeFormError) ...[
                      if (s.errors.password.isNotEmpty)
                        ErrorText(text: s.errors.password.first)
                    ]
                  ],
                );
              },
            ),
            const SizedBox(height: 16.0),
            BlocConsumer<PasswordChangeCubit, PasswordChangeModel>(
              listener: (_, state) {},
              builder: (context, state) {
                final pass = state.passwordState;
                print(state.toString());
                if (pass is PasswordChangeLoading) {
                  return LoadingWidget();
                }
                return PrimaryButton(
                  text: 'Change Password',
                  onPressed: () {
                    Utils.closeKeyBoard(context);
                    context.read<PasswordChangeCubit>().passwordChange();
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
