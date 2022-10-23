import 'package:beamer/beamer.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/views/pages/Clients/add_client.dart';
import 'package:flutter_template/views/pages/Clients/components/ClientTable.dart';
import 'package:flutter_template/views/pages/dashboard/components/header.dart';
import 'package:provider/provider.dart';

import '../../../Services/shared_preferences_service.dart';
import '../../../controllers/MenuController.dart';
import '../../../utils/constants.dart';
import '../../../utils/responsive.dart';
import '../../../viewModel/login_view_model.dart';
import '../Administrateurs/AdminScreenDetails.dart';
import '../login/login_screen.dart';
import '../main/components/side_menu.dart';
import '../main/components/side_menu_item_widget.dart';
import '../main/main_screen.dart';

class ClientDashboard extends StatefulWidget {
  static const String id = 'clients_screen';
  static const path = '/Clients';
  static const title = 'Liste des clients';

  const ClientDashboard({Key? key}) : super(key: key);

  @override
  _ClientDashboardState createState() => _ClientDashboardState();
}

class _ClientDashboardState extends State<ClientDashboard> {
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
      title: ClientDashboard.title,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        key: context.read<MenuController>().scaffoldKey,
        drawer: SideMenu(role, "Clients"),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We want this side menu only for large screen
              if (Responsive.isDesktop(context))
                Expanded(
                  // default flex = 1
                  // and it takes 1/6 part of the screen
                  child: SideMenu(role, "Clients"),
                ),
              const Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: ClientsScreenBody(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ClientsScreenBody extends StatelessWidget {
  const ClientsScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: defaultPadding),
            Header(headerTitle: "Liste des Clients"),
            SizedBox(height: defaultPadding),
            ClientsTable(),
          ],
        ),
      ),
    );
  }
}
