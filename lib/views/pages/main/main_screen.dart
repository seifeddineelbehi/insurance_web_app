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
import '../dashboard/dashboard_screen.dart';
import '../login/login_screen.dart';
import 'components/side_menu.dart';
import 'package:confirm_dialog/confirm_dialog.dart';

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
  final List<Widget> _interfaces = [
    const DashboardScreen(),
    const ClientDashboard(),
    const AdminsDashboard()
  ];

  int _currentIndex = 0;
  @override
  void initState() {
    _prefService.readRole().then((value) {
      print("Main screen cache role : " + value.toString());
      if (value != null) {
        setState(() {
          role = value.toString();
        });
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
        drawer: Drawer(
          backgroundColor: Theme.of(context).primaryColor,
          child: ListView(
            children: [
              DrawerHeader(
                child: Image.asset("assets/images/logo.png"),
              ),
              DrawerListTile(
                title: "Dashboard",
                svgSrc: "assets/icons/menu_dashbord.svg",
                press: () => {
                  setState(() {
                    _currentIndex = 0;
                  })
                },
              ),
              DrawerListTile(
                title: "Constat traité",
                svgSrc: "assets/icons/menu_tran.svg",
                press: () => {
                  setState(() {
                    _currentIndex = 0;
                  })
                },
              ),
              DrawerListTile(
                title: "Clients",
                svgSrc: "assets/icons/menu_task.svg",
                press: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
              ),
              DrawerListTile(
                title: "Documents",
                svgSrc: "assets/icons/menu_doc.svg",
                press: () {},
              ),
              DrawerListTile(
                title: "Store",
                svgSrc: "assets/icons/menu_store.svg",
                press: () {},
              ),
              DrawerListTile(
                title: "Notification",
                svgSrc: "assets/icons/menu_notification.svg",
                press: () {},
              ),
              if (role.toLowerCase() == "Super Admin".toLowerCase())
                DrawerListTile(
                  title: "Administrateurs",
                  svgSrc: "assets/icons/menu_profile.svg",
                  press: () {
                    setState(() {
                      _currentIndex = 2;
                    });
                  },
                ),
              DrawerListTile(
                title: "Settings",
                svgSrc: "assets/icons/menu_setting.svg",
                press: () {},
              ),
              DrawerListTile(
                title: "Log out",
                svgSrc: "assets/icons/menu_setting.svg",
                press: () async {
                  if (await confirm(context)) {
                    _prefService.removeCache("token");
                    _prefService.removeRole("role");
                    context.read<LoginViewModel>().setLoggedIn(false);
                    context.beamToNamed(LoginPage.path);
                  }
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We want this side menu only for large screen
              if (Responsive.isDesktop(context))
                Expanded(
                  // default flex = 1
                  // and it takes 1/6 part of the screen
                  child: Drawer(
                    child: ListView(
                      children: [
                        DrawerHeader(
                          child: Image.asset("assets/images/logo.png"),
                        ),
                        DrawerListTile(
                          title: "Dashboard",
                          svgSrc: "assets/icons/menu_dashbord.svg",
                          press: () => {
                            setState(() {
                              _currentIndex = 0;
                            })
                          },
                        ),
                        DrawerListTile(
                          title: "Constat traité",
                          svgSrc: "assets/icons/menu_tran.svg",
                          press: () => {
                            setState(() {
                              _currentIndex = 0;
                            })
                          },
                        ),
                        DrawerListTile(
                          title: "Clients",
                          svgSrc: "assets/icons/menu_task.svg",
                          press: () {
                            setState(() {
                              _currentIndex = 1;
                            });
                          },
                        ),
                        DrawerListTile(
                          title: "Documents",
                          svgSrc: "assets/icons/menu_doc.svg",
                          press: () {},
                        ),
                        DrawerListTile(
                          title: "Store",
                          svgSrc: "assets/icons/menu_store.svg",
                          press: () {},
                        ),
                        DrawerListTile(
                          title: "Notification",
                          svgSrc: "assets/icons/menu_notification.svg",
                          press: () {},
                        ),
                        if (role.toLowerCase() == "Super Admin".toLowerCase())
                          DrawerListTile(
                            title: "Administrateurs",
                            svgSrc: "assets/icons/menu_profile.svg",
                            press: () {
                              setState(() {
                                _currentIndex = 2;
                              });
                            },
                          ),
                        DrawerListTile(
                          title: "Settings",
                          svgSrc: "assets/icons/menu_setting.svg",
                          press: () {},
                        ),
                        DrawerListTile(
                          title: "Log out",
                          svgSrc: "assets/icons/menu_setting.svg",
                          press: () async {
                            if (await confirm(context)) {
                              _prefService.removeCache("token");
                              _prefService.removeRole("role");
                              context.read<LoginViewModel>().setLoggedIn(false);
                              context.beamToNamed(LoginPage.path);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: _interfaces[_currentIndex],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
