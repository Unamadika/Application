import 'package:flutter/material.dart';

/// Simple breakpoint-based builder to adapt padding and layout for tablet sizes.
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobile,
    Widget? tablet,
  }) : tablet = tablet ?? mobile;

  final Widget mobile;
  final Widget tablet;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= 600;

  @override
  Widget build(BuildContext context) {
    return isTablet(context) ? tablet : mobile;
  }
}
