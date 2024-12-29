import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/utils.dart';
import 'custom_text_style.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Utils.symmetric(h: 0.0, v: 5.0),
      child: InterTextStyle(
        text: '* $text',
        color: redColor,
      ),
    );
  }
}
