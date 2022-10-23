import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? mobileLarge;

  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    this.tablet,
    this.mobileLarge,
    required this.desktop,
  }) : super(key: key);

// This size work fine on my design, maybe you need some customization depends on your design

  //This isMobile, isTablet, isDesktop helep us later
  // static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 850;
  //
  // static bool isTablet(BuildContext context) =>
  //     MediaQuery.of(context).size.width < 1100 && MediaQuery.of(context).size.width >= 850;
  //
  // static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1100;
  //
  // @override
  // Widget build(BuildContext context) {
  //   final Size _size = MediaQuery.of(context).size;
  //   // If our width is more than 1100 then we consider it a desktop
  //   if (_size.width >= 1100) {
  //     return desktop;
  //   }
  //   // If width it less then 1100 and more then 850 we consider it as tablet
  //   else if (_size.width >= 850 && tablet != null) {
  //     return tablet!;
  //   }
  //   // Or less then that we called it mobile
  //   else {
  //     return mobile;
  //   }
  // }

  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width <= 600;

  static bool isMobileLarge(BuildContext context) =>
      MediaQuery.of(context).size.width <= 1300 && MediaQuery.of(context).size.width > 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1500 && MediaQuery.of(context).size.width > 1300;

  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1500;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    if (_size.width >= 1024) {
      return desktop;
    } else if (_size.width >= 700 && tablet != null) {
      return tablet!;
    } else if (_size.width >= 500 && mobileLarge != null) {
      return mobileLarge!;
    } else {
      return mobile;
    }
  }
}
