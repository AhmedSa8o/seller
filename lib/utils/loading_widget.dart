import 'package:flutter/material.dart';
import 'package:seller_app/utils/utils.dart';

import 'constants.dart';

class LoadingWidget extends StatelessWidget {
  LoadingWidget({super.key, this.color = primaryColor});
  Color color;

  @override
  Widget build(BuildContext context) {
    color = Utils.dynamicPrimaryColor(context);
    return Center(
      child: CircularProgressIndicator(color: color),
    );
  }
}
