import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/widgets/primary_button.dart';
import '../../../utils/constants.dart';
import '../../../utils/language_string.dart';
import '../../../utils/utils.dart';
import '../../../widgets/error_text.dart';
import '../login/login_bloc/login_bloc.dart';
import '../login/model/login_state_model.dart';

class InputFormWidget extends StatefulWidget {
  const InputFormWidget({super.key});

  @override
  State<InputFormWidget> createState() => _InputFormWidgetState();
}

class _InputFormWidgetState extends State<InputFormWidget> {
  String email = '';
  String password = '';

  //late SharedPreferences _sharedPreferences;

  @override
  void initState() {
    //initLocalDB();
    super.initState();
  }

  Future<void> initLocalDB() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      email = pref.getString('email') ?? '';
      password = pref.getString('password') ?? '';
    });
    context.read<LoginBloc>().add(LoginEventUserEmail(email));
    context.read<LoginBloc>().add(LoginEventPassword(password));
    debugPrint('SavedEmail: $email');
    debugPrint('SavedPassword: $password');
    debugPrint('SavedEmail: $email');
    debugPrint('SavedPassword: $password');
  }

  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();
    debugPrint(email);
    debugPrint(password);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          Language.welcomeText,
          style: TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.w600,
            color: blackColor,
          ),
        ),
        const SizedBox(height: defaultPadding),
        BlocBuilder<LoginBloc, LoginStateModel>(
          builder: (context, state) {
            final editState = state.loginState;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: Language.sellerEmail,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  initialValue: state.email,
                  onChanged: (email) {
                    loginBloc.add(LoginEventUserEmail(email));
                    debugPrint(email);
                  },
                ),
                if (editState is LoginStateFormValidate) ...[
                  if (editState.errors.email.isNotEmpty)
                    ErrorText(text: editState.errors.email.first),
                ]
              ],
            );
          },
        ),
        const SizedBox(height: 18.0),
        BlocBuilder<LoginBloc, LoginStateModel>(
          builder: (context, state) {
            final editState = state.loginState;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: Language.password,
                    suffixIcon: IconButton(
                      onPressed: () =>
                          loginBloc.add(ShowPasswordEvent(state.show)),
                      icon: Icon(
                        state.show ? Icons.visibility_off : Icons.visibility,
                      ),
                      color: blackColor,
                      splashRadius: 18.0,
                    ),
                  ),
                  initialValue: state.password,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (password) {
                    loginBloc.add(LoginEventPassword(password));
                    // print(password);
                  },
                  obscureText: state.show,
                ),
                if (state.email.isNotEmpty)
                  if (editState is LoginStateFormValidate) ...[
                    if (editState.errors.password.isNotEmpty)
                      ErrorText(text: editState.errors.password.first),
                  ]
              ],
            );
          },
        ),
        const SizedBox(height: 6.0),
        _buildRememberMe(),
        const SizedBox(height: 12.0),
        BlocBuilder<LoginBloc, LoginStateModel>(
          buildWhen: (previous, current) =>
              previous.loginState != current.loginState,
          builder: (_, state) {
            final login = state.loginState;
            if (login is LoginStateLoading) {
              return Center(
                  child: CircularProgressIndicator(
                      color: Utils.dynamicPrimaryColor(context)));
            }
            return PrimaryButton(
                text: Language.login,
                onPressed: () {
                  Utils.closeKeyBoard(context);
                  loginBloc.add(const LoginEventSubmit());
                });
          },
        ),
        const SizedBox(height: 30.0),
      ],
    );
  }

  Widget _buildRememberMe() {
    final loginBloc = context.read<LoginBloc>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            BlocBuilder<LoginBloc, LoginStateModel>(
              builder: (context, state) {
                print('check: ${state.isActive}');
                return Container(
                  height: Utils.vSize(24.0),
                  width: Utils.vSize(24.0),
                  margin: Utils.symmetric(h: 10.0,v: 12.0).copyWith(left: 0.0),
                  child: Checkbox(
                      value: state.isActive,
                      activeColor: blackColor,
                      // activeColor: Utils.dynamicPrimaryColor(context),
                      checkColor: whiteColor,
                      splashRadius: 18.0,
                      onChanged: (bool? val) {
                        if (val != null) {
                          loginBloc.add(SaveUserCredentialEvent(val));
                          //print('checkBoxValue: ${state.isActive}');
                        }
                      }),
                );
              },
            ),
            const Text(Language.rememberMe),
          ],
        ),
        const SizedBox(),
        // GestureDetector(
        //   onTap: () =>
        //       Navigator.pushNamed(context, RouteNames.forgotPasswordScreen),
        //   child: const Text(
        //     Language.forgotPassword,
        //     style: TextStyle(
        //       color: redColor,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

class RememberMeCubit extends Cubit<bool> {
  RememberMeCubit() : super(false);
  bool isChecked = false;

  void rememberMe(bool check) => emit(isChecked = !check);
}
