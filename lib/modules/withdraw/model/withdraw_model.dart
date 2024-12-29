import 'dart:convert';

import 'package:equatable/equatable.dart';

class WithdrawModel extends Equatable {
  final int id;
  final int sellerId;
  final String method;
  final int totalAmount;
  final double withdrawAmount;
  final double withdrawCharge;
  final String accountInfo;
  final int status;
  final String approvedDate;
  final String createdAt;
  final String updatedAt;

  const WithdrawModel({
    required this.id,
    required this.sellerId,
    required this.method,
    required this.totalAmount,
    required this.withdrawAmount,
    required this.withdrawCharge,
    required this.accountInfo,
    required this.status,
    required this.approvedDate,
    required this.createdAt,
    required this.updatedAt,
  });

  WithdrawModel copyWith({
    int? id,
    int? sellerId,
    String? method,
    int? totalAmount,
    double? withdrawAmount,
    double? withdrawCharge,
    String? accountInfo,
    int? status,
    String? approvedDate,
    String? createdAt,
    String? updatedAt,
  }) {
    return WithdrawModel(
      id: id ?? this.id,
      sellerId: sellerId ?? this.sellerId,
      method: method ?? this.method,
      totalAmount: totalAmount ?? this.totalAmount,
      withdrawAmount: withdrawAmount ?? this.withdrawAmount,
      withdrawCharge: withdrawCharge ?? this.withdrawCharge,
      accountInfo: accountInfo ?? this.accountInfo,
      status: status ?? this.status,
      approvedDate: approvedDate ?? this.approvedDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'seller_id': sellerId,
      'method': method,
      'total_amount': totalAmount,
      'withdraw_amount': withdrawAmount,
      'withdraw_charge': withdrawCharge,
      'account_info': accountInfo,
      'status': status,
      'approved_date': approvedDate,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory WithdrawModel.fromMap(Map<String, dynamic> map) {
    return WithdrawModel(
      id: map['id'] ?? 0,
      sellerId:
          map['seller_id'] != null ? int.parse(map['seller_id'].toString()) : 0,
      method: map['method'] ?? '',
      totalAmount: map['total_amount'] != null
          ? int.parse(map['total_amount'].toString())
          : 0,
      withdrawAmount: map['withdraw_amount'] != null
          ? double.parse(map['withdraw_amount'].toString())
          : 0.0,
      withdrawCharge: map['withdraw_charge'] != null
          ? double.parse(map['withdraw_charge'].toString())
          : 0.0,
      accountInfo: map['account_info'] ?? '',
      status: map['status'] != null ? int.parse(map['status'].toString()) : 0,
      approvedDate: map['approved_date'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory WithdrawModel.fromJson(String source) =>
      WithdrawModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WithdrawModel(id: $id, sellerId: $sellerId, method: $method, totalAmount: $totalAmount, withdrawAmount: $withdrawAmount, withdrawCharge: $withdrawCharge, accountInfo: $accountInfo, status: $status, approvedDate: $approvedDate, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  List<Object> get props {
    return [
      id,
      sellerId,
      method,
      totalAmount,
      withdrawAmount,
      withdrawCharge,
      accountInfo,
      status,
      approvedDate,
      createdAt,
      updatedAt,
    ];
  }
}
