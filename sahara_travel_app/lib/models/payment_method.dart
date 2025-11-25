import 'package:flutter/material.dart';

/// Represents a payment method option for checkout.
class PaymentMethod {
  const PaymentMethod({
    required this.name,
    required this.description,
    required this.icon,
  });

  final String name;
  final String description;
  final IconData icon;
}
