import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/views/pages/main/main_screen.dart';

import '../views/pages/login/login_screen.dart';

class Locations extends BeamLocation<BeamState> {
  Locations(RouteInformation routeInformation) : super(routeInformation);
  @override
  List<BeamPage> buildPages(
      BuildContext context, RouteInformationSerializable state) {
    final pages = [
      const BeamPage(
        key: ValueKey('login'),
        title: 'Login',
        child: LoginPage(),
      ),
      const BeamPage(
        key: ValueKey('home'),
        title: 'Home',
        child: MainScreen(),
      ),
    ];
    return pages;
  }

  @override
  List<Pattern> get pathPatterns => ['/*'];
}

class LoginLocations extends BeamLocation<BeamState> {
  LoginLocations(BeamState beamState) : super();
  @override
  List<BeamPage> buildPages(
      BuildContext context, RouteInformationSerializable state) {
    final pages = [
      const BeamPage(
        key: ValueKey('login'),
        title: 'Login',
        child: LoginPage(),
      ),
    ];
    return pages;
  }

  @override
  // TODO: implement pathPatterns
  List<Pattern> get pathPatterns => ['/login'];
}
