import 'dart:convert';

import 'package:equatable/equatable.dart';

class Errors extends Equatable {
  final List<String> agree;
  final List<String> email;
  final List<String> phone;
  final List<String> password;
  final List<String> address;
  final List<String> country;
  final List<String> state;
  final List<String> city;
  final List<String> subject;
  final List<String> message;
  final List<String> review;
  final List<String> shortNameAr; // Added
  final List<String> nameAr; // Added
  final List<String> shortDescriptionAr; // Added
  final List<String> longDescriptionAr; // Added

  final List<String> shortName;
  final List<String> name;
  final List<String> shopName;
  final List<String> slug;
  final List<String> thumbImage;
  final List<String> video;
  final List<String> category;
  final List<String> shortDescription;
  final List<String> longDescription;
  final List<String> price;
  final List<String> status;
  final List<String> weight;
  final List<String> quantity;
  final List<String> zipCode;
  final List<String> openAt;
  final List<String> closedAt;
  final List<String> greeting;

  final List<String> methodId;
  final List<String> withdrawAmount;
  final List<String> accountInfo;

  const Errors({
    required this.agree,
    required this.email,
    required this.phone,
    required this.password,
    required this.address,
    required this.country,
    required this.state,
    required this.city,
    required this.subject,
    required this.message,
    required this.review,
    required this.shortName,
    required this.name,
    required this.shopName,
    required this.slug,
    required this.thumbImage,
    required this.video,
    required this.category,
    required this.shortDescription,
    required this.longDescription,
    required this.price,
    required this.status,
    required this.weight,
    required this.quantity,
    required this.zipCode,
    required this.openAt,
    required this.closedAt,
    required this.shortDescriptionAr,
    required this.longDescriptionAr,
    required this.shortNameAr,
    required this.nameAr,
    required this.greeting,
    required this.methodId,
    required this.withdrawAmount,
    required this.accountInfo,
  });

  Errors copyWith({
    List<String>? email,
    List<String>? phone,
    List<String>? agree,
    List<String>? password,
    List<String>? address,
    List<String>? country,
    List<String>? state,
    List<String>? city,
    List<String>? subject,
    List<String>? message,
    List<String>? review,
    List<String>? shortName,
    List<String>? name,
    List<String>? shopName,
    List<String>? slug,
    List<String>? thumbImage,
    List<String>? video,
    List<String>? category,
    List<String>? shortDescription,
    List<String>? longDescription,
    List<String>? price,
    List<String>? status,
    List<String>? weight,
    List<String>? quantity,
    List<String>? zipCode,
    List<String>? openAt,
    List<String>? closedAt,
    List<String>? greeting,
    List<String>? nameAr,
    List<String>? shortNameAr,
    List<String>? longDescriptionAr,
    List<String>? shortDescriptionAr,
    List<String>? methodId,
    List<String>? withdrawAmount,
    List<String>? accountInfo,
  }) {
    return Errors(
      agree: agree ?? this.agree,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      address: address ?? this.address,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      subject: subject ?? this.subject,
      message: message ?? this.message,
      review: review ?? this.review,
      name: name ?? this.name,
      shopName: shopName ?? this.shopName,
      shortName: shortName ?? this.shortName,
      thumbImage: thumbImage ?? this.thumbImage,
      video: video ?? this.video,
      slug: slug ?? this.slug,
      category: category ?? this.category,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      shortDescription: shortDescription ?? this.shortDescription,
      longDescription: longDescription ?? this.longDescription,
      status: status ?? this.status,
      weight: weight ?? this.weight,
      zipCode: zipCode ?? this.zipCode,
      openAt: openAt ?? this.openAt,
      closedAt: closedAt ?? this.closedAt,
      greeting: greeting ?? this.greeting,
      methodId: methodId ?? this.methodId,
      withdrawAmount: withdrawAmount ?? this.withdrawAmount,
      accountInfo: accountInfo ?? this.accountInfo,
      shortDescriptionAr: shortDescriptionAr ?? this.shortDescriptionAr,
      longDescriptionAr: longDescriptionAr ?? this.longDescriptionAr,
      shortNameAr: shortNameAr ?? this.shortNameAr,
      nameAr: nameAr ?? this.nameAr,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'agree': agree,
      'email': email,
      'phone': phone,
      'password': password,
      'address': address,
      'country': country,
      'state': state,
      'name_ar': nameAr,
      'short_name_ar': shortNameAr,
      'long_description_ar': longDescriptionAr,
      'short_description_ar': shortDescriptionAr,
      'city': city,
      'subject': subject,
      'message': message,
      'review': review,
      'name': name,
      'shop_name': shopName,
      'short_name': shortName,
      'thumb_image': thumbImage,
      'video': video,
      'slug': slug,
      'category': category,
      'price': price,
      'quantity': quantity,
      'short_description': shortDescription,
      'long_description': longDescription,
      'status': status,
      'weight': weight,
      'zip_code': weight,
      'opens_at': openAt,
      'closed_at': closedAt,
      'greeting_msg': greeting,
      'method_id': methodId,
      'withdraw_amount': withdrawAmount,
      'account_info': accountInfo,
    };
  }

  factory Errors.fromMap(Map<String, dynamic> map) {
    return Errors(
      agree: map['agree'] != null
          ? List<String>.from(map['agree'].map((x) => x))
          : [],
      email: map['email'] != null
          ? List<String>.from(map['email'].map((x) => x))
          : [],
      phone: map['phone'] != null
          ? List<String>.from(map['phone'].map((x) => x))
          : [],
      password: map['password'] != null
          ? List<String>.from(map['password'].map((x) => x))
          : [],
      address: map['address'] != null
          ? List<String>.from(map['address'].map((x) => x))
          : [],
      country: map['country'] != null
          ? List<String>.from(map['country'].map((x) => x))
          : [],
      state: map['state'] != null
          ? List<String>.from(map['state'].map((x) => x))
          : [],
      city: map['city'] != null
          ? List<String>.from(map['city'].map((x) => x))
          : [],
      subject: map['subject'] != null
          ? List<String>.from(map['subject'].map((x) => x))
          : [],
      message: map['message'] != null
          ? List<String>.from(map['message'].map((x) => x))
          : [],
      review: map['review'] != null
          ? List<String>.from(map['review'].map((x) => x))
          : [],
      name: map['name'] != null
          ? List<String>.from(map['name'].map((x) => x))
          : [],
      shopName: map['shop_name'] != null
          ? List<String>.from(map['shop_name'].map((x) => x))
          : [],
      shortName: map['short_name'] != null
          ? List<String>.from(map['short_name'].map((x) => x))
          : [],
      thumbImage: map['thumb_image'] != null
          ? List<String>.from(map['thumb_image'].map((x) => x))
          : [],
      video: map['video'] != null
          ? List<String>.from(map['video'].map((x) => x))
          : [],
      slug: map['slug'] != null
          ? List<String>.from(map['slug'].map((x) => x))
          : [],
      category: map['category'] != null
          ? List<String>.from(map['category'].map((x) => x))
          : [],
      price: map['price'] != null
          ? List<String>.from(map['price'].map((x) => x))
          : [],
      quantity: map['quantity'] != null
          ? List<String>.from(map['quantity'].map((x) => x))
          : [],
      shortDescription: map['short_description'] != null
          ? List<String>.from(map['short_description'].map((x) => x))
          : [],
      longDescription: map['long_description'] != null
          ? List<String>.from(map['long_description'].map((x) => x))
          : [],
      status: map['status'] != null
          ? List<String>.from(map['status'].map((x) => x))
          : [],
      weight: map['weight'] != null
          ? List<String>.from(map['weight'].map((x) => x))
          : [],
      zipCode: map['zip_code'] != null
          ? List<String>.from(map['zip_code'].map((x) => x))
          : [],
      openAt: map['opens_at'] != null
          ? List<String>.from(map['opens_at'].map((x) => x))
          : [],
      closedAt: map['closed_at'] != null
          ? List<String>.from(map['closed_at'].map((x) => x))
          : [],
      greeting: map['greeting_msg'] != null
          ? List<String>.from(map['greeting_msg'].map((x) => x))
          : [],
      methodId: map['method_id'] != null
          ? List<String>.from(map['method_id'].map((x) => x))
          : [],
      withdrawAmount: map['withdraw_amount'] != null
          ? List<String>.from(map['withdraw_amount'].map((x) => x))
          : [],
      accountInfo: map['account_info'] != null
          ? List<String>.from(map['account_info'].map((x) => x))
          : [],
      nameAr: map['name_ar'] != null
          ? List<String>.from(map['name_ar'].map((x) => x))
          : [],
      shortNameAr: map['short_name_ar'] != null
          ? List<String>.from(map['short_name_ar'].map((x) => x))
          : [],
      longDescriptionAr: map['long_description_ar'] != null
          ? List<String>.from(map['long_description_ar'].map((x) => x))
          : [],
      shortDescriptionAr: map['short_description_ar'] != null
          ? List<String>.from(map['short_description_ar'].map((x) => x))
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Errors.fromJson(String source) =>
      Errors.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        name,
        shopName,
        agree,
        email,
        phone,
        password,
        address,
        country,
        state,
        city,
        shortName,
        thumbImage,
        video,
        slug,
        category,
        price,
        quantity,
        shortDescription,
        longDescription,
        status,
        weight,
        zipCode,
        openAt,
        closedAt,
        greeting,
        methodId,
        withdrawAmount,
        accountInfo,
      ];
}
