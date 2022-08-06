import 'dart:async';
import 'dart:developer';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/views/pages/home_test_view.dart';
import 'package:flutter_template/views/pages/login/login_screen.dart';
import 'package:flutter_template/views/pages/main/main_screen.dart';
import 'package:provider/provider.dart';

import '../../Services/shared_preferences_service.dart';
import '../../utils/palette.dart';
import '../../utils/size_config.dart';
import '../../viewModel/home_view_model.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen_view';
  static const path = '/';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PrefService _prefService = PrefService();

  @override
  void initState() {
    _prefService.readCache("token").then((value) async {
      print("splash screen cache token : " + value.toString());
      if (value != null) {
        log("valuuuuuuue : " + value);
        _prefService.readRole().then((value) {
          print("Main screen cache role : " + value.toString());
          if (value != null) {
            context.read<HomeViewModel>().setrole(value.toString());
          }
        });
        //context.read<HomeViewModel>().getAllConstatNonTraite();
        return context.beamToNamed(MainScreen.path);
      } else {
        return context.beamToNamed(LoginPage.path);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Title(
      title: "Assurance Dashbord",
      color: Colors.blue,
      child: Scaffold(
        backgroundColor: Palette.SplashScreenMainColor,
        body: Center(
          child: Image.asset(
            'images/logoGat.png',
            width: SizeConfig.screenWidth / 2,
            height: SizeConfig.screenHeight / 2,
          ),
        ),
      ),
    );
  }
}
