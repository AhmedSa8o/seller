import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/modules/review/controller/review_cubit.dart';
import '../../utils/utils.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ReviewCubit>().getAllReviews();
    return Scaffold(
      appBar: AppBar(
          title: const Text('Review Screen'),
          backgroundColor: Utils.dynamicPrimaryColor(context)),
    );
  }
}
