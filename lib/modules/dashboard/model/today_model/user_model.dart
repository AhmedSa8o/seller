import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String name;
  final String email;
  final String emailVerifiedAt;
  final String forgotPasswordToken;
  final int status;
  final String phone;
  final String image;
  final int provider;
  final int providerId;
  final String providerAvatar;
  final int countryId;
  final int stateId;
  final int cityId;
  final int zipCode;
  final String address;
  final int isVendor;
  final int verifyToken;
  final int emailVerified;
  final int agreePolicy;
  final String createdAt;
  final String updatedAt;
  final double latitude;
  final double longitude;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.forgotPasswordToken,
    required this.status,
    required this.phone,
    required this.image,
    required this.provider,
    required this.providerId,
    required this.providerAvatar,
    required this.countryId,
    required this.stateId,
    required this.cityId,
    required this.zipCode,
    required this.address,
    required this.isVendor,
    required this.verifyToken,
    required this.emailVerified,
    required this.agreePolicy,
    required this.createdAt,
    required this.updatedAt,
    required this.latitude,
    required this.longitude,
  });

  //               "agree_policy": "1",
  //               "created_at": "2022-09-20T21:08:27.000000Z",
  //               "updated_at": "2023-01-18T05:28:28.000000Z"

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? emailVerifiedAt,
    String? forgotPasswordToken,
    int? status,
    String? phone,
    String? image,
    int? provider,
    int? providerId,
    String? providerAvatar,
    int? countryId,
    int? stateId,
    int? cityId,
    int? zipCode,
    String? address,
    int? isVendor,
    int? verifyToken,
    int? emailVerified,
    int? agreePolicy,
    String? createdAt,
    String? updatedAt,
    double? latitude,
    double? longitude,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      forgotPasswordToken: forgotPasswordToken ?? this.forgotPasswordToken,
      status: status ?? this.status,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      provider: provider ?? this.provider,
      providerId: providerId ?? this.providerId,
      providerAvatar: providerAvatar ?? this.providerAvatar,
      countryId: countryId ?? this.countryId,
      stateId: stateId ?? this.stateId,
      cityId: cityId ?? this.cityId,
      zipCode: zipCode ?? this.zipCode,
      address: address ?? this.address,
      isVendor: isVendor ?? this.isVendor,
      verifyToken: verifyToken ?? this.verifyToken,
      emailVerified: emailVerified ?? this.emailVerified,
      agreePolicy: agreePolicy ?? this.agreePolicy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'forget_password_token': forgotPasswordToken,
      'status': status,
      'phone': phone,
      'image': image,
      'provider': provider,
      'provider_id': providerId,
      'provider_avatar': providerAvatar,
      'country_id': countryId,
      'state_id': stateId,
      'city_id': cityId,
      'zip_code': zipCode,
      'address': address,
      'is_vendor': isVendor,
      'verify_token': verifyToken,
      'email_verified': emailVerified,
      'agree_policy': agreePolicy,
      'created_at': createdAt,
      'update_at': updatedAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? int.parse(map['id']),
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      emailVerifiedAt: map['email_verified_at'] ?? '',
      forgotPasswordToken: map['forget_password_token'] ?? '',
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      phone: map['phone'] ?? '',
      image: map['image'] ?? '',
      provider:
          map['provider'] != null ? int.parse(map['provider'].toString()) : 0,
      providerId: map['provider_id'] != null
          ? int.parse(map['provider'].toString())
          : 0,
      providerAvatar: map['provider_avatar'] ?? '',
      countryId: map['country_id'] != null
          ? int.parse(map['country_id'].toString())
          : 0,
      stateId:
          map['state_id'] != null ? int.parse(map['state_id'].toString()) : 0,
      /////
      cityId: map['city_id'] != null ? int.parse(map['city_id'].toString()) : 0,
      zipCode:
          map['zip_code'] != null ? int.parse(map['zip_code'].toString()) : 0,
      address: map['address'] ?? '',
      isVendor:
          map['is_vendor'] != null ? int.parse(map['is_vendor'].toString()) : 0,
      verifyToken: map['verify_token'] != null
          ? int.parse(map['verify_token'].toString())
          : 0,
      emailVerified: map['email_verified'] != null
          ? int.parse(map['email_verified'].toString())
          : 0,
      agreePolicy: map['agree_policy'] != null
          ? int.parse(map['agree_policy'].toString())
          : 0,
      latitude: map['latitude'] != null
          ? double.parse(map['latitude'].toString())
          : 0,
      longitude: map['longitude'] != null
          ? double.parse(map['longitude'].toString())
          : 0,
      createdAt: map['createdAt'] ?? '',
      updatedAt: map['updatedAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      email,
      emailVerifiedAt,
      forgotPasswordToken,
      status,
      phone,
      image,
      provider,
      providerId,
      providerAvatar,
      countryId,
      stateId,
      cityId,
      zipCode,
      address,
      isVendor,
      verifyToken,
      emailVerified,
      agreePolicy,
      latitude,
      longitude,
      createdAt,
      updatedAt,
    ];
  }
}
