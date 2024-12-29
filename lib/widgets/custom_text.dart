import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/constants.dart';


class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.w400,
    this.fontSize = 14.0,
    this.height = 1.4,
    this.maxLine = 6,
    this.color = blackColor,
    this.decoration = TextDecoration.none,
    this.overflow = TextOverflow.ellipsis,
    this.textAlign = TextAlign.start,
    this.softWrap = true,
  });
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final double height;
  final TextAlign textAlign;
  final int maxLine;
  final TextOverflow overflow;
  final TextDecoration decoration;
  final bool softWrap;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLine,
      softWrap: softWrap,
      style: GoogleFonts.roboto(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
        height: height,
        //fontFamily: fontFamily,
        decoration: decoration,
      ),
    );
  }
}
