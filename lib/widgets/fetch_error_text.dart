import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'custom_text_style.dart';

class FetchErrorText extends StatelessWidget {
  const FetchErrorText(
      {super.key, required this.text, this.textColor = redColor});

  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InterTextStyle(
        text: text,
        color: textColor,
        fontSize: 14.0,
      ),
    );
  }
}
