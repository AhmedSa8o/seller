import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seller_app/utils/constants.dart';

import '../utils/utils.dart';

class MyCustomTheme {
  static final borderRadius = Utils.borderRadius(r: 10.0);
  static Color dynamicColor = borderColor;
  static final theme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      scrolledUnderElevation: 0.0,
      toolbarTextStyle: TextStyle(color: blackColor),
      iconTheme: IconThemeData(color: whiteColor),
    ),
      scaffoldBackgroundColor: scaBgColor,

      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        hintStyle: GoogleFonts.inter(color: grayColor,fontSize: 14.0),
        labelStyle: GoogleFonts.inter(color: grayColor, fontSize: 16),
        contentPadding: Utils.symmetric(h: 20.0,v: 18.0),
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: const BorderSide(color: borderColor),
        ),
        fillColor: whiteColor,
        filled: true,
        focusColor: whiteColor,
      ),

      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: blackColor,
        selectionColor: blackColor,
        selectionHandleColor: blackColor,
      ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      // selectedLabelStyle: TextStyle(color: Utils.dynamicPrimaryColor(context)),
      elevation: 3,
      backgroundColor: Color(0x00ffffff),
      selectedLabelStyle: TextStyle(color: blackColor, fontSize: 14.0),
      unselectedLabelStyle: TextStyle(color: grayColor, fontSize: 12.0),
      selectedItemColor: blackColor,
      unselectedItemColor: grayColor,
      showUnselectedLabels: true,
    ),
    dialogTheme: DialogTheme(
      insetPadding: Utils.symmetric(),
      shape: RoundedRectangleBorder(borderRadius: Utils.borderRadius(r: 6.0)),
    )

    // switchTheme: SwitchThemeData(
    //   thumbColor: MaterialStateProperty.all(Utils.dynamicPrimaryColor(context)),
    // )
    //   textSelectionTheme: const TextSelectionThemeData(
    //     cursorColor: blackColor,
    //     selectionColor: blackColor,
    //     selectionHandleColor: blackColor,
    // )
  );
}
