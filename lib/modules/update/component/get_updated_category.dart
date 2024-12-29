import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constants.dart';
import '../../../widgets/error_text.dart';
import '../../order/model/category_model/category_model.dart';
import '../../store_product/controller/category_brand_cubit/category_brand_cubit.dart';
import '../controller/update_bloc/update_product_bloc.dart';
import '../model/update_product_model_state.dart';

class GetUpdatedCategory extends StatefulWidget {
  GetUpdatedCategory({super.key, required this.categoryId});
  String categoryId;
  @override
  State<GetUpdatedCategory> createState() => _GetUpdatedCategoryState();
}

class _GetUpdatedCategoryState extends State<GetUpdatedCategory> {
  late List<CategoryModel> category;

  @override
  void initState() {
    init();
    super.initState();
  }

  init() {
    category = context.read<CategoryBrandCubit>().categoryBrandModel.category;
    // value = category.first.id.toString();
  }

  @override
  Widget build(BuildContext context) {
    final updateBloc = context.read<UpdateProductBloc>();
    return BlocBuilder<UpdateProductBloc, UpdateProductModelState>(
        builder: (context, state) {
      final s = state.updateState;
      // print('Category: ${state.category}');
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
              value: widget.categoryId,
              onChanged: (String? val) {
                widget.categoryId = val!;
                updateBloc.add(UpdateProductEventCategory(widget.categoryId));
                print('catVal: ${widget.categoryId}');
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
          if (s is UpdateProductFormValidate) ...[
            if (s.errors.category.isNotEmpty)
              ErrorText(text: s.errors.category.first)
          ]
        ],
      );
    });
  }
}
