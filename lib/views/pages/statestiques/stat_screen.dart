import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/views/pages/statestiques/components/brise_stat_widget.dart';
import 'package:flutter_template/views/pages/statestiques/components/incendies_stat_widget.dart';
import 'package:flutter_template/views/pages/statestiques/components/vol_stat_widget.dart';
import 'package:provider/provider.dart';

import '../../../Services/shared_preferences_service.dart';
import '../../../controllers/MenuController.dart';
import '../../../utils/constants.dart';
import '../../../utils/responsive.dart';
import '../dashboard/components/header.dart';
import 'components/constat_stat_widget.dart';
import '../login/login_screen.dart';
import '../main/components/side_menu.dart';

class StatScreen extends StatefulWidget {
  static const String id = 'statestique';
  static const path = '/stat';
  static const title = 'statestique';
  const StatScreen({Key? key}) : super(key: key);

  @override
  _StatScreenState createState() => _StatScreenState();
}

class _StatScreenState extends State<StatScreen> {
  final PrefService _prefService = PrefService();
  String role = "";

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
      title: StatScreen.title,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        key: context.read<MenuController>().scaffoldKey,
        drawer: SideMenu(role, "Statistique"),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We want this side menu only for large screen
              if (Responsive.isDesktop(context))
                Expanded(
                  // default flex = 1
                  // and it takes 1/6 part of the screen
                  child: SideMenu(role, "Statistique"),
                ),
              Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      children: [
                        const Header(headerTitle: "Statestique"),
                        const SizedBox(height: defaultPadding),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  //const MyFiles(),
                                  const ConstatsStat(),
                                  if (Responsive.isMobile(context)) const SizedBox(height: defaultPadding),
                                  if (Responsive.isMobile(context)) const VolsStat(),
                                ],
                              ),
                            ),
                            if (!Responsive.isMobile(context)) const SizedBox(width: defaultPadding * 2),
                            // On Mobile means if the screen is less than 850 we dont want to show it
                            if (!Responsive.isMobile(context))
                              const Expanded(
                                child: VolsStat(),
                              ),
                          ],
                        ),
                        const SizedBox(height: defaultPadding),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  const IncendiesStat(),
                                  if (Responsive.isMobile(context)) const SizedBox(height: defaultPadding),
                                  if (Responsive.isMobile(context)) const BriseStat(),
                                ],
                              ),
                            ),
                            if (!Responsive.isMobile(context)) const SizedBox(width: defaultPadding * 2),
                            // On Mobile means if the screen is less than 850 we dont want to show it
                            if (!Responsive.isMobile(context))
                              const Expanded(
                                child: BriseStat(),
                              ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
