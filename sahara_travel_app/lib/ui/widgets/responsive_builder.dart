import 'package:flutter/material.dart';

/// Simple builder to adjust layout between mobile and tablet breakpoints.
class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({super.key, required this.mobile, Widget? tablet})
      : tablet = tablet ?? mobile;

  final Widget mobile;
  final Widget tablet;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= 600;

  @override
  Widget build(BuildContext context) {
    return isTablet(context) ? tablet : mobile;
  }
}
