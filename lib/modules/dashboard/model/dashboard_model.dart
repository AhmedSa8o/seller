import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'seller_model/seller_model.dart';
import 'today_order_model.dart';

class DashboardModel extends Equatable {
  final int todayTotalOrder;
  final List<TodayOrderedModel> todayOrders;
  final int todayEarning;
  final int todayPendingEarning;
  final int todayProductSale;
  final int monthlyTotalOrder;
  final int thisMonthEarning;
  final int thisMonthProductSale;
  final int yearlyTotalOrder;
  final int thisYearEarning;
  final int thisYearProductSale;
  //final int totalOrder;
  final int totalPendingOrder;
  final int totalDeclinedOrder;
  final int totalCompleteOrder;
  final int totalEarning;
  final int totalProductSale;
  final int totalProduct;
  final int reviews;
  final int reports;
  final SellerModel? seller;
  final double totalWithdraw;
  final double totalPendingWithdraw;

  const DashboardModel({
    required this.todayTotalOrder,
    required this.todayOrders,
    required this.todayEarning,
    required this.todayPendingEarning,
    required this.todayProductSale,
    required this.monthlyTotalOrder,
    required this.thisMonthEarning,
    required this.thisMonthProductSale,
    required this.yearlyTotalOrder,
    required this.thisYearEarning,
    required this.thisYearProductSale,
    //required this.totalOrder,
    required this.totalPendingOrder,
    required this.totalDeclinedOrder,
    required this.totalCompleteOrder,
    required this.totalEarning,
    required this.totalProductSale,
    required this.totalProduct,
    required this.reviews,
    required this.reports,
    this.seller,
    required this.totalWithdraw,
    required this.totalPendingWithdraw,
  });

  DashboardModel copyWith({
    int? todayTotalOrder,
    List<TodayOrderedModel>? todayOrders,
    int? todayEarning,
    int? todayPendingEarning,
    int? todayProductSale,
    int? monthlyTotalOrder,
    int? thisMonthEarning,
    int? thisMonthProductSale,
    int? yearlyTotalOrder,
    int? thisYearEarning,
    int? thisYearProductSale,
    //int? totalOrder,
    int? totalPendingOrder,
    int? totalDeclinedOrder,
    int? totalCompleteOrder,
    int? totalEarning,
    int? totalProductSale,
    int? totalProduct,
    int? reviews,
    int? reports,
    SellerModel? seller,
    double? totalWithdraw,
    double? totalPendingWithdraw,
  }) {
    return DashboardModel(
      todayTotalOrder: todayTotalOrder ?? this.todayTotalOrder,
      todayOrders: todayOrders ?? this.todayOrders,
      todayEarning: todayEarning ?? this.todayEarning,
      todayPendingEarning: todayPendingEarning ?? this.todayPendingEarning,
      todayProductSale: todayProductSale ?? this.todayProductSale,
      monthlyTotalOrder: monthlyTotalOrder ?? this.monthlyTotalOrder,
      thisMonthEarning: thisMonthEarning ?? this.thisMonthEarning,
      thisMonthProductSale: thisMonthProductSale ?? this.thisMonthProductSale,
      yearlyTotalOrder: yearlyTotalOrder ?? this.yearlyTotalOrder,
      thisYearEarning: thisYearEarning ?? this.thisYearEarning,
      thisYearProductSale: thisYearProductSale ?? this.thisYearProductSale,
      //totalOrder: totalOrder ?? this.totalOrder,
      totalPendingOrder: totalPendingOrder ?? this.totalPendingOrder,
      totalDeclinedOrder: totalDeclinedOrder ?? this.totalDeclinedOrder,
      totalCompleteOrder: totalCompleteOrder ?? this.totalCompleteOrder,
      totalEarning: totalEarning ?? this.totalEarning,
      totalProductSale: totalProductSale ?? this.totalProductSale,
      totalProduct: totalProduct ?? this.totalProduct,
      reviews: reviews ?? this.reviews,
      reports: reports ?? this.reports,
      seller: seller ?? this.seller,
      totalWithdraw: totalWithdraw ?? this.totalWithdraw,
      totalPendingWithdraw: totalPendingWithdraw ?? this.totalPendingWithdraw,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'todayTotalOrder': todayTotalOrder,
      'todayOrders': todayOrders.map((x) => x.toMap()).toList(),
      'todayEarning': todayEarning,
      'todayPendingEarning': todayPendingEarning,
      'todayProductSale': todayProductSale,
      'monthlyTotalOrder': monthlyTotalOrder,
      'thisMonthEarning': thisMonthEarning,
      'thisMonthProductSale': thisMonthProductSale,
      'yearlyTotalOrder': yearlyTotalOrder,
      'thisYearEarning': thisYearEarning,
      'thisYearProductSale': thisYearProductSale,
      //'totalOrder': totalOrder,
      'totalPendingOrder': totalPendingOrder,
      'totalDeclinedOrder': totalDeclinedOrder,
      'totalCompleteOrder': totalCompleteOrder,
      'totalEarning': totalEarning,
      'totalProductSale': totalProductSale,
      'totalProduct': totalProduct,
      'reviews': reviews,
      'reports': reports,
      'seller': seller?.toMap(),
      'totalWithdraw': totalWithdraw,
      'totalPendingWithdraw': totalPendingWithdraw,
    };
  }

  factory DashboardModel.fromMap(Map<String, dynamic> map) {
    print('PendingWithdraw ${map['totalPendingWithdraw'].runtimeType}');
    print('TotalWithdraw ${map['totalWithdraw'].runtimeType}');
    return DashboardModel(
      todayTotalOrder: map['todayTotalOrder'] ?? 0,
      todayOrders: map['todayOrders'] != null
          ? List<TodayOrderedModel>.from(
              (map['todayOrders'] as List<dynamic>).map<TodayOrderedModel>(
                (x) => TodayOrderedModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
      todayEarning: map['todayEarning'] != null
          ? int.parse(map['todayEarning'].toString())
          : 0,
      todayPendingEarning: map['todayPendingEarning'] ?? 0,
      todayProductSale: map['todayProductSale'] ?? 0,
      monthlyTotalOrder: map['monthlyTotalOrder'] ?? 0,
      thisMonthEarning: map['thisMonthEarning'] ?? 0,
      thisMonthProductSale: map['thisMonthProductSale'] ?? 0,
      yearlyTotalOrder: map['yearlyTotalOrder'] ?? 0,
      thisYearEarning: map['thisYearEarning'] ?? 0,
      thisYearProductSale: map['thisYearProductSale'] ?? 0,
      //totalOrder: map['totalOrder'] ?? 0,
      totalPendingOrder: map['totalPendingOrder'] ?? 0,
      totalDeclinedOrder: map['totalDeclinedOrder'] ?? 0,
      totalCompleteOrder: map['totalCompleteOrder'] ?? 0,
      totalEarning: map['totalEarning'] ?? 0,
      totalProductSale: map['totalProductSale'] ?? 0,
      totalProduct: map['total_product'] ?? 0,
      reviews: map['reviews'] ?? 0,
      reports: map['reports'] ?? 0,
      seller: map['seller'] != null
          ? SellerModel.fromMap(map['seller'] as Map<String, dynamic>)
          : null,
      totalWithdraw: map['totalWithdraw'] != null
          ? double.parse(map['totalWithdraw'].toString())
          : 0.0,
      totalPendingWithdraw: map['totalPendingWithdraw'] != null
          ? double.parse(map['totalPendingWithdraw'].toString())
          : 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory DashboardModel.fromJson(String source) =>
      DashboardModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      todayTotalOrder,
      todayOrders,
      todayEarning,
      todayPendingEarning,
      todayProductSale,
      monthlyTotalOrder,
      thisMonthEarning,
      thisMonthProductSale,
      yearlyTotalOrder,
      thisYearEarning,
      thisYearProductSale,
      //totalOrder,
      totalPendingOrder,
      totalDeclinedOrder,
      totalCompleteOrder,
      totalEarning,
      totalProductSale,
      totalProduct,
      reviews,
      reports,
      seller!,
      totalWithdraw,
      totalPendingWithdraw,
    ];
  }
}
