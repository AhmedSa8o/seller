import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/dummy_data/dummy_data.dart';
import '../../../utils/constants.dart';
import '../../../widgets/error_text.dart';
import '../controller/store_product_bloc/store_product_bloc.dart';
import '../model/store_product_state_model.dart';

class GetStatus extends StatefulWidget {
  const GetStatus({super.key});

  @override
  State<GetStatus> createState() => _GetStatusState();
}

class _GetStatusState extends State<GetStatus> {
  late List<ProductStatusModel> status;
  late String statusValue;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    status = productStatusModel;
    statusValue = status.first.id;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<StoreProductBloc>();
    return BlocBuilder<StoreProductBloc, StoreProductStateModel>(
        builder: (_, state) {
      final s = state.state;
      print('Status: ${state.status}');
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Status',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400, fontSize: 14.0),
                ),
                const TextSpan(text: '*', style: TextStyle(color: redColor))
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            height: 50.0,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            decoration: BoxDecoration(
              color: whiteColor,
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: DropdownButton<String>(
              hint: const Text('Status'),
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              underline: const SizedBox(),
              value: statusValue.isNotEmpty ? statusValue : null,
              onChanged: (newValue) {
                // setState(() {
                //   statusValue = newValue!;
                // });
                // print(statusValue.toUpperCase());
                statusValue = newValue!;
                bloc.add(StoreProductEventStatus(statusValue));
                print(statusValue);
              },
              items: status
                  .map(
                    (e) => DropdownMenuItem<String>(
                      value: e.id,
                      child: Text(e.title),
                    ),
                  )
                  .toList(),
            ),
          ),
          if (s is StoreProductLoadFormValidate) ...[
            if (s.errors.status.isNotEmpty)
              ErrorText(text: s.errors.status.first)
          ]
        ],
      );
    });
  }
}
