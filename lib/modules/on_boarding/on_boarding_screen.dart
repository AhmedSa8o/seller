import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/k_images.dart';
import '../../widgets/confirm_dialog.dart';
import '../../widgets/primary_button.dart';
import '/core/routes/routes_names.dart';
import '/modules/on_boarding/component/custom_dot_indicaor.dart';
import '/modules/on_boarding/controller/setting_cubit.dart';
import '/modules/on_boarding/model/on_boarding_model.dart';
import '/utils/constants.dart';
import '/utils/language_string.dart';
import '/widgets/custom_image.dart';
import '../../utils/utils.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => OnBoardingScreenState();
}
class OnBoardingScreenState extends State<OnBoardingScreen> {
  late int _numPages;
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _numPages = onBoardingList.length;
    _pageController = PageController(initialPage: _currentPage);
  }

  Widget getContent() {
    final item = onBoardingList[_currentPage];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      key: ValueKey('$_currentPage'),
      children: [
        Text(
          item.name,
          style: GoogleFonts.inter(fontSize: 26.0, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10.0),
        Text(
          item.subtitle,
          style: GoogleFonts.inter(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            color: blackColor.withOpacity(.5),
          ),
        ),
      ],
    );
  }

  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    Utils.dynamicPrimaryColor(context);
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => ConfirmDialog(
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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildImagesSlider(),
                _buildBottomContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          AnimatedSwitcher(
            duration: kDuration,
            transitionBuilder: (Widget child, Animation<double> anim) {
              return FadeTransition(opacity: anim, child: child);
            },
            child: getContent(),
          ),
          const SizedBox(height: 10.0),
          _buildBottomButtonIndicator(),
          // if (_currentPage == _numPages - 1) ...[
          //   const SizedBox(height: 26.0),
          //   PrimaryButton(
          //     text: Language.enabledLocation.capitalizeByWord(),
          //     onPressed: () {
          //       Navigator.pushNamedAndRemoveUntil(
          //           context, RouteNames.authenticationScreen, (route) => false);
          //     },
          //   ),
          //   TextButton(
          //     onPressed: () {
          //       context.read<AppSettingCubit>().cachOnBoarding();
          //       Navigator.pushNamedAndRemoveUntil(
          //           context, RouteNames.authenticationScreen, (route) => false);
          //     },
          //     child: Text(
          //       Language.notNow.capitalizeByWord(),
          //       style: const TextStyle(
          //         color: Color(0xff797979),
          //         fontWeight: FontWeight.w700,
          //         fontSize: 16.0,
          //       ),
          //     ),
          //   ),
          //   const SizedBox(height: 30),
          // ] else ...[
          //   _buildBottomButtonIndicator(),
          // ]
        ],
      ),
    );
  }

  Widget _buildBottomButtonIndicator() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: Utils.symmetric(h: 0.0),
          child: DotIndicatorWidget(
            currentIndex: _currentPage,
            dotNumber: _numPages,
          ),
        ),
        PrimaryButton(
            text: Language.next,
            onPressed: () {
              if (_currentPage == _numPages - 1) {
                context.read<SettingCubit>().cacheOnBoarding();
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteNames.loginScreen, (route) => false);
                return;
              }
              _pageController.nextPage(
                  duration: kDuration, curve: Curves.easeInOut);
            }),
      ],
    );
  }

  Widget _buildImagesSlider() {
    return SizedBox(
      height: size.height / 3,
      child: PageView(
        physics: const ClampingScrollPhysics(),
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children:
            onBoardingList.map((e) => CustomImage(path: e.image)).toList(),
      ),
    );
  }
}
