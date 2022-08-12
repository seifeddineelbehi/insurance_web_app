import 'package:beamer/beamer.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/views/pages/BriseGlace/brise_glace_screen.dart';
import 'package:flutter_template/views/pages/Incendies/incendie_screen.dart';
import 'package:flutter_template/views/pages/Vols/vols_screen.dart';
import 'package:flutter_template/views/pages/archive/BriseTraite/brise_traite.dart';
import 'package:flutter_template/views/pages/archive/ConstatRejeter/constat_rejete_screen.dart';
import 'package:flutter_template/views/pages/archive/ConstatTraite/constat_traite_screen.dart';
import 'package:flutter_template/views/pages/archive/Incendies/incendies_traite.dart';
import 'package:flutter_template/views/pages/main/components/side_menu_item_widget.dart';
import 'package:provider/provider.dart';

import '../../../../Services/shared_preferences_service.dart';
import '../../../../utils/constants.dart';
import '../../../../viewModel/login_view_model.dart';
import '../../Administrateurs/AdminScreenDetails.dart';
import '../../Clients/clients_screen.dart';
import '../../archive/VolTraite/vols_traite.dart';
import '../../login/login_screen.dart';
import '../../statestiques/stat_screen.dart';
import '../main_screen.dart';

class SideMenu extends StatefulWidget {
  const SideMenu(this.role, {Key? key}) : super(key: key);
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
            title: "Constat non traité",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () => {Beamer.of(context).beamToNamed(MainScreen.path)},
          ),
          DrawerListTile(
            title: "Vols non traité",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () =>
                Beamer.of(context).beamToNamed(VolNonTraiteScreen.path),
          ),
          DrawerListTile(
            title: "Incendies non traité",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              Beamer.of(context).beamToNamed(IncendiesNonTraiteScreen.path);
            },
          ),
          DrawerListTile(
            title: "Brises glaces non traité",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () =>
                Beamer.of(context).beamToNamed(BriseGlaceNonTraiteScreen.path),
          ),
          DrawerListTile(
            title: "Clients",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              Beamer.of(context).beamToNamed(ClientDashboard.path);
            },
          ),
          DrawerListTile(
            title: "Archive Constat Traité",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              Beamer.of(context).beamToNamed(ConstatTraite.path);
            },
          ),
          DrawerListTile(
            title: "Archive Vols Traité",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              Beamer.of(context).beamToNamed(VolTraite.path);
            },
          ),
          DrawerListTile(
            title: "Archive Incendies Traité",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              Beamer.of(context).beamToNamed(IncendiesTraite.path);
            },
          ),
          DrawerListTile(
            title: "Archive Brise glace Traité",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              Beamer.of(context).beamToNamed(BriseTraite.path);
            },
          ),
          if (widget.role.toLowerCase() == "Super Admin".toLowerCase())
            DrawerListTile(
              title: "Administrateurs",
              svgSrc: "assets/icons/menu_profile.svg",
              press: () {
                Beamer.of(context).beamToNamed(AdminsDashboard.path);
              },
            ),
          ListTile(
            onTap: () {
              Beamer.of(context).beamToNamed(StatScreen.path);
            },
            selected: true,
            horizontalTitleGap: 0.0,
            leading: const Icon(
              Icons.bar_chart,
              color: Colors.blueGrey,
              size: 16,
            ),
            title: const Text(
              "Statestique",
              style: TextStyle(color: secondaryColor),
            ),
          ),
          DrawerListTile(
            title: "Log out",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () async {
              if (await confirm(context,
                  title: const Text('Se deconnecté'),
                  content: const Text('Vous êtes sur de se deconnecter?'),
                  textOK: const Text('Oui'),
                  textCancel: const Text('Annuler'))) {
                _prefService.removeCache("token");
                _prefService.removeRole("role");
                _prefService.removeUsername("username");
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
