import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constants.dart';
import '../../../widgets/error_text.dart';
import '../../order/model/category_model/category_model.dart';
import '../controller/store_product_bloc/store_product_bloc.dart';
import '../controller/category_brand_cubit/category_brand_cubit.dart';
import '../model/store_product_state_model.dart';

class GetCategory extends StatefulWidget {
  const GetCategory({super.key});

  @override
  State<GetCategory> createState() => _GetCategoryState();
}

class _GetCategoryState extends State<GetCategory> {
  late List<CategoryModel> category;
  late String value;

  @override
  void initState() {
    init();
    super.initState();
  }

  init() {
    // context.read<CategoryBrandCubit>().getAllCategoryAndBrands();
    category = context.read<CategoryBrandCubit>().categoryBrandModel.category;
    value = category.first.id.toString();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<StoreProductBloc>();
    return BlocBuilder<StoreProductBloc, StoreProductStateModel>(
        builder: (context, state) {
      final s = state.state;
      print('Category: ${state.category}');
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Category',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400, fontSize: 14.0),
                ),
                const TextSpan(text: ' *', style: TextStyle(color: redColor))
              ],
            ),
          ),
          // const SizedBox(height: 8.0),
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
              hint: const Text('Select Status'),
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              underline: const SizedBox(),
              value: value,
              onChanged: (String? val) {
                value = val!;
                bloc.add(StoreProductEventCategory(value));
                print('catVal: $value');
              },
              // onChanged: (String? newValue) {
              //   setState(() {
              //     value = newValue!;
              //   });
              //   print(value);
              // },

              items: category
                  .map(
                    (e) => DropdownMenuItem<String>(
                      value: e.id.toString(),
                      child: Text(e.name),
                    ),
                  )
                  .toList(),
            ),
          ),
          if (s is StoreProductLoadFormValidate) ...[
            if (s.errors.category.isNotEmpty)
              ErrorText(text: s.errors.category.first)
          ]
        ],
      );
    });
  }
}
