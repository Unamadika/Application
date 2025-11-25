import 'dart:async';

import 'package:intl/intl.dart';

import '../data/dummy_content.dart';
import '../models/payment_method.dart';

class PaymentService {
  Future<Map<String, double>> fetchCostBreakdown() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return {
      'Experiences': 320,
      'Logistics & transport': 58,
      'Sustainability fund': 14,
      'Discount': -25,
    };
  }

  Future<List<PaymentMethod>> fetchMethods() async {
    await Future.delayed(const Duration(milliseconds: 450));
    return DummyContent.paymentMethods;
  }

  String formatCurrency(double value) =>
      NumberFormat.currency(symbol: 'MAD ').format(value);
}
