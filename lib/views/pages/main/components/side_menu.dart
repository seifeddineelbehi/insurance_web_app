import 'package:beamer/beamer.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/views/pages/main/components/side_menu_item_widget.dart';
import 'package:provider/provider.dart';

import '../../../../Services/shared_preferences_service.dart';
import '../../../../utils/constants.dart';
import '../../../../viewModel/login_view_model.dart';
import '../../Administrateurs/AdminScreenDetails.dart';
import '../../Clients/clients_screen.dart';
import '../../login/login_screen.dart';
import '../main_screen.dart';

class SideMenu extends StatefulWidget {
  const SideMenu( this.role, {Key? key}) : super(key: key);
  final String role;
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final PrefService _prefService = PrefService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logoGat.png"),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () => {Beamer.of(context).beamToNamed(MainScreen.path)},
          ),
          DrawerListTile(
            title: "Constat traité",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () => Beamer.of(context).beamToNamed(MainScreen.path),
          ),
          DrawerListTile(
            title: "Clients",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              Beamer.of(context).beamToNamed(ClientDashboard.path);
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
          if (widget.role.toLowerCase() == "Super Admin".toLowerCase())
            DrawerListTile(
              title: "Administrateurs",
              svgSrc: "assets/icons/menu_profile.svg",
              press: () {
                Beamer.of(context).beamToNamed(AdminsDashboard.path);
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
                context.beamToReplacementNamed(LoginPage.path);
              }
            },
          ),
        ],
      ),
    );
  }
}
