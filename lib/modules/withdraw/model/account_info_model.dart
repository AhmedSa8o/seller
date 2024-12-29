import 'dart:convert';

import 'package:equatable/equatable.dart';

class AccountInfoModel extends Equatable {
  final int id;
  final String name;
  final int minAmount;
  final int maxAmount;
  final int withdrawCharge;
  final String description;
  final int status;
  final String createdAt;
  final String updatedAt;

  const AccountInfoModel({
    required this.id,
    required this.name,
    required this.minAmount,
    required this.maxAmount,
    required this.withdrawCharge,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  AccountInfoModel copyWith({
    int? id,
    String? name,
    int? minAmount,
    int? maxAmount,
    int? withdrawCharge,
    String? description,
    int? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return AccountInfoModel(
      id: id ?? this.id,
      name: name ?? this.name,
      minAmount: minAmount ?? this.minAmount,
      maxAmount: maxAmount ?? this.maxAmount,
      withdrawCharge: withdrawCharge ?? this.withdrawCharge,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'min_amount': minAmount,
      'max_amount': maxAmount,
      'withdraw_charge': withdrawCharge,
      'description': description,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory AccountInfoModel.fromMap(Map<String, dynamic> json) {
    return AccountInfoModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      minAmount: json['min_amount'] != null
          ? int.parse(json['min_amount'].toString())
          : 0,
      maxAmount: json['max_amount'] != null
          ? int.parse(json['max_amount'].toString())
          : 0,
      withdrawCharge: json['withdraw_charge'] != null
          ? int.parse(json['withdraw_charge'].toString())
          : 0,
      description: json['description'] ?? '',
      status: json['status'] != null ? int.parse(json['status'].toString()) : 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountInfoModel.fromJson(String source) =>
      AccountInfoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      minAmount,
      maxAmount,
      withdrawCharge,
      description,
      status,
      createdAt,
      updatedAt,
    ];
  }
}
