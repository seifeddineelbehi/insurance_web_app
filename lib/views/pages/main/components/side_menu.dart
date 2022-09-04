import 'dart:developer';

import 'package:beamer/beamer.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
    initPusher();
  }

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
              'Sinistre récent',
              style: TextStyle(color: secondaryColor),
            ),
            children: [
              DrawerListTile(
                title: "Matériels",
                icon: Icons.apps,
                press: () => {Beamer.of(context).beamToNamed(MainScreen.path)},
              ),
              DrawerListTile(
                title: "Vols ",
                icon: Icons.apps,
                press: () =>
                    Beamer.of(context).beamToNamed(VolNonTraiteScreen.path),
              ),
              DrawerListTile(
                title: "Incendies ",
                icon: Icons.apps,
                press: () {
                  Beamer.of(context).beamToNamed(IncendiesNonTraiteScreen.path);
                },
              ),
              DrawerListTile(
                title: "Bris de glaces ",
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
              'Sinistre traité',
              style: TextStyle(color: secondaryColor),
            ),
            children: [
              DrawerListTile(
                title: "Matériels",
                icon: Icons.access_time,
                press: () {
                  Beamer.of(context).beamToNamed(ConstatTraite.path);
                },
              ),
              DrawerListTile(
                title: " Vols ",
                icon: Icons.access_time,
                press: () {
                  Beamer.of(context).beamToNamed(VolTraite.path);
                },
              ),
              DrawerListTile(
                title: " Incendies ",
                icon: Icons.access_time,
                press: () {
                  Beamer.of(context).beamToNamed(IncendiesTraite.path);
                },
              ),
              DrawerListTile(
                title: " Bris de glace ",
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
              'Sinistre rejeté',
              style: TextStyle(color: secondaryColor),
            ),
            children: [
              DrawerListTile(
                title: " Matériels ",
                icon: Icons.access_time,
                press: () {
                  Beamer.of(context).beamToNamed(ConstatRejete.path);
                },
              ),
              DrawerListTile(
                title: " Vols ",
                icon: Icons.access_time,
                press: () {
                  Beamer.of(context).beamToNamed(VolRejete.path);
                },
              ),
              DrawerListTile(
                title: " Incendies ",
                icon: Icons.access_time,
                press: () {
                  Beamer.of(context).beamToNamed(IncendiesRejete.path);
                },
              ),
              DrawerListTile(
                title: " Bris de glace ",
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
              "Statistique",
              style: TextStyle(color: secondaryColor),
            ),
          ),
          DrawerListTile(
            title: "Se déconnecter",
            icon: Icons.logout,
            press: () async {
              if (await confirm(context,
                  title: const Text('Se déconnecter'),
                  content: const Text('Vous êtes sur de se déconnecter?'),
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

  void initPusher() async {
    try {
      log('teeeest 0');
      PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
      log('teeeest 1');

      await pusher.init(
          apiKey: 'e5936ef5024909d4f2d3',
          cluster: 'eu',
          onEvent: (event) {
            log("Got channel event: $event");
          });
      log('teeeest');
      await pusher.subscribe(
        channelName: 'assurance',
      );

      await pusher.connect();
    } catch (e) {
      log("ERROR: $e");
    }
  }
}
