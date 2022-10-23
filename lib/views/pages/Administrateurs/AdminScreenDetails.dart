import 'package:beamer/beamer.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/views/pages/Administrateurs/components/AdminTable.dart';
import 'package:flutter_template/views/pages/Clients/clients_screen.dart';
import 'package:flutter_template/views/pages/main/main_screen.dart';
import 'package:provider/provider.dart';

import '../../../Services/shared_preferences_service.dart';
import '../../../controllers/MenuController.dart';
import '../../../utils/constants.dart';
import '../../../utils/responsive.dart';
import '../../../viewModel/login_view_model.dart';
import '../login/login_screen.dart';
import '../main/components/side_menu.dart';
import 'add_admin_screen.dart';

class AdminsDashboard extends StatefulWidget {
  static const String id = 'admins_screen';
  static const path = '/Admins';
  static const title = 'Liste des Administrateurs';

  const AdminsDashboard({Key? key}) : super(key: key);

  @override
  _AdminsDashboardState createState() => _AdminsDashboardState();
}

class _AdminsDashboardState extends State<AdminsDashboard> {
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
      title: AdminsDashboard.title,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        key: context.read<MenuController>().scaffoldKey,
        drawer: SideMenu(role, "Administrateur"),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We want this side menu only for large screen
              if (Responsive.isDesktop(context))
                Expanded(
                  // default flex = 1
                  // and it takes 1/6 part of the screen
                  child: SideMenu(role, "Administrateur"),
                ),
              const Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: AdminScreenBody(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdminScreenBody extends StatelessWidget {
  const AdminScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (!Responsive.isDesktop(context))
                            IconButton(
                              icon: const Icon(Icons.menu),
                              onPressed: context.read<MenuController>().controlMenu,
                            ),
                          Text(
                            "Liste des Administrateurs",
                            style: kBigTitleBlackBold,
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepPurple,
                              onPrimary: Colors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: defaultPadding * 1.5,
                                vertical: defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                              ),
                            ),
                            onPressed: () {
                              context.beamToNamed(AddAdmin.path);
                            },
                            icon: const Icon(Icons.add),
                            label: const Text("Add New"),
                          ),
                        ],
                      ),
                      const SizedBox(height: defaultPadding),
                      const AdminsTable(),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
