import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/views/pages/archive/BriseTraite/components/brise_traite_table.dart';
import 'package:flutter_template/views/pages/archive/Incendies/components/incendies_traite_table.dart';
import 'package:provider/provider.dart';

import '../../../../Services/shared_preferences_service.dart';
import '../../../../controllers/MenuController.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/responsive.dart';
import '../../dashboard/components/header.dart';
import '../../login/login_screen.dart';
import '../../main/components/side_menu.dart';

class IncendiesTraite extends StatefulWidget {
  static const String id = 'IncendiesTraité';
  static const path = '/archive_Incendies_Traite';
  static const title = 'Archive Incendies Traités';
  const IncendiesTraite({Key? key}) : super(key: key);

  @override
  _IncendiesTraiteState createState() => _IncendiesTraiteState();
}

class _IncendiesTraiteState extends State<IncendiesTraite> {
  String role = "";
  final PrefService _prefService = PrefService();

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
  }

  @override
  Widget build(BuildContext context) {
    return Title(
        color: Colors.blue,
        title: IncendiesTraite.title,
        child: Scaffold(
          backgroundColor: kBackgroundColor,
          key: context.read<MenuController>().scaffoldKey,
          drawer: SideMenu(role),
          body: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // We want this side menu only for large screen
                if (Responsive.isDesktop(context))
                  Expanded(
                    // default flex = 1
                    // and it takes 1/6 part of the screen
                    child: SideMenu(role),
                  ),
                Expanded(
                  // It takes 5/6 part of the screen
                  flex: 5,
                  child: SafeArea(
                    child: SingleChildScrollView(
                      primary: false,
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Column(
                        children: [
                          const Header(
                              headerTitle: "Archive Incendies Traités"),
                          const SizedBox(height: defaultPadding),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Expanded(
                                flex: 5,
                                child: IncendiesTraiteTable(),
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
        ));
  }
}
