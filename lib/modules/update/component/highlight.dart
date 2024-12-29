import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/update_bloc/update_product_bloc.dart';
import '../model/update_product_model_state.dart';

class Highlight extends StatelessWidget {
  Highlight(
      {super.key,
      required this.isTop,
      required this.isBest,
      required this.newArrival,
      required this.isFeatured});

  String isTop;
  String isBest;
  String isFeatured;
  String newArrival;

  @override
  Widget build(BuildContext context) {
    final update = context.read<UpdateProductBloc>();
    return FittedBox(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<UpdateProductBloc, UpdateProductModelState>(
              builder: (_, state) {
            print('isTop: ${state.isTop}');
            return Row(
              children: [
                Checkbox(
                  value: isTop == '1' ? true : false,
                  onChanged: (bool? val) {
                    if (val != null) {
                      isTop = isTop == '0' ? '1' : '0';
                      update.add(UpdateProductEventTopProduct(isTop));
                    }
                  },
                ),
                const Text('Top Product')
              ],
            );
          }),
          BlocBuilder<UpdateProductBloc, UpdateProductModelState>(
              builder: (_, state) {
            print('isBest: ${state.isBest}');
            return Row(
              children: [
                Checkbox(
                  value: isBest == '1' ? true : false,
                  onChanged: (bool? val) {
                    if (val != null) {
                      isBest = isBest == '0' ? '1' : '0';
                      update.add(UpdateProductEventBestProduct(isBest));
                    }
                  },
                ),
                const Text('Best Product')
              ],
            );
          }),
          BlocBuilder<UpdateProductBloc, UpdateProductModelState>(
              builder: (_, state) {
            print('newArrival: ${state.newProduct}');
            return Row(
              children: [
                Checkbox(
                  value: newArrival == '1' ? true : false,
                  onChanged: (bool? val) {
                    if (val != null) {
                      newArrival = newArrival == '0' ? '1' : '0';
                      update
                          .add(UpdateProductEventNewArrivalProduct(newArrival));
                    }
                  },
                ),
                const Text('New Arrival')
              ],
            );
          }),
          BlocBuilder<UpdateProductBloc, UpdateProductModelState>(
              builder: (_, state) {
            print('isFeatured: ${state.isFeatured}');
            return Row(
              children: [
                Checkbox(
                  value: isFeatured == '1' ? true : false,
                  onChanged: (bool? val) {
                    if (val != null) {
                      isFeatured = isFeatured == '0' ? '1' : '0';
                      update.add(UpdateProductEventFeatured(isFeatured));
                    }
                  },
                ),
                const Text('Featured Product')
              ],
            );
          }),
        ],
      ),
    );
  }
}
