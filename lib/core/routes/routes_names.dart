import 'package:flutter/material.dart';

import '../../widgets/maintain_screen.dart';
import '/modules/my_shop/my_shop_screen.dart';
import '/modules/on_boarding/on_boarding_screen.dart';
import '/modules/order/order_details_screen.dart';
import '/modules/profile/seller_profile_screen.dart';
import '/modules/splash/splash_screen.dart';
import '../../modules/authentication/forgot_password_screen.dart';
import '../../modules/authentication/login/login_screen.dart';
import '../../modules/authentication/update_password_screen.dart';
import '../../modules/authentication/verification_screen.dart';
import '../../modules/dashboard/dashboard_screen.dart';
import '../../modules/dashboard/model/seller_model/seller_model.dart';
import '../../modules/gallery/gallery_screen.dart';
import '../../modules/home/home_screen.dart';
import '../../modules/my_shop/component/pending_product_screen.dart';
import '../../modules/order/model/single_product_model/single_product_model.dart';
import '../../modules/order/seller_all_order_screen.dart';
import '../../modules/profile/model/seller_profile_model.dart';
import '../../modules/profile/update_seller_profile.dart';
import '../../modules/profile/update_seller_shop_screen.dart';
import '../../modules/review/review_screen.dart';
import '../../modules/store_product/store_product_screen.dart';
import '../../modules/update/update_screen.dart';
import '../../modules/variant/model/single_variant_model/single_variant_model.dart';
import '../../modules/variant/variant_screen.dart';
import '../../modules/variant_items/variant_item_screen.dart';
import '../../modules/video/video_screen.dart';

class RouteNames {
  static const String animatedSplashScreen = '/animatedSplashScreen';
  static const String onBoardingScreen = '/onBoardingScreen';
  static const String loginScreen = '/loginScreen';
  static const String forgotPasswordScreen = '/forgotPasswordScreen';
  static const String updatePasswordScreen = '/updatePasswordScreen';
  static const String verificationScreen = '/verificationScreen';
  static const String homeScreen = '/homeScreen';
  static const String sellerProfileScreen = '/sellerProfileScreen';
  static const String sellerAllOrderScreen = '/sellerAllOrderScreen';
  static const String orderDetailsScreen = '/orderDetailsScreen';
  static const String reviewScreen = '/reviewScreen';
  static const String storeProductScreen = '/storeProductScreen';
  static const String galleryScreen = '/galleryScreen';
  static const String variantScreen = '/variantScreen';
  static const String variantItemScreen = '/variantItemScreen';

  // static const String storeVariantItemScreen = 'storeVariantItemScreen';
  // static const String updateProductVariantItemScreen =
  //     'updateProductVariantItemScreen';

  static const String dashBoardScreen = '/dashBoardScreen';
  static const String updateSellerProfile = '/updateSellerProfile';
  static const String updateSellerShopScreen = '/updateSellerShopScreen';

  static const String orderScreen = '/orderScreen';
  static const String pendingProductScreen = '/pendingProductScreen';

  static const String myShopScreen = '/myShopScreen';
  static const String updateProductScreen = '/updateProductScreen';
  static const String videoScreen = '/videoScreen';
  static const String maintainScreen = '/maintainScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case animatedSplashScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AnimatedSplashScreen());

      case onBoardingScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const OnBoardingScreen());

      case loginScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const LoginScreen());

      case forgotPasswordScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ForgotPasswordScreen());

      case verificationScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const VerificationScreen());

      case updatePasswordScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const UpdatePasswordScreen());

      case homeScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const HomeScreen());

      case galleryScreen:
        final id = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings, builder: (_) => GalleryScreen(id: id));

      case variantScreen:
        final productId = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => VariantScreen(productId: productId));

      case variantItemScreen:
        final variant = settings.arguments as SingleVariantModel;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => VariantItemScreen(variant: variant));

      case RouteNames.maintainScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const MaintainScreen());

      // case storeVariantItemScreen:
      //   final variant = settings.arguments as SingleVariantModel;
      //   return MaterialPageRoute(
      //       settings: settings,
      //       builder: (_) => StoreVariantItemScreen(variant: variant));
      //
      // case updateProductVariantItemScreen:
      //   final item = settings.arguments as SingleVariantItemModel;
      //   return MaterialPageRoute(
      //       settings: settings,
      //       builder: (_) => UpdateProductVariantItemScreen(item: item));

      case dashBoardScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const DashboardScreen());

      case updateSellerProfile:
        final seller = settings.arguments as SellerProfileModel;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => UpdateSellerProfileScreen(seller: seller));

      case updateSellerShopScreen:
        final seller = settings.arguments as SellerModel;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => UpdateSellerShopScreen(seller: seller));

      case storeProductScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const StoreProductScreen());
      case pendingProductScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const PendingProductScreen());

      case sellerProfileScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SellerProfileScreen());

      case sellerAllOrderScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SellerAllOrderScreen());

      case orderDetailsScreen:
        String id = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings, builder: (_) => OrderDetailsScreen(id: id));

      case reviewScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ReviewScreen());

      case videoScreen:
        final productId = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => VideoScreen(productId: productId));

      case myShopScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const MyShopScreen());

      case updateProductScreen:
        // final productId = settings.arguments as String;
        final product = settings.arguments as SingleProductModel;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => UpdateProductScreen(product: product));

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
