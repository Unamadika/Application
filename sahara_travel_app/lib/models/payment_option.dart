import 'package:flutter/material.dart';

/// Represents a payment method entry for the checkout screen.
class PaymentOption {
  const PaymentOption({
    required this.name,
    required this.subtitle,
    required this.icon,
    this.isRecommended = false,
  });

  final String name;
  final String subtitle;
  final IconData icon;
  final bool isRecommended;
}
