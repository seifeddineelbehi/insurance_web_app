import 'package:beamer/beamer.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/views/pages/BriseGlace/brise_glace_screen.dart';
import 'package:flutter_template/views/pages/Incendies/incendie_screen.dart';
import 'package:flutter_template/views/pages/Vols/vols_screen.dart';
import 'package:flutter_template/views/pages/archive/BriseTraite/brise_rejete.dart';
import 'package:flutter_template/views/pages/archive/BriseTraite/brise_traite.dart';
import 'package:flutter_template/views/pages/archive/ConstatRejeter/constat_rejete_screen.dart';
import 'package:flutter_template/views/pages/archive/ConstatTraite/constat_traite_screen.dart';
import 'package:flutter_template/views/pages/archive/Incendies/incendies_rejete.dart';
import 'package:flutter_template/views/pages/archive/Incendies/incendies_traite.dart';
import 'package:flutter_template/views/pages/archive/VolTraite/vols_rejete.dart';
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
          ExpansionTile(
            leading:
                const Icon(Icons.history, color: Colors.blueGrey, size: 16),
            title: const Text(
              'Récent',
              style: TextStyle(color: secondaryColor),
            ),
            children: [
              DrawerListTile(
                title: "Constat non traité",
                icon: Icons.apps,
                press: () => {Beamer.of(context).beamToNamed(MainScreen.path)},
              ),
              DrawerListTile(
                title: "Vols non traité",
                icon: Icons.apps,
                press: () =>
                    Beamer.of(context).beamToNamed(VolNonTraiteScreen.path),
              ),
              DrawerListTile(
                title: "Incendies non traité",
                icon: Icons.apps,
                press: () {
                  Beamer.of(context).beamToNamed(IncendiesNonTraiteScreen.path);
                },
              ),
              DrawerListTile(
                title: "Brises glaces non traité",
                icon: Icons.apps,
                press: () => Beamer.of(context)
                    .beamToNamed(BriseGlaceNonTraiteScreen.path),
              ),
            ],
          ),
          DrawerListTile(
            title: "Clients",
            icon: Icons.person,
            press: () {
              Beamer.of(context).beamToNamed(ClientDashboard.path);
            },
          ),
          ExpansionTile(
            leading: const Icon(Icons.event, color: Colors.blueGrey, size: 16),
            title: const Text(
              'Archive Traité',
              style: TextStyle(color: secondaryColor),
            ),
            children: [
              DrawerListTile(
                title: "Archive Constat Traité",
                icon: Icons.access_time,
                press: () {
                  Beamer.of(context).beamToNamed(ConstatTraite.path);
                },
              ),
              DrawerListTile(
                title: "Archive Vols Traité",
                icon: Icons.access_time,
                press: () {
                  Beamer.of(context).beamToNamed(VolTraite.path);
                },
              ),
              DrawerListTile(
                title: "Archive Incendies Traité",
                icon: Icons.access_time,
                press: () {
                  Beamer.of(context).beamToNamed(IncendiesTraite.path);
                },
              ),
              DrawerListTile(
                title: "Archive Brise glace Traité",
                icon: Icons.access_time,
                press: () {
                  Beamer.of(context).beamToNamed(BriseTraite.path);
                },
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.event, color: Colors.blueGrey, size: 16),
            title: const Text(
              'Archive Rejeté',
              style: TextStyle(color: secondaryColor),
            ),
            children: [
              DrawerListTile(
                title: "Archive Constat Rejeté",
                icon: Icons.access_time,
                press: () {
                  Beamer.of(context).beamToNamed(ConstatRejete.path);
                },
              ),
              DrawerListTile(
                title: "Archive Vols Rejeté",
                icon: Icons.access_time,
                press: () {
                  Beamer.of(context).beamToNamed(VolRejete.path);
                },
              ),
              DrawerListTile(
                title: "Archive Incendies Rejeté",
                icon: Icons.access_time,
                press: () {
                  Beamer.of(context).beamToNamed(IncendiesRejete.path);
                },
              ),
              DrawerListTile(
                title: "Archive Brise glace Rejeté",
                icon: Icons.access_time,
                press: () {
                  Beamer.of(context).beamToNamed(BriseRejete.path);
                },
              ),
            ],
          ),
          if (widget.role.toLowerCase() == "Super Admin".toLowerCase())
            DrawerListTile(
              title: "Administrateurs",
              icon: Icons.admin_panel_settings,
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
            icon: Icons.logout,
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
