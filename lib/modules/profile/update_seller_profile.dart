import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller_app/core/remote_urls.dart';
import 'package:seller_app/modules/profile/model/country_model.dart';

import '/utils/constants.dart';
import '/utils/loading_widget.dart';
import '/utils/utils.dart';
import '/widgets/error_text.dart';
import '/widgets/primary_button.dart';
import '../../widgets/custom_image.dart';
import 'component/map_address.dart';
import 'component/profile_images.dart';
import 'controller/country_state_city/country_state_city_cubit.dart';
import 'controller/map/map_cubit.dart';
import 'controller/map/map_state_model.dart';
import 'controller/seller_profile_cubit.dart';
import 'controller/update_profile/update_profile_cubit.dart';
import 'controller/update_profile/update_profile_state_model.dart';
import 'model/city_by_state_model.dart';
import 'model/seller_profile_model.dart';
import 'model/state_by_country_model.dart';

class UpdateSellerProfileScreen extends StatefulWidget {
  const UpdateSellerProfileScreen({super.key, required this.seller});

  final SellerProfileModel seller;

  @override
  State<UpdateSellerProfileScreen> createState() =>
      _UpdateSellerProfileScreenState();
}

class _UpdateSellerProfileScreenState extends State<UpdateSellerProfileScreen> {
  CountryModel? _country;
  StateByCountryModel? _stateByCountry;
  CityByStateModel? _cityByState;
  late UpdateSellerProfileCubit updateSellerCubit;
  late MapCubit aCubit;

  List<CountryModel> countryList = [];
  List<StateByCountryModel> stateList = [];
  List<CityByStateModel> cityList = [];

  @override
  void initState() {
    initializedExistingValue();
    super.initState();
  }

  initializedExistingValue() {
    updateSellerCubit = context.read<UpdateSellerProfileCubit>();
    aCubit = context.read<MapCubit>();
    loadCountryStateCity();
    _existLocation();
    //updateSellerCubit.imageChange(widget.seller.user!.image);
    updateSellerCubit.nameChange(widget.seller.user!.name);
    updateSellerCubit.emailChange(widget.seller.user!.email);
    updateSellerCubit.phoneChange(widget.seller.user!.phone);
    updateSellerCubit.countryChange(widget.seller.user!.countryId.toString());
    updateSellerCubit
        .countryStateChange(widget.seller.user!.stateId.toString());
    updateSellerCubit.zipCodeChange(widget.seller.user!.zipCode.toString());
    updateSellerCubit.cityChange(widget.seller.user!.cityId.toString());
    updateSellerCubit.addressChange(widget.seller.user!.address);
    updateSellerCubit.addLatLong(
        widget.seller.user!.latitude, widget.seller.user!.longitude);
    aCubit
      ..addLatitude(widget.seller.user!.latitude)
      ..addLongitude(widget.seller.user!.longitude);
  }

  loadCountryStateCity() {
    //context.read<CountryStateCityCubit>().countryList = countryList;
    countryList = widget.seller.countries!;
    context.read<CountryStateCityCubit>().stateList = widget.seller.states!;
    context.read<CountryStateCityCubit>().cityList = widget.seller.cities!;

    // for (var e in widget.seller.countries!) {
    //   if (e.id.toString() == widget.seller.user!.countryId.toString()) {
    //     _country = e;
    //   }
    //   break;
    // }

    _country =
        context.read<SellerProfileCubit>().defaultCountry(widget.seller.user!);
    _stateByCountry = context
        .read<SellerProfileCubit>()
        .defaultState(widget.seller.user!.stateId.toString());

    if (_stateByCountry != null) {
      _cityByState = context
          .read<SellerProfileCubit>()
          .defaultCity(widget.seller.user!.cityId.toString());
    }
  }

  _loadState(CountryModel countryModel) {
    _country = countryModel;
    _stateByCountry = null;
    _cityByState = null;

    context
        .read<CountryStateCityCubit>()
        .getStateByCountry(countryModel.id.toString());
  }

  _loadCity(StateByCountryModel stateModel) {
    _stateByCountry = stateModel;
    _cityByState = null;
    context
        .read<CountryStateCityCubit>()
        .getCityByState(stateModel.id.toString());
  }

  _existLocation() async {
    if (widget.seller.user != null) {
      await aCubit.getLocationFromLatLng(
          widget.seller.user!.latitude, widget.seller.user!.longitude);
      debugPrint('location-iss ${aCubit.state.location}');
    } else {
      debugPrint('not-location');
    }
  }

  final space = const SizedBox(height: 16.0);
  final _className = 'UpdateSellerProfileScreen';

  @override
  Widget build(BuildContext context) {
    final profile = widget.seller.user!;
    final profileCubit = context.read<UpdateSellerProfileCubit>();
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: whiteColor),
          title: const Text(
            'Update Profile',
            style: TextStyle(color: whiteColor),
          ),
          backgroundColor: blackColor),
      body:
          BlocListener<UpdateSellerProfileCubit, UpdateSellerProfileStateModel>(
        listener: (_, state) {
          final update = state.updateProfileState;
          print(update);
          if (update is UpdateProfileStateLoading) {
            log(update.toString(), name: _className);
          } else if (update is UpdateProfileStateError) {
            Utils.errorSnackBar(context, update.message);
          } else if (update is UpdateProfileStateLoaded) {
            Navigator.of(context).pop();
            // Navigator.of(context).pop(true);
            // Navigator.pop(context);
            context.read<SellerProfileCubit>().getSellerProfile();
            Utils.showSnackBar(context, update.message);
          }
        },
        child: BlocBuilder<CountryStateCityCubit, CountryStateCityState>(
          builder: (context, state) {
            if (state is StateByCountryLoaded) {
              _stateByCountry = context
                  .read<CountryStateCityCubit>()
                  .filterState(widget.seller.user!.stateId.toString());

              if (_stateByCountry != null) {
                _cityByState = context
                    .read<CountryStateCityCubit>()
                    .filterCity(widget.seller.user!.cityId.toString());
              }
            }
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 20.0),
                ProfileImages(seller: widget.seller),
                // _buildImage(),
                space,
                BlocBuilder<UpdateSellerProfileCubit,
                    UpdateSellerProfileStateModel>(
                  builder: (_, state) {
                    final update = state.updateProfileState;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                            initialValue: profile.name,
                            onChanged: (String name) =>
                                profileCubit.nameChange(name),
                            decoration: const InputDecoration(hintText: 'Name'),
                            keyboardType: TextInputType.name),
                        if (update is UpdateProfileStateFormValidate) ...[
                          if (update.errors.name.isNotEmpty)
                            ErrorText(text: update.errors.name.first)
                        ]
                      ],
                    );
                  },
                ),
                space,
                BlocBuilder<UpdateSellerProfileCubit,
                    UpdateSellerProfileStateModel>(
                  builder: (_, state) {
                    final update = state.updateProfileState;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                            initialValue: profile.email,
                            onChanged: (String name) =>
                                profileCubit.emailChange(name),
                            decoration:
                                const InputDecoration(hintText: 'Email'),
                            keyboardType: TextInputType.emailAddress),
                        if (update is UpdateProfileStateFormValidate) ...[
                          if (update.errors.email.isNotEmpty)
                            ErrorText(text: update.errors.email.first)
                        ]
                      ],
                    );
                  },
                ),
                space,
                BlocBuilder<UpdateSellerProfileCubit,
                    UpdateSellerProfileStateModel>(
                  builder: (_, state) {
                    final update = state.updateProfileState;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          initialValue: profile.phone,
                          onChanged: (String name) =>
                              profileCubit.phoneChange(name),
                          decoration: const InputDecoration(hintText: 'Phone'),
                          keyboardType: TextInputType.number,
                        ),
                        if (update is UpdateProfileStateFormValidate) ...[
                          if (update.errors.phone.isNotEmpty)
                            ErrorText(text: update.errors.phone.first)
                        ]
                      ],
                    );
                  },
                ),
                space,
                // _countryField(),
                BlocBuilder<UpdateSellerProfileCubit,
                    UpdateSellerProfileStateModel>(
                  builder: (_, state) {
                    final update = state.updateProfileState;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _countryField(),
                        if (update is UpdateProfileStateFormValidate) ...[
                          if (update.errors.country.isNotEmpty)
                            ErrorText(text: update.errors.country.first)
                        ]
                      ],
                    );
                  },
                ),
                space,
                _stateField(),
                space,
                _cityField(),

                space,

                BlocBuilder<UpdateSellerProfileCubit,
                    UpdateSellerProfileStateModel>(
                  builder: (_, state) {
                    final update = state.updateProfileState;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          initialValue: profile.zipCode.toString(),
                          onChanged: (String name) =>
                              profileCubit.zipCodeChange(name),
                          keyboardType: TextInputType.number,
                          decoration:
                              const InputDecoration(hintText: 'ZipCode'),
                        ),
                        if (update is UpdateProfileStateFormValidate) ...[
                          if (update.errors.zipCode.isNotEmpty)
                            ErrorText(text: update.errors.zipCode.first)
                        ]
                      ],
                    );
                  },
                ),
                space,
                BlocBuilder<UpdateSellerProfileCubit,
                    UpdateSellerProfileStateModel>(
                  builder: (_, state) {
                    final update = state.updateProfileState;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          initialValue: profile.address,
                          onChanged: (String name) =>
                              profileCubit.addressChange(name),
                          decoration:
                              const InputDecoration(hintText: 'Address'),
                        ),
                        if (update is UpdateProfileStateFormValidate) ...[
                          if (update.errors.address.isNotEmpty)
                            ErrorText(text: update.errors.address.first)
                        ]
                      ],
                    );
                  },
                ),
                Utils.isMapEnable(context) ? space : const SizedBox.shrink(),
                BlocBuilder<MapCubit, MapStateModel>(
                  builder: (context, state) {
                    _existLocation();
                    aCubit
                      ..addLatitude(state.latitude)
                      ..addLongitude(state.longitude);
                    updateSellerCubit.addLatLong(
                        state.latitude, state.longitude);
                    if (Utils.isMapEnable(context)) {
                      return TextFormField(
                        keyboardType: TextInputType.streetAddress,
                        readOnly: true,
                        onTap: () async {
                          debugPrint('called');
                          await showDialog(
                            context: context,
                            builder: (context) => const AddressMapDialog(),
                          );
                        },
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: state.location.isNotEmpty
                                  ? blackColor
                                  : grayColor),
                          hintText: state.updateLocation.isEmpty
                              ? state.location
                              : state.updateLocation,
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                space,
                BlocBuilder<UpdateSellerProfileCubit,
                    UpdateSellerProfileStateModel>(
                  builder: (_, state) {
                    final update = state.updateProfileState;
                    if (update is UpdateProfileStateLoading) {
                      return LoadingWidget();
                    }
                    return PrimaryButton(
                      text: 'Update Profile',
                      onPressed: () {
                        Utils.closeKeyBoard(context);

                        if (Utils.isMapEnable(context)) {
                          if (aCubit.state.latitude != 0.0 &&
                              aCubit.state.longitude != 0.0) {
                            profileCubit.updateSellerProfile();
                          } else {
                            Utils.showSnackBar(context, 'Location is required');
                          }
                        } else {
                          profileCubit.updateSellerProfile();
                        }
                      },
                    );
                  },
                ),
                const SizedBox(height: 60.0),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildImage() {
    final updateCubit = context.read<UpdateSellerProfileCubit>();
    return BlocBuilder<UpdateSellerProfileCubit, UpdateSellerProfileStateModel>(
      buildWhen: (previous, current) => previous.image != current.image,
      builder: (context, state) {
        String profileImage = widget.seller.user!.image.isNotEmpty
            ? RemoteUrls.imageUrl(widget.seller.user!.image)
            : RemoteUrls.imageUrl(widget.seller.defaultProfile!.image);

        profileImage = state.image.isNotEmpty ? state.image : profileImage;

        print('userImage: ${widget.seller.user!.image}');
        print('defaul: ${widget.seller.defaultProfile!.image}');
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color(0xff333333).withOpacity(.18),
                blurRadius: 70,
              ),
            ],
          ),
          child: Center(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CustomImage(
                    path: profileImage,
                    height: 170,
                    width: 170,
                    fit: BoxFit.cover,
                    isFile: state.image.isNotEmpty,
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: InkWell(
                    onTap: () async {
                      final imageSourcePath = await Utils.pickSingleImage();
                      updateCubit.imageChange(imageSourcePath!);
                    },
                    child: CircleAvatar(
                      backgroundColor: Utils.dynamicPrimaryColor(context),
                      child: const Icon(Icons.edit, color: blackColor),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _countryField() {
    final countryStateCity = context.read<CountryStateCityCubit>();
    return DropdownButtonFormField<CountryModel>(
      value: _country,
      isDense: true,
      isExpanded: true,
      hint: const Text('Country'),
      icon: const Icon(Icons.keyboard_arrow_down_outlined),
      decoration: const InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: borderColor)),
      ),
      items: widget.seller.countries!
          .map<DropdownMenuItem<CountryModel>>(
            (CountryModel c) => DropdownMenuItem(
              value: c,
              child: Text(c.name),
            ),
          )
          .toList(),
      onChanged: (val) {
        if (val == null) return;
        _loadState(val);
        context
            .read<UpdateSellerProfileCubit>()
            .countryChange(val.id.toString());
        print('countryIdDrop: ${val.id.toString()}');
      },
    );
  }

  Widget _stateField() {
    final countryStateCity = context.read<CountryStateCityCubit>();
    return DropdownButtonFormField<StateByCountryModel>(
      value: _stateByCountry,
      isDense: true,
      isExpanded: true,
      hint: const Text('State'),
      icon: const Icon(Icons.keyboard_arrow_down_outlined),
      decoration: const InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: borderColor)),
      ),
      items: countryStateCity.stateList
          .map<DropdownMenuItem<StateByCountryModel>>(
            (StateByCountryModel c) => DropdownMenuItem(
              value: c,
              child: Text(c.name),
            ),
          )
          .toList(),
      onChanged: (val) {
        if (val == null) return;
        _loadCity(val);
        context
            .read<UpdateSellerProfileCubit>()
            .countryStateChange(val.id.toString());
        print('stateIdDrop: ${val.id.toString()}');
      },
    );
  }

  Widget _cityField() {
    final countryStateCity = context.read<CountryStateCityCubit>();
    return DropdownButtonFormField<CityByStateModel>(
      value: _cityByState,
      isDense: true,
      isExpanded: true,
      hint: const Text('City'),
      icon: const Icon(Icons.keyboard_arrow_down_outlined),
      decoration: const InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: borderColor)),
      ),
      items: countryStateCity.cityList
          .map<DropdownMenuItem<CityByStateModel>>(
            (CityByStateModel c) => DropdownMenuItem(
              value: c,
              child: Text(c.name),
            ),
          )
          .toList(),
      onChanged: (val) {
        if (val == null) return;
        context.read<UpdateSellerProfileCubit>().cityChange(val.id.toString());
        print('cityIdDrop: ${val.id.toString()}');
      },
    );
  }
}
