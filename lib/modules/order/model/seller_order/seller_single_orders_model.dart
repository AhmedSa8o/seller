import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../dashboard/model/today_order_model.dart';

class SellerSingleOrderModel extends Equatable {
  final int currentPage;
  final List<TodayOrderedModel> data;
  final int from;
  final int lastPage;
  final int perPage;
  final int to;
  final int total;

  const SellerSingleOrderModel({
    required this.currentPage,
    required this.data,
    required this.from,
    required this.lastPage,
    required this.perPage,
    required this.to,
    required this.total,
  });

  SellerSingleOrderModel copyWith({
    int? currentPage,
    List<TodayOrderedModel>? data,
    int? from,
    int? lastPage,
    int? perPage,
    int? to,
    int? total,
  }) {
    return SellerSingleOrderModel(
      currentPage: currentPage ?? this.currentPage,
      data: data ?? this.data,
      from: from ?? this.from,
      lastPage: lastPage ?? this.lastPage,
      perPage: perPage ?? this.perPage,
      to: to ?? this.to,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'current_page': currentPage,
      'data': data.map((x) => x.toMap()).toList(),
      'from': from,
      'last_page': lastPage,
      'per_page': perPage,
      'to': to,
      'total': total,
    };
  }

  factory SellerSingleOrderModel.fromMap(Map<String, dynamic> map) {
    return SellerSingleOrderModel(
      currentPage: map['current_page'] ?? 0,
      data: map['data'] != null
          ? List<TodayOrderedModel>.from(
        (map['data'] as List<dynamic>).map<TodayOrderedModel>(
              (x) => TodayOrderedModel.fromMap(x as Map<String, dynamic>),
        ),
      )
          : [],
      from: map['from'] ?? 0,
      lastPage: map['last_page'] ?? 0,
      perPage: map['per_page'] ?? 0,
      to: map['to'] ?? 0,
      total: map['total'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SellerSingleOrderModel.fromJson(String source) =>
      SellerSingleOrderModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      currentPage,
      data,
      from,
      lastPage,
      perPage,
      to,
      total,
    ];
  }
}
