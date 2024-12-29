import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constants.dart';

class RequiredTextField extends StatelessWidget {
  const RequiredTextField({
    super.key,
    required this.title,
    this.type = TextInputType.text,
    this.isStar = true,
    required this.onChange,
    required this.initialValue,
  });
  final String title;
  final TextInputType type;
  final bool isStar;
  final Function(String value) onChange;
  final String initialValue;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: title,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400, fontSize: 14.0),
              ),
              TextSpan(
                  text: isStar ? ' *' : '',
                  style: const TextStyle(color: redColor))
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        TextFormField(
          decoration: InputDecoration(hintText: title),
          keyboardType: type,
          initialValue: initialValue,
          onChanged: onChange,
        ),
        // const SizedBox(height: 16.0),
      ],
    );
  }
}
