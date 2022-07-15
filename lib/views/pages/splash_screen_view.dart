import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_template/views/pages/home_test_view.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen_view';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
        () => Navigator.pushNamed(context, MyHomePage.id));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFCC00),
      child: FlutterLogo(
        size: MediaQuery.of(context).size.height,
      ),
    );
  }
}
