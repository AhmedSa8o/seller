import 'dart:convert';

import 'package:equatable/equatable.dart';

class SellerSettingModel extends Equatable {
  final int id;
  final int maintenanceMode;
  final String logo;
  final String favicon;
  final String contactEmail;
  final int enableUserRegister;
  final int phoneNumberRequired;
  final String defaultPhoneCode;
  final int enableMultivendor;
  //final String enableSubscriptionNotify;
  //final String enableSaveContactMessage;
  final String textDirection;
  final String timezone;
  final String sidebarLgHeader;
  final String sidebarSmHeader;
  final String topBarPhone;
  final String topBarEmail;
  final String currencyName;
  final String currencyIcon;
  // final double currencyRate;
  //final String showProductProgressbar;
  final String themeOne;
  final String themeTwo;
  final String sellerCondition;
  final String popularCategory;
  //final String popularCategoryProductQty;
  final String frontendUrl;
  final String popularCategoryBanner;
  final String featuredCategoryBanner;
  final String homepageSectionTitle;
  final String emptyCart;
  final String emptyWishlist;
  final String changePasswordImage;
  final String becomeSellerAvatar;
  final String becomeSellerBanner;
  final String loginImage;
  final String errorPage;
  final String createdAt;
  final String updatedAt;

  const SellerSettingModel({
    required this.id,
    required this.maintenanceMode,
    required this.logo,
    required this.favicon,
    required this.contactEmail,
    required this.enableUserRegister,
    required this.phoneNumberRequired,
    required this.defaultPhoneCode,
    required this.enableMultivendor,
    //required this.enableSubscriptionNotify,
    //required this.enableSaveContactMessage,
    required this.textDirection,
    required this.timezone,
    required this.sidebarLgHeader,
    required this.sidebarSmHeader,
    required this.topBarPhone,
    required this.topBarEmail,
    required this.currencyName,
    required this.currencyIcon,
    //required this.currencyRate,
    //required this.showProductProgressbar,
    required this.themeOne,
    required this.themeTwo,
    required this.sellerCondition,
    required this.popularCategory,
    // required this.popularCategoryProductQty,
    required this.frontendUrl,
    required this.popularCategoryBanner,
    required this.featuredCategoryBanner,
    required this.homepageSectionTitle,
    required this.emptyCart,
    required this.emptyWishlist,
    required this.changePasswordImage,
    required this.becomeSellerAvatar,
    required this.becomeSellerBanner,
    required this.loginImage,
    required this.errorPage,
    required this.createdAt,
    required this.updatedAt,
  });

  SellerSettingModel copyWith({
    int? id,
    int? maintenanceMode,
    String? logo,
    String? favicon,
    String? contactEmail,
    int? enableUserRegister,
    int? phoneNumberRequired,
    String? defaultPhoneCode,
    int? enableMultivendor,
    //String? enableSubscriptionNotify,
    //String? enableSaveContactMessage,
    String? textDirection,
    String? timezone,
    String? sidebarLgHeader,
    String? sidebarSmHeader,
    String? topBarPhone,
    String? topBarEmail,
    String? currencyName,
    String? currencyIcon,
    //double? currencyRate,
    //String? showProductProgressbar,
    String? themeOne,
    String? themeTwo,
    String? sellerCondition,
    String? popularCategory,
    //String? popularCategoryProductQty,
    String? frontendUrl,
    String? popularCategoryBanner,
    String? featuredCategoryBanner,
    String? homepageSectionTitle,
    String? emptyCart,
    String? emptyWishlist,
    String? changePasswordImage,
    String? becomeSellerAvatar,
    String? becomeSellerBanner,
    String? loginImage,
    String? errorPage,
    String? createdAt,
    String? updatedAt,
  }) {
    return SellerSettingModel(
      id: id ?? this.id,
      maintenanceMode: maintenanceMode ?? this.maintenanceMode,
      logo: logo ?? this.logo,
      favicon: favicon ?? this.favicon,
      contactEmail: contactEmail ?? this.contactEmail,
      enableUserRegister: enableUserRegister ?? this.enableUserRegister,
      phoneNumberRequired: phoneNumberRequired ?? this.phoneNumberRequired,
      defaultPhoneCode: defaultPhoneCode ?? this.defaultPhoneCode,
      enableMultivendor: enableMultivendor ?? this.enableMultivendor,
      // enableSubscriptionNotify:
      //     enableSubscriptionNotify ?? this.enableSubscriptionNotify,
      // enableSaveContactMessage:
      //     enableSaveContactMessage ?? this.enableSaveContactMessage,
      textDirection: textDirection ?? this.textDirection,
      timezone: timezone ?? this.timezone,
      sidebarLgHeader: sidebarLgHeader ?? this.sidebarLgHeader,
      sidebarSmHeader: sidebarSmHeader ?? this.sidebarSmHeader,
      topBarPhone: topBarPhone ?? this.topBarPhone,
      topBarEmail: topBarEmail ?? this.topBarEmail,
      currencyName: currencyName ?? this.currencyName,
      currencyIcon: currencyIcon ?? this.currencyIcon,
      //currencyRate: currencyRate ?? this.currencyRate,
      // showProductProgressbar:
      //     showProductProgressbar ?? this.showProductProgressbar,
      themeOne: themeOne ?? this.themeOne,
      themeTwo: themeTwo ?? this.themeTwo,
      sellerCondition: sellerCondition ?? this.sellerCondition,
      popularCategory: popularCategory ?? this.popularCategory,
      // popularCategoryProductQty:
      //     popularCategoryProductQty ?? this.popularCategoryProductQty,
      frontendUrl: frontendUrl ?? this.frontendUrl,
      popularCategoryBanner:
          popularCategoryBanner ?? this.popularCategoryBanner,
      featuredCategoryBanner:
          featuredCategoryBanner ?? this.featuredCategoryBanner,
      homepageSectionTitle: homepageSectionTitle ?? this.homepageSectionTitle,
      emptyCart: emptyCart ?? this.emptyCart,
      emptyWishlist: emptyWishlist ?? this.emptyWishlist,
      changePasswordImage: changePasswordImage ?? this.changePasswordImage,
      becomeSellerAvatar: becomeSellerAvatar ?? this.becomeSellerAvatar,
      becomeSellerBanner: becomeSellerBanner ?? this.becomeSellerBanner,
      loginImage: loginImage ?? this.loginImage,
      errorPage: errorPage ?? this.errorPage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'maintenance_mode': maintenanceMode,
      'logo': logo,
      'favicon': favicon,
      'contact_email': contactEmail,
      'enable_user_register': enableUserRegister,
      'phone_number_required': phoneNumberRequired,
      'default_phone_code': defaultPhoneCode,
      'enable_multivendor': enableMultivendor,
      //'enable_subscription_notify': enableSubscriptionNotify,
      //'enable_save_contact_message': enableSaveContactMessage,
      'text_direction': textDirection,
      'timezone': timezone,
      'sidebar_lg_header': sidebarLgHeader,
      'sidebar_sm_header': sidebarSmHeader,
      'topbar_phone': topBarPhone,
      'topbar_email': topBarEmail,
      'currency_name': currencyName,
      'currency_icon': currencyIcon,
      //'currency_rate': currencyRate,
      //'show_product_progressbar': showProductProgressbar,
      'theme_one': themeOne,
      'theme_two': themeTwo,
      'seller_condition': sellerCondition,
      'popular_category': popularCategory,
      //'popular_category_product_qty': popularCategoryProductQty,
      'frontend_url': frontendUrl,
      'popular_category_banner': popularCategoryBanner,
      'featured_category_banner': featuredCategoryBanner,
      'homepage_section_title': homepageSectionTitle,
      'empty_cart': emptyCart,
      'empty_wishlist': emptyWishlist,
      'change_password_image': changePasswordImage,
      'become_seller_avatar': becomeSellerAvatar,
      'become_seller_banner': becomeSellerBanner,
      'login_image': loginImage,
      'error_page': errorPage,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory SellerSettingModel.fromMap(Map<String, dynamic> json) {
    return SellerSettingModel(
      id: json['id'] ?? 0,
      maintenanceMode: json['maintenance_mode'] != null
          ? int.parse(json['maintenance_mode'].toString())
          : 0,
      logo: json['logo'] ?? '',
      favicon: json['favicon'] ?? '',
      contactEmail: json['contact_email'] ?? '',
      enableUserRegister: json['enable_user_register'] != null
          ? int.parse(json['enable_user_register'].toString())
          : 0,
      phoneNumberRequired: json['phone_number_required'] != null
          ? int.parse(json['phone_number_required'].toString())
          : 0,
      defaultPhoneCode: json['default_phone_code'] ?? '',
      enableMultivendor: json['enable_multivendor'] != null
          ? int.parse(json['enable_multivendor'].toString())
          : 0,
      //enableSubscriptionNotify: json['enable_subscription_notify'] ?? '',
      //enableSaveContactMessage: json['enable_save_contact_message'] ?? '',
      textDirection: json['text_direction'] ?? '',
      timezone: json['timezone'] ?? '',
      sidebarLgHeader: json['sidebar_lg_header'] ?? '',
      sidebarSmHeader: json['sidebar_sm_header'] ?? '',
      topBarPhone: json['topbar_phone'] ?? '',
      topBarEmail: json['topbar_email'] ?? '',
      currencyName: json['currency_name'] ?? '',
      currencyIcon: json['currency_icon'] ?? '',
      // currencyRate: json['currency_rate'] != null
      //     ? double.parse(json['currency_rate'])
      //     : 0.0,
      //showProductProgressbar: json['show_product_progressbar'] ?? '',
      themeOne: json['theme_one'] ?? '',
      themeTwo: json['theme_two'] ?? '',
      sellerCondition: json['seller_condition'] ?? '',
      popularCategory: json['popular_category'] ?? '',
      //popularCategoryProductQty: json['popular_category_product_qty'] ?? '',
      frontendUrl: json['frontend_url'] ?? '',
      popularCategoryBanner: json['popular_category_banner'] ?? '',
      featuredCategoryBanner: json['featured_category_banner'] ?? '',
      homepageSectionTitle: json['homepage_section_title'] ?? '',
      emptyCart: json['empty_cart'] ?? '',
      emptyWishlist: json['empty_wishlist'] ?? '',
      changePasswordImage: json['change_password_image'] ?? '',
      becomeSellerAvatar: json['become_seller_avatar'] ?? '',
      becomeSellerBanner: json['become_seller_banner'] ?? '',
      loginImage: json['login_image'] ?? '',
      errorPage: json['error_page'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SellerSettingModel.fromJson(String source) =>
      SellerSettingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      maintenanceMode,
      logo,
      favicon,
      contactEmail,
      enableUserRegister,
      phoneNumberRequired,
      defaultPhoneCode,
      enableMultivendor,
      //enableSubscriptionNotify,
      //enableSaveContactMessage,
      textDirection,
      timezone,
      sidebarLgHeader,
      sidebarSmHeader,
      topBarPhone,
      topBarEmail,
      currencyName,
      currencyIcon,
      //currencyRate,
      //showProductProgressbar,
      themeOne,
      themeTwo,
      sellerCondition,
      popularCategory,
      // popularCategoryProductQty,
      frontendUrl,
      popularCategoryBanner,
      featuredCategoryBanner,
      homepageSectionTitle,
      emptyCart,
      emptyWishlist,
      changePasswordImage,
      becomeSellerAvatar,
      becomeSellerBanner,
      loginImage,
      errorPage,
      createdAt,
      updatedAt,
    ];
  }
}
