import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/constants.dart';

class LeagueSpartanTextStyle extends StatelessWidget {
  const LeagueSpartanTextStyle({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.w600,
    this.fontSize = 16.0,
    this.height = 1.4,
    this.color = blackColor,
    this.textAlign = TextAlign.start,
  });
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final double height;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: GoogleFonts.roboto(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
        height: height,
      ),
    );
  }
}

class InterTextStyle extends StatelessWidget {
  const InterTextStyle({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.w400,
    this.fontSize = 16.0,
    this.height = 1.4,
    this.color = blackColor,
    this.maxLine = 2,
    this.textAlign = TextAlign.start,
  });
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final double height;
  final TextAlign textAlign;
  final int maxLine;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLine,
      style: GoogleFonts.inter(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
        height: height,
      ),
    );
  }
}
