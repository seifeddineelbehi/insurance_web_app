import 'dart:developer';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/utils/beam_locations.dart';
import 'package:flutter_template/viewModel/home_test_view_model.dart';
import 'package:flutter_template/viewModel/home_view_model.dart';
import 'package:flutter_template/views/pages/Administrateurs/AdminScreenDetails.dart';
import 'package:flutter_template/views/pages/Clients/clients_screen.dart';
import 'package:provider/provider.dart';

import '../../../Services/shared_preferences_service.dart';
import '../../../controllers/MenuController.dart';
import '../../../utils/constants.dart';
import '../../../utils/responsive.dart';
import '../../../viewModel/home_view_model.dart';
import '../../../viewModel/login_view_model.dart';
import '../dashboard/constat_non_traite_screen.dart';
import '../login/login_screen.dart';
import 'components/side_menu.dart';
import 'package:confirm_dialog/confirm_dialog.dart';

import 'components/side_menu_item_widget.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'main_screen';
  static const path = '/home';
  static const title = 'Dashboard';

  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PrefService _prefService = PrefService();
  String role = "";

  int _currentIndex = 0;
  @override
  void initState() {
    _prefService.readRole().then((value) {
      print("Main screen cache role : " + value.toString());
      if (value != null) {
        setState(() {
          role = value.toString();
        });
      } else {
        Beamer.of(context).beamToReplacementNamed(LoginPage.path);
      }
    });
    /*log("feafeafeafea---------" +
        context.read<HomeViewModel>().role.toString());
    role = context.read<HomeViewModel>().role!.toString();
    setState(() {
      log("feafeafeafea" + context.read<HomeViewModel>().role!.toString());
      role = context.read<HomeViewModel>().role!.toString();
    });*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      color: Colors.blue,
      title: MainScreen.title,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        key: context.read<MenuController>().scaffoldKey,
        drawer: SideMenu(role, "Sinistre_recent_materiel"),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We want this side menu only for large screen
              if (Responsive.isDesktop(context) || Responsive.isTablet(context))
                Expanded(
                  // default flex = 1
                  // and it takes 1/6 part of the screen
                  child: SideMenu(role, "Sinistre_recent_materiel"),
                ),
              const Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: ConstatNonTraiteScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
