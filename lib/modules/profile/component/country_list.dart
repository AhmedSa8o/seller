import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller_app/utils/constants.dart';

import '../controller/country_state_city/country_state_city_cubit.dart';
import '../controller/update_profile/update_profile_cubit.dart';
import '../controller/update_profile/update_profile_state_model.dart';
import '../model/country_model.dart';

class CountryList extends StatefulWidget {
  const CountryList(
      {super.key, required this.countries, required this.countryId});
  final List<CountryModel> countries;
  final int countryId;

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  late String value;

  @override
  void initState() {
    super.initState();
    value = widget.countries[widget.countryId].id.toString();
  }

  @override
  Widget build(BuildContext context) {
    final updateCubit = context.read<UpdateSellerProfileCubit>();
    context.read<CountryStateCityCubit>().getStateByCountry(value);
    print('value: $value');
    return BlocBuilder<UpdateSellerProfileCubit, UpdateSellerProfileStateModel>(
      builder: (context, state) {
        print('countryId: ${state.country}');
        return Container(
          height: 50.0,
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            color: whiteColor,
            border: Border.all(color: borderColor),
          ),
          child: DropdownButton(
            onChanged: (val) {
              if(val != null){
                value = val;
                updateCubit.countryChange(value);
              }

            },
            value: value,
            underline: const SizedBox(),
            isDense: true,
            isExpanded: true,
            hint: Text(widget.countries[widget.countryId].name),
            icon: const Icon(Icons.keyboard_arrow_down_outlined),
            items: widget.countries
                .map(
                  (country) => DropdownMenuItem(
                    value: country.id.toString(),
                    child: Text(country.name),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
