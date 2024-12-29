// "is_featured": "1",
// "new_product": "0",
// "is_top": "0",
// "is_best": "1",
// "status": "1",

import 'package:flutter/material.dart';

import 'constants.dart';

class AllStatusCode {
  static String isStatus(String code) {
    switch (code) {
      case '0':
        return '';
      case '1':
        return 'Active';
      default:
        return 'No text';
    }
  }

  static String isFeature(String code) {
    switch (code) {
      case '0':
        return '';
      case '1':
        return 'Feature';
      default:
        return 'No text';
    }
  }

  static String isTop(String code) {
    switch (code) {
      case '0':
        return '';
      case '1':
        return 'Top';
      default:
        return 'No text';
    }
  }

  static String isBest(String code) {
    switch (code) {
      case '0':
        return '';
      case '1':
        return 'Best';
      default:
        return 'No text';
    }
  }

  static String isNew(String code) {
    switch (code) {
      case '0':
        return '';
      case '1':
        return 'New';
      default:
        return 'No text';
    }
  }

  static String getOrderStatus(int code) {
    switch (code + 1) {
      case 1:
        return 'Progress';
      case 2:
        return 'Delivered';
      case 3:
        return 'Completed';
      case 4:
        return 'Declined';
      default:
        return 'Pending';
    }
  }

  static String getPaymentStatus(int code) {
    switch (code + 1) {
      case 1:
        return 'Success';
      default:
        return 'Pending';
    }
  }

  static String getCategoryText(int code) {
    switch (code) {
      case 1:
        return "Electronics";
      case 2:
        return "Game";
      case 3:
        return "Mobile";
      case 4:
        return "Life Style";
      case 5:
        return "Babies & Toys";
      case 6:
        return "Bike";
      case 7:
        return "Men's Fasion";
      case 8:
        return "Woman Fasion";
      case 9:
        return "Talevision";
      case 10:
        return "Accessories";
      case 11:
        return "John Doe";
      default:
        return "No Category Found";
    }
  }

  static Color getTextColor(String code) {
    switch (code) {
      case '0':
        return redColor;
      case '1':
        return greenColor;
      default:
        return Colors.transparent;
    }
  }

  static Color getBackgroundColor(String code) {
    switch (code) {
      case '0':
        return const Color(0xFFFAD6D7);
      case '1':
        return const Color.fromRGBO(39, 174, 96, 0.16);
      default:
        return Colors.transparent;
    }
  }
}
