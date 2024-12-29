import 'package:flutter/material.dart';

import '../utils/utils.dart';


class PageRefresh extends StatelessWidget {
  const PageRefresh({super.key, required this.child, required this.onRefresh});

  final Widget child;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 100.0,
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      color: Utils.dynamicPrimaryColor(context),
      edgeOffset: 180,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
