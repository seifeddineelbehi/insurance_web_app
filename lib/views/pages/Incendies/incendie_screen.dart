import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/views/pages/Incendies/components/incendies_table.dart';
import 'package:flutter_template/views/pages/Vols/components/vol_table.dart';
import 'package:provider/provider.dart';

import '../../../Services/shared_preferences_service.dart';
import '../../../controllers/MenuController.dart';
import '../../../utils/constants.dart';
import '../../../utils/responsive.dart';
import '../dashboard/components/header.dart';
import '../login/login_screen.dart';
import '../main/components/side_menu.dart';

class IncendiesNonTraiteScreen extends StatefulWidget {
  static const String id = 'incendies_screen';
  static const path = '/incendies';
  static const title = 'Liste des incendies';

  const IncendiesNonTraiteScreen({Key? key}) : super(key: key);

  @override
  _IncendiesNonTraiteScreenState createState() =>
      _IncendiesNonTraiteScreenState();
}

class _IncendiesNonTraiteScreenState extends State<IncendiesNonTraiteScreen> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Title(
      color: Colors.blue,
      title: IncendiesNonTraiteScreen.title,
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
                        const Header(headerTitle: "Liste des incendies"),
                        const SizedBox(height: defaultPadding),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Expanded(
                              flex: 5,
                              child: IncendieTable(),
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
