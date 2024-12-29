import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '/core/routes/routes_names.dart';
import '/modules/authentication/login/login_bloc/login_bloc.dart';
import '/modules/profile/controller/seller_profile_cubit.dart';
import '/utils/constants.dart';
import '/utils/loading_widget.dart';
import '/widgets/custom_image.dart';
import '../../core/remote_urls.dart';
import '../../utils/k_images.dart';
import '../../utils/utils.dart';
import '../../widgets/circle_image.dart';
import '../../widgets/confirm_dialog.dart';
import '../../widgets/page_refresh.dart';
import '../../widgets/primary_button.dart';
import '../authentication/login/model/login_state_model.dart';
import 'component/password_change.dart';
import 'controller/update_seller_shop/update_seller_shop_cubit.dart';
import 'model/seller_profile_model.dart';

class SellerProfileScreen extends StatefulWidget {
  const SellerProfileScreen({super.key});

  @override
  State<SellerProfileScreen> createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen> {
  @override
  void initState() {
    print('seller-profile');
    Future.microtask(
            () => context.read<SellerProfileCubit>().getSellerProfile());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sellerCubit = context.read<SellerProfileCubit>();
    final upSeller = context.read<UpdateSellerShopCubit>();
    return Scaffold(
      body: PageRefresh(
        onRefresh: () async {
          context.read<SellerProfileCubit>().getSellerProfile();
        },
        child: BlocBuilder<SellerProfileCubit, SellerProfileState>(
          builder: (_, state) {
            if (state is SellerProfileStateLoading) {
              return LoadingWidget();
            } else if (state is SellerProfileStateError) {
              if (state.statusCode == 503) {
                return LoadedWidget(seller: sellerCubit.sellerProfile!);
              } else {
                return Center(child: Text(state.message));
              }
            } else if (state is SellerProfileStateLoaded) {
              return LoadedWidget(seller: state.sellerProfile);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class LoadedWidget extends StatelessWidget {
  const LoadedWidget({super.key, required this.seller});

  final SellerProfileModel seller;

  @override
  Widget build(BuildContext context) {
    final upSeller = context.read<UpdateSellerShopCubit>();
    final result = seller.seller;
    final profile = seller.user;
    final image = seller.user!.image.isNotEmpty
        ? seller.user!.image
        : seller.defaultProfile!.image;
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        SizedBox(
          height: 500.0,
          width: double.infinity,
          // color: Colors.red,
          child: Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 0.0,
                right: 0.0,
                left: 0.0,
                child: SizedBox(
                  height: 180.0,
                  width: 330.0,
                  child: CustomImage(
                    fit: BoxFit.cover,
                    height: 180.0,
                    width: 330.0,
                    path: RemoteUrls.imageUrl(result!.bannerImage),
                  ),
                ),
              ),
              Positioned(
                bottom: -30.0,
                left: 0.0,
                right: 0.0,
                child: Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Container(
                    // height: 420.0,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleImage(
                              image: RemoteUrls.imageUrl(result.logo),
                              size: 60.0,
                              type: ImageType.border,
                              borderColor: Utils.dynamicPrimaryColor(context),
                            ),
                            const Spacer(),
                            Expanded(
                              child: PrimaryButton(
                                text: 'Edit Info',
                                //onPressed: ()=>Navigator.pushNamed(context, RouteNames.updateSellerShopScreen,arguments: seller),
                                onPressed: () {
                                  upSeller.isNavigate == true;
                                  Navigator.pushNamed(context,
                                      RouteNames.updateSellerShopScreen,
                                      arguments: seller.seller)
                                      .then((_) {
                                    upSeller.isNavigate == false;
                                    upSeller.initState();
                                  });
                                },
                                borderRadiusSize: 20.0,
                              ),
                            ),
                          ],
                        ),
                        _buildSellerInfo('Shop Name', result.shopName),
                        _buildSellerInfo('Email', result.email),
                        _buildSellerInfo('Phone', result.phone),
                        _buildSellerInfo('Open', result.openAt),
                        _buildSellerInfo('Close', result.closedAt),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'User Status:',
                              style: GoogleFonts.roboto(color: grayColor),
                            ),
                            Chip(

                              label: Text(profile!.status == 1
                                  ? 'Active'
                                  : 'Deactivate'),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: transparent),
                                  borderRadius: BorderRadius.circular(20.0)),
                              backgroundColor: greenColor.withOpacity(0.6),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Shop Status:',
                              style: GoogleFonts.roboto(color: grayColor),
                            ),
                            Chip(
                              label: Text(
                                  result.status == 1 ? 'Active' : 'Deactivate'),
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: transparent),
                                  borderRadius: BorderRadius.circular(20.0)),
                              backgroundColor: greenColor.withOpacity(0.6),
                            ),
                          ],
                        ),
                        _buildSellerInfo(
                            'Join at', Utils.formatDate(result.createdAt)),
                        _buildSellerInfo(
                            'Greeting Text', result.greetingMessage),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 30.0,
                  left: 0.0,
                  right: 0.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const CircleAvatar(
                            backgroundColor: whiteColor,
                            radius: 16.0,
                            child: Icon(
                              Icons.arrow_back,
                              color: blackColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 40.0),
                        Text(
                          result.shopName,
                          style: GoogleFonts.inter(
                            fontSize: 24.0,
                            color: whiteColor,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
        const SizedBox(height: 45.0),
        Card(
          // elevation: 6.0,
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Container(
            height: 300.0,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: CustomImage(
                          height: 80.0,
                          width: 80.0,
                          path: RemoteUrls.imageUrl(image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 2,
                      child: PrimaryButton(
                        text: 'Edit Profile',
                        onPressed: () =>
                            Navigator.pushNamed(
                                context, RouteNames.updateSellerProfile,
                                arguments: seller),
                        borderRadiusSize: 20.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                _buildSellerInfo('Name', seller.user!.name),
                _buildSellerInfo('Email', seller.user!.email),
                _buildSellerInfo('Phone', seller.user!.phone),
                _buildSellerInfo('Address', seller.user!.address),
                _buildSellerInfo('ZipCode', seller.user!.zipCode.toString()),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        Card(
          // elevation: 6.0,
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Container(
            height: 120.0,
            width: double.infinity,
            padding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: PrimaryButton(
                        text: 'Change Password',
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            // false = user must tap button, true = tap outside dialog
                            builder: (context) {
                              return const PasswordChange();
                            },
                          );
                        },
                        minimumSize: const Size(40.0, 40.0),
                        borderRadiusSize: 20.0,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 5.0),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '*******',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        _logout(context),
        const SizedBox(height: 45.0),
      ],
    );
  }

  Widget _logout(BuildContext context) {
    return BlocListener<LoginBloc, LoginStateModel>(
        listener: (context, state) {
          final logout = state.loginState;
          if (logout is LoginStateLogoutLoading) {
            Utils.loadingDialog(context);
            log(logout.toString(), name: 'Logging out');
          } else {
            Utils.closeDialog(context);
            if (logout is LoginStateLogoutError) {
              Navigator.of(context).pop(true);
              Utils.errorSnackBar(context, logout.message);
            }
            if (logout is LoginStateLogoutLoaded) {
              Navigator.of(context).pop(true);
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteNames.loginScreen, (
                  route) => false);
              Utils.showSnackBar(context, logout.message);
            }
          }
        },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0)
            .copyWith(bottom: 0.0),
        child: PrimaryButton(
          text: 'Logout',
          bgColor: redColor,
          onPressed: () async {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) =>
                  ConfirmDialog(
                    icon: KImages.logout,
                    message: 'Are you sure,\nyou want Logout?',
                    confirmText: 'Yes, Logout',
                    cancelText: 'Cancel',
                    onTap: () async {
                      context
                          .read<LoginBloc>()
                          .add(const LoginEventLogout());
                    },
                  ),
            );


            // showDialog(
            //   context: context,
            //   barrierDismissible: true,
            //   builder: (context) {
            //     return AlertDialog(
            //       content: BlocListener<LoginBloc, LoginStateModel>(
            //         listener: (context, state) {
            //           final logout = state.loginState;
            //           if (logout is LoginStateLogoutLoading) {
            //             Utils.loadingDialog(context);
            //             log(logout.toString(), name: 'Logging out');
            //           } else {
            //             Utils.closeDialog(context);
            //             if (logout is LoginStateLogoutError) {
            //               Navigator.of(context).pop(true);
            //               Utils.errorSnackBar(context, logout.message);
            //             }
            //             if (logout is LoginStateLogoutLoaded) {
            //               Navigator.of(context).pop(true);
            //               Navigator.pushNamedAndRemoveUntil(
            //                   context, RouteNames.loginScreen, (
            //                   route) => false);
            //               Utils.showSnackBar(context, logout.message);
            //             }
            //           }
            //         },
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(
            //               horizontal: 0.0, vertical: 0.0),
            //           child: Column(
            //             mainAxisSize: MainAxisSize.min,
            //             children: [
            //               const Padding(
            //                   padding: EdgeInsets.symmetric(
            //                       horizontal: 25.0, vertical: 6.0),
            //                   child: CustomImage(path: KImages.logout)),
            //               const SizedBox(height: 10.0),
            //               Text('Do you want to',
            //                   style: GoogleFonts.inter(
            //                       fontWeight: FontWeight.w700,
            //                       fontSize: 20.0,
            //                       color: blackColor)),
            //               const SizedBox(height: 6.0),
            //               Text('LOGOUT?',
            //                   style: GoogleFonts.inter(
            //                       fontWeight: FontWeight.w700,
            //                       fontSize: 20.0,
            //                       color: blackColor)),
            //               const SizedBox(height: 20.0),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   ElevatedButton(
            //                       onPressed: () => Navigator.pop(context),
            //                       style: ButtonStyle(
            //                         minimumSize: WidgetStateProperty.all(
            //                             const Size(120.0, 40.0)),
            //                         backgroundColor:
            //                         WidgetStateProperty.all(blackColor),
            //                         elevation: WidgetStateProperty.all(0.0),
            //                         shadowColor: WidgetStateProperty.all(
            //                             Colors.transparent),
            //                         splashFactory: NoSplash.splashFactory,
            //                       ),
            //                       child: const Text(
            //                         'No',
            //                         style: TextStyle(
            //                             color: whiteColor, fontSize: 20.0),
            //                       )),
            //                   const SizedBox(width: 12.0),
            //                   BlocBuilder<LoginBloc, LoginStateModel>(
            //                     builder: (_, state) {
            //                       return ElevatedButton(
            //                         onPressed: () =>
            //                             context
            //                                 .read<LoginBloc>()
            //                                 .add(const LoginEventLogout()),
            //                         style: ButtonStyle(
            //                           minimumSize: WidgetStateProperty.all(
            //                               const Size(120.0, 40.0)),
            //                           backgroundColor: WidgetStateProperty.all(
            //                               Utils.dynamicPrimaryColor(context)),
            //                           elevation: WidgetStateProperty.all(0.0),
            //                           shadowColor: WidgetStateProperty.all(
            //                               Colors.transparent),
            //                           splashFactory: NoSplash.splashFactory,
            //                         ),
            //                         child: const Text(
            //                           'Yes',
            //                           style: TextStyle(
            //                               color: blackColor, fontSize: 20.0),
            //                         ),
            //                       );
            //                     },
            //                   ),
            //                 ],
            //               ),
            //               // const SizedBox(height: 10.0),
            //             ],
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // );
          },
          fontSize: 18.0,
        ),
      ),
    );
  }

  Widget _buildSellerInfo(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title:',
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.roboto(
                color: grayColor, fontSize: 15.0, fontWeight: FontWeight.w400),
          ),
          Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.roboto(
                color: blackColor, fontSize: 14.0, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
