import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/modules/dashboard/model/seller_model/seller_model.dart';
import '/utils/constants.dart';

import '../../utils/loading_widget.dart';
import '../../utils/utils.dart';
import '../../widgets/error_text.dart';
import '../../widgets/primary_button.dart';
import 'component/get_seller_banner_image.dart';
import 'component/get_seller_logo_image.dart';
import 'controller/seller_profile_cubit.dart';
import 'controller/update_seller_shop/update_seller_shop_cubit.dart';
import 'controller/update_seller_shop/update_seller_shop_state_model.dart';

class UpdateSellerShopScreen extends StatefulWidget {
  const UpdateSellerShopScreen({super.key, required this.seller});
  final SellerModel seller;

  @override
  State<UpdateSellerShopScreen> createState() => _UpdateSellerShopScreenState();
}

class _UpdateSellerShopScreenState extends State<UpdateSellerShopScreen> {
  @override
  void initState() {
    super.initState();
    sellerExistingData();
  }

  sellerExistingData() {
    // context.read<UpdateSellerShopCubit>().logoChange(widget.seller.logo);
    context.read<UpdateSellerShopCubit>().nameChange(widget.seller.shopName);
    // context
    //     .read<UpdateSellerShopCubit>()
    //     .bannerImageChange(widget.seller.bannerImage);
    context.read<UpdateSellerShopCubit>().emailChange(widget.seller.email);
    context.read<UpdateSellerShopCubit>().phoneChange(widget.seller.phone);
    context
        .read<UpdateSellerShopCubit>()
        .greetingMessageChange(widget.seller.greetingMessage);
    context.read<UpdateSellerShopCubit>().addressChange(widget.seller.address);
    context
        .read<UpdateSellerShopCubit>()
        .seoTitleChange(widget.seller.seoTitle);
    context
        .read<UpdateSellerShopCubit>()
        .seoDescriptionChange(widget.seller.seoDescription);
    context.read<UpdateSellerShopCubit>().openAtChange(widget.seller.openAt);
    context
        .read<UpdateSellerShopCubit>()
        .closedAtChange(widget.seller.closedAt);
  }

  final _className = 'UpdateSellerShopScreen';
  final space = const SizedBox(height: 16.0);

  @override
  Widget build(BuildContext context) {
    final shop = widget.seller;
    final profileCubit = context.read<UpdateSellerShopCubit>();
    final pCubit =  context.read<SellerProfileCubit>();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: whiteColor),
        title: const Text(
          'Update Seller Shop',
          style: TextStyle(color: whiteColor),
        ),
        backgroundColor: blackColor,
      ),
      body: BlocListener<UpdateSellerShopCubit, UpdateSellerShopStateModel>(
        listener: (context, state) {
          final update = state.updateSellerShopState;
          // print(update);
          if (update is UpdateSellerShopStateLoading) {
            log(update.toString(), name: _className);
          } else if (update is UpdateSellerShopStateError) {
            Utils.errorSnackBar(context, update.message);
          } else if (update is UpdateSellerShopStateLoaded) {
            Utils.showSnackBar(context, update.message);
            pCubit.getSellerProfile();
           Future.delayed(const Duration(milliseconds: 1500),(){
             profileCubit.isNavigate = true;
             Navigator.of(context).pop();
             profileCubit.isNavigate = false;
           });
            //Navigator.of(context).pop();
            // Navigator.of(context).pop(true);
            // Navigator.pop(context);
         }
        },
        //listenWhen: (previous,current)=>previous == current,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 30.0),
            SellerUpdatedImage(image: shop.bannerImage),
            space,
            SellerUpdatedLogo(logo: shop.logo),
            space,
            BlocBuilder<UpdateSellerShopCubit, UpdateSellerShopStateModel>(
              builder: (_, state) {
                // print('banner: ${state.bannerImage}');
                // print('logo: ${state.logo}');
                // print('name: ${state.shopName}');
                // print('emil: ${state.email}');
                // print('phone: ${state.phone}');
                // print('open: ${state.openAt}');
                // print('open: ${state.closeAt}');
                // print('greeting: ${state.greetingMessage}');

                print('statesss: $state');
                final update = state.updateSellerShopState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                        initialValue: shop.shopName,
                        onChanged: (String name) =>
                            profileCubit.nameChange(name),
                        decoration: const InputDecoration(hintText: 'Name'),
                        keyboardType: TextInputType.name),
                    if (update is UpdateSellerShopStateFormValidate) ...[
                      if (update.errors.shopName.isNotEmpty)
                        ErrorText(text: update.errors.shopName.first)
                    ]
                  ],
                );
              },
            ),
            space,
            BlocBuilder<UpdateSellerShopCubit, UpdateSellerShopStateModel>(
              //buildWhen: (p,c)=>p.email != c.email,
              builder: (_, state) {
                final update = state.updateSellerShopState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                        initialValue: shop.email,
                        onChanged: (String name) =>
                            profileCubit.emailChange(name),
                        decoration: const InputDecoration(hintText: 'Email'),
                        keyboardType: TextInputType.emailAddress),
                    if (update is UpdateSellerShopStateFormValidate) ...[
                      if (update.errors.email.isNotEmpty)
                        ErrorText(text: update.errors.email.first)
                    ]
                  ],
                );
              },
            ),
            space,
            BlocBuilder<UpdateSellerShopCubit, UpdateSellerShopStateModel>(
              builder: (_, state) {
                final update = state.updateSellerShopState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      initialValue: shop.phone,
                      onChanged: (String name) =>
                          profileCubit.phoneChange(name),
                      decoration: const InputDecoration(hintText: 'Phone'),
                      keyboardType: TextInputType.number,
                    ),
                    if (update is UpdateSellerShopStateFormValidate) ...[
                      if (update.errors.phone.isNotEmpty)
                        ErrorText(text: update.errors.phone.first)
                    ]
                  ],
                );
              },
            ),
            space,
            BlocBuilder<UpdateSellerShopCubit, UpdateSellerShopStateModel>(
              builder: (_, state) {
                final update = state.updateSellerShopState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      initialValue: shop.openAt,
                      onChanged: (String name) =>
                          profileCubit.openAtChange(name),
                      decoration:
                          const InputDecoration(hintText: 'Opening time'),
                      keyboardType: TextInputType.text,
                    ),
                    if (update is UpdateSellerShopStateFormValidate) ...[
                      if (update.errors.openAt.isNotEmpty)
                        ErrorText(text: update.errors.openAt.first)
                    ]
                  ],
                );
              },
            ),
            space,
            BlocBuilder<UpdateSellerShopCubit, UpdateSellerShopStateModel>(
              builder: (_, state) {
                final update = state.updateSellerShopState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      initialValue: shop.closedAt,
                      onChanged: (String name) =>
                          profileCubit.closedAtChange(name),
                      decoration:
                          const InputDecoration(hintText: 'Closing time'),
                      keyboardType: TextInputType.text,
                    ),
                    if (update is UpdateSellerShopStateFormValidate) ...[
                      if (update.errors.closedAt.isNotEmpty)
                        ErrorText(text: update.errors.closedAt.first)
                    ]
                  ],
                );
              },
            ),
            space,
            BlocBuilder<UpdateSellerShopCubit, UpdateSellerShopStateModel>(
              builder: (_, state) {
                final update = state.updateSellerShopState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      initialValue: shop.greetingMessage,
                      onChanged: (String name) =>
                          profileCubit.greetingMessageChange(name),
                      decoration:
                          const InputDecoration(hintText: 'Greeting message'),
                      keyboardType: TextInputType.text,
                    ),
                    if (update is UpdateSellerShopStateFormValidate) ...[
                      if (update.errors.greeting.isNotEmpty)
                        ErrorText(text: update.errors.greeting.first)
                    ]
                  ],
                );
              },
            ),
            space,
            BlocBuilder<UpdateSellerShopCubit, UpdateSellerShopStateModel>(
              builder: (_, state) {
                final update = state.updateSellerShopState;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      initialValue: shop.address,
                      onChanged: (String name) =>
                          profileCubit.addressChange(name),
                      decoration: const InputDecoration(hintText: 'Address'),
                      keyboardType: TextInputType.text,
                    ),
                    if (update is UpdateSellerShopStateFormValidate) ...[
                      if (update.errors.address.isNotEmpty)
                        ErrorText(text: update.errors.address.first)
                    ]
                  ],
                );
              },
            ),
            space,
            BlocBuilder<UpdateSellerShopCubit, UpdateSellerShopStateModel>(
              builder: (_, state) {
                return TextFormField(
                  initialValue: shop.seoTitle,
                  onChanged: (String name) => profileCubit.seoTitleChange(name),
                  decoration: const InputDecoration(hintText: 'Seo Title'),
                  keyboardType: TextInputType.text,
                );
              },
            ),
            space,
            BlocBuilder<UpdateSellerShopCubit, UpdateSellerShopStateModel>(
              builder: (_, state) {
                return TextFormField(
                  initialValue: shop.seoDescription,
                  onChanged: (String name) =>
                      profileCubit.seoDescriptionChange(name),
                  decoration: const InputDecoration(hintText: 'Address'),
                  keyboardType: TextInputType.text,
                );
              },
            ),
            space,
            BlocBuilder<UpdateSellerShopCubit, UpdateSellerShopStateModel>(
              builder: (_, state) {
                final update = state.updateSellerShopState;
                if (update is UpdateSellerShopStateLoading) {
                  return LoadingWidget();
                }
                return PrimaryButton(
                    text: 'Update Shop',
                    onPressed: () {
                      Utils.closeKeyBoard(context);
                      profileCubit.updateSellerShop();
                    });
              },
            ),
            const SizedBox(height: 60.0),
          ],
        ),
      ),
    );
  }
}
