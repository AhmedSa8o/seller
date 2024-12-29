import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '/modules/on_boarding/controller/currency/currency_cubit.dart';

import '../modules/on_boarding/model/currencies_model.dart';
import '/modules/on_boarding/controller/setting_cubit.dart';
import '../widgets/custom_image.dart';
import '../widgets/primary_button.dart';
import 'constants.dart';
import 'k_images.dart';

class Utils {
  static Size mediaQuery(BuildContext context) => MediaQuery.sizeOf(context);
  static List<TextInputFormatter> allowDecimal = [
    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,4}$'))
  ];

  static String imageContent(BuildContext context, String key,
      [bool lower = false]) {
    final webSetting = context.read<SettingCubit>().settingModel;
    if (lower == true) {
      if (webSetting != null && webSetting.imageContent![key] != null) {
        return webSetting.imageContent![key]!.toLowerCase();
      } else {
        return key.toLowerCase();
      }
    } else {
      if (webSetting != null && webSetting.imageContent![key] != null) {
        return '${webSetting.imageContent![key]}';
      } else {
        return key;
      }
    }
  }

  static String afterPrice = 'right';

  //static String afterPriceWithSpace = 'after_price_with_space';

  static String convertMulCurrency(
      var price, BuildContext context, CurrenciesModel currencies,
      [int radix = 1]) {
    if (currencies.status == 1 &&
        (currencies.currencyPosition.toLowerCase() == Utils.afterPrice)) {
      if (price is double) {
        // debugPrint('double-price $price');
        final result = price * currencies.currencyRate;
        return '${result.toStringAsFixed(radix)}${currencies.currencyIcon}';
      }
      if (price is String) {
        // debugPrint('String-price $price');
        final r = double.tryParse(price) ?? 0.0;
        final p = r * currencies.currencyRate;
        return '${p.toStringAsFixed(radix)}${currencies.currencyIcon}';
      }
      if (price is int) {
        // debugPrint('int-price $price');
        final p = price * currencies.currencyRate;
        return '${p.toStringAsFixed(radix)}${currencies.currencyIcon}';
      } else {
        // debugPrint('other-price $price');
        return '${price * currencies.currencyRate.toStringAsFixed(radix)}${currencies.currencyIcon}';
      }
    } else {
      if (price is double) {
        final result = price * currencies.currencyRate;
        return '${currencies.currencyIcon}${result.toStringAsFixed(radix)}';
      }
      if (price is String) {
        final r = double.tryParse(price) ?? 0.0;
        final p = r * currencies.currencyRate;
        return '${currencies.currencyIcon}${p.toStringAsFixed(radix)}';
      }
      if (price is int) {
        debugPrint('int-price $price');
        final p = price * currencies.currencyRate;
        return '${currencies.currencyIcon}${p.toStringAsFixed(radix)}';
      }
      return '${currencies.currencyIcon}${price * currencies.currencyRate.toStringAsFixed(radix)}';
    }
  }

  static String formatAmount(BuildContext context, var price, [int radix = 1]) {
    final cCubit = context.read<CurrencyCubit>();
    final sCubit = context.read<SettingCubit>();
    if (cCubit.state.currencies.isNotEmpty) {
      return Utils.convertMulCurrency(
          price, context, cCubit.state.currencies.first, radix);
    } else {
      if (sCubit.settingModel != null &&
          sCubit.settingModel!.setting.currencyIcon.isNotEmpty) {
        String currency = sCubit.settingModel!.setting.currencyIcon;
        final p = price.toString();
        return '$currency$p';
      } else {
        final p = price.toString();
        return '\$$p';
      }
    }
  }

  static bool isMapEnable(BuildContext context) {
    final as = context.read<SettingCubit>();
    if (as.settingModel?.setting.mapStatus == 1) {
      return true;
    } else {
      return false;
    }
  }

  static String mapKey(BuildContext context) {
    final as = context.read<SettingCubit>();
    if (as.settingModel != null && as.settingModel!.setting.mapKey.isNotEmpty) {
      return as.settingModel!.setting.mapKey;
    } else {
      return '';
    }
  }

  static Widget verticalSpace(double size) {
    return SizedBox(height: size.h);
  }

  static Widget horizontalSpace(double size) {
    return SizedBox(width: size.w);
  }

  static double hSize(double size) {
    return size.w;
  }

  static double vSize(double size) {
    return size.h;
  }

  static EdgeInsets symmetric({double h = 20.0, v = 0.0}) {
    return EdgeInsets.symmetric(
        horizontal: Utils.hPadding(size: h), vertical: Utils.vPadding(size: v));
  }

  static double radius(double radius) {
    return radius.sp;
  }

  static BorderRadius borderRadius({double r = 10.0}) {
    return BorderRadius.circular(Utils.radius(r));
  }

  static EdgeInsets all({double value = 0.0}) {
    return EdgeInsets.all(value.dm);
  }

  static EdgeInsets only({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return EdgeInsets.only(
        left: left.w, top: top.h, right: right.w, bottom: bottom.h);
  }

  static double vPadding({double size = 20.0}) {
    return size.h;
  }

  static double hPadding({double size = 20.0}) {
    return size.w;
  }

  static Color dynamicPrimaryColor(BuildContext context) {
    final color = context
        .read<SettingCubit>()
        .settingModel!
        .setting
        .themeOne
        .replaceAll('#', '0xFF');
    return Color(int.parse(color));
    // return blackColor;
  }

  static String formatDate(var date) {
    late DateTime dateTime;
    if (date is String) {
      dateTime = DateTime.parse(date);
    } else {
      dateTime = date;
    }
    dateTime = dateTime.toLocal();

    return DateFormat.yMMMMd().format(dateTime);
  }

  static void errorSnackBar(BuildContext context, String errorMsg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(errorMsg, style: const TextStyle(color: Colors.red)),
        ),
      );
  }

  static void showSnackBar(BuildContext context, String msg,
      [Color textColor = whiteColor]) {
    final snackBar = SnackBar(
        duration: const Duration(milliseconds: 800),
        content: Text(msg, style: TextStyle(color: textColor)));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void serviceUnAvailable(BuildContext context, String msg,
      [Color textColor = Colors.white]) {
    final snackBar = SnackBar(
        backgroundColor: redColor,
        duration: const Duration(milliseconds: 500),
        content: Text(msg, style: TextStyle(color: textColor)));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static bool _isDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  static void closeDialog(BuildContext context) {
    if (_isDialogShowing(context)) {
      Navigator.pop(context);
    }
  }

  static loadingDialog(
    BuildContext context, {
    bool barrierDismissible = false,
  }) {
    // closeDialog(context);
    showCustomDialog(
      context,
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(20),
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 15),
              Text('Please wait a moment')
            ],
          ),
        ),
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static Future showCustomDialog(
    BuildContext context, {
    Widget? child,
    bool barrierDismissible = false,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: child,
        );
      },
    );
  }

  static Future uploadVideoFile(
    BuildContext context, {
    Widget? child,
    bool barrierDismissible = false,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: child,
        );
      },
    );
  }

  static Future<String?> pickSingleImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return image.path;
    }
    return null;
  }

  static Future<List<String?>> pickMultipleImage() async {
    final ImagePicker picker = ImagePicker();
    final List<String> imageList = [];
    final List<XFile?> images = await picker.pickMultiImage();
    if (images.isNotEmpty) {
      // imageList.addAll(images);
      //  return images.map((e) => imageList.add(e!.path)).toList();
      for (var i in images) {
        imageList.add(i!.path.toString());
      }
      debugPrint('picked images: ${imageList.length}');
      return imageList;
    }
    return [];
  }

  static Future<String?> pickSingleFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp4', 'avi', 'mpeg-4', 'mov', 'mkv', 'wmv', 'mov'],
    );
    if (result != null && result.files.single.path!.isNotEmpty) {
      File file = File(result.files.single.path!);
      debugPrint('file-path ${file.path}');
      return file.path;
    } else {
      debugPrint('file path not found');
      return null;
    }
  }

  static void closeKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static exitFromAppDialog(BuildContext context) {
    return Utils.showCustomDialog(
      context,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomImage(path: KImages.exitApp),
            const SizedBox(height: 8.0),
            Text(
              'Are you sure',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w700,
                color: blackColor,
                fontSize: 24.0,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              'You want to Exit?',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                color: grayColor,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PrimaryButton(
                  text: 'Exit',
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  minimumSize: const Size(125.0, 45.0),
                ),
                const SizedBox(width: 12.0),
                PrimaryButton(
                  text: 'Cancel',
                  onPressed: () => Navigator.pop(context),
                  bgColor: redColor,
                  textColor: whiteColor,
                  minimumSize: const Size(125.0, 45.0),
                ),
              ],
            ),
            const SizedBox(height: 14.0),
          ],
        ),
      ),
    );
  }
}
