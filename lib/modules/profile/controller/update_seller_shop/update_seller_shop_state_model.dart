import 'package:equatable/equatable.dart';

import 'update_seller_shop_cubit.dart';

class UpdateSellerShopStateModel extends Equatable {
  final String logo;
  final String bannerImage;
  final String shopName;
  final String email;
  final String phone;
  final String openAt;
  final String closeAt;
  final String address;
  final String greetingMessage;
  final String seoTitle;
  final String seoDescription;
  final List<String> links;
  final List<String> icons;
  final UpdateSellerShopState updateSellerShopState;

  const UpdateSellerShopStateModel({
    this.logo = '',
    this.bannerImage = '',
    this.shopName = '',
    this.email = '',
    this.phone = '',
    this.openAt = '',
    this.closeAt = '',
    this.address = '',
    this.greetingMessage = '',
    this.seoTitle = '',
    this.seoDescription = '',
    this.links = const [],
    this.icons = const [],
    this.updateSellerShopState = const UpdateSellerShopInitial(),
  });

  UpdateSellerShopStateModel copyWith({
    String? logo,
    String? bannerImage,
    String? shopName,
    String? email,
    String? phone,
    String? openAt,
    String? closeAt,
    String? address,
    String? greetingMessage,
    String? seoTitle,
    String? seoDescription,
    List<String>? links,
    List<String>? icons,
    UpdateSellerShopState? updateSellerShopState,
  }) {
    return UpdateSellerShopStateModel(
      logo: logo ?? this.logo,
      bannerImage: bannerImage ?? this.bannerImage,
      shopName: shopName ?? this.shopName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      openAt: openAt ?? this.openAt,
      closeAt: closeAt ?? this.closeAt,
      address: address ?? this.address,
      greetingMessage: greetingMessage ?? this.greetingMessage,
      seoTitle: seoTitle ?? this.seoTitle,
      seoDescription: seoDescription ?? this.seoDescription,
      links: links ?? this.links,
      icons: icons ?? this.icons,
      updateSellerShopState:
          updateSellerShopState ?? this.updateSellerShopState,
    );
  }

  Map<String, String> toMap() {
    // return <String, String>{
    //   'logo': logo,
    //   'banner_image': bannerImage,
    //   'shop_name': shopName,
    //   'email': email,
    //   'phone': phone,
    //   'opens_at': openAt,
    //   'closed_at': closeAt,
    //   'address': address,
    //   'greeting_msg': greetingMessage,
    //   'seo_title': seoTitle,
    //   'seo_description': seoDescription,
    //   // 'links': links.map((e) => e.toString()).toString(),
    //   // 'icons': icons.map((e) => e.toString()).toString(),
    // };
    final Map<String, String> map = {};
    map.addAll({'logo': logo});
    map.addAll({'banner_image': bannerImage});
    map.addAll({'shop_name': shopName});
    map.addAll({'email': email});
    map.addAll({'phone': phone});
    map.addAll({'opens_at': openAt});
    map.addAll({'closed_at': closeAt});
    map.addAll({'address': address});
    map.addAll({'greeting_msg': greetingMessage});
    map.addAll({'seo_title': seoTitle});
    map.addAll({'seo_description': seoDescription});
    map.addAll({'links[0]': links.map((e) => e.toString()).toString()});
    map.addAll({'icons[0]': icons.map((e) => e.toString()).toString()});
    return map;
  }

  UpdateSellerShopStateModel clear() {
    return const UpdateSellerShopStateModel(
      logo: '',
      bannerImage: '',
      shopName: '',
      email: '',
      phone: '',
      openAt: '',
      closeAt: '',
      address: '',
      greetingMessage: '',
      seoTitle: '',
      seoDescription: '',
      links: [],
      icons: [],
      updateSellerShopState: UpdateSellerShopInitial(),
    );
  }

  @override
  List<Object> get props {
    return [
      logo,
      bannerImage,
      shopName,
      email,
      phone,
      openAt,
      closeAt,
      address,
      greetingMessage,
      seoTitle,
      seoDescription,
      links,
      icons,
      updateSellerShopState,
    ];
  }
}
