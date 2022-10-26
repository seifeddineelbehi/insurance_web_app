import 'dart:developer';

import 'package:beamer/beamer.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/utils/palette.dart';
import 'package:flutter_template/utils/responsive.dart';
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
import 'package:google_fonts/google_fonts.dart';
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
  const SideMenu(
    this.role,
    this.pageActive, {
    Key? key,
  }) : super(key: key);
  final String role;
  final String pageActive;
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final PrefService _prefService = PrefService();

  @override
  void initState() {
    // TODO: implement initState
    print("bbbbbbbbbbbbbbbbbbbb");
    super.initState();
    initPusher();
    if (widget.pageActive == "Sinistre_recent_materiel" ||
        widget.pageActive == "Sinistre_recent_vol" ||
        widget.pageActive == "Sinistre_recent_incendie" ||
        widget.pageActive == "Sinistre_recent_brise_glass") {
      setState(() {
        selectedTile = 1;
      });
    } else if (widget.pageActive == "Sinistre_traite_materiel" ||
        widget.pageActive == "Sinistre_traite_vol" ||
        widget.pageActive == "Sinistre_traite_incendie" ||
        widget.pageActive == "Sinistre_traite_brise_glass") {
      setState(() {
        selectedTile = 2;
      });
    } else if (widget.pageActive == "Sinistre_rejeter_materiel" ||
        widget.pageActive == "Sinistre_rejeter_vol" ||
        widget.pageActive == "Sinistre_rejeter_incendie" ||
        widget.pageActive == "Sinistre_rejeter_brise_glass") {
      setState(() {
        selectedTile = 3;
      });
    } else {
      setState(() {
        selectedTile = -1;
      });
    }
  }

  late int selectedTile;
  int recentTile = 1;
  int traiteTile = 2;
  int rejeterTile = 3;
  @override
  Widget build(BuildContext context) {
    var kSideMenuText = Responsive.isDesktop(context)
        ? GoogleFonts.poppins(
            color: secondaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
          )
        : Responsive.isTablet(context)
            ? GoogleFonts.poppins(
                color: secondaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 15.0,
              )
            : GoogleFonts.poppins(
                color: secondaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
              );
    return Drawer(
      child: ListView(
        controller: ScrollController(),
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logoGat.png"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Palette.drawerItemSelectedColor,
                ), // here for open state in replacement of deprecated accentColor
                dividerColor:
                    Colors.transparent, // if you want to remove the border
              ),
              child: ExpansionTile(
                onExpansionChanged: (expanded) {
                  if (expanded) {
                    setState(() {
                      selectedTile = 1;
                      recentTile = 1;
                      traiteTile = 10;
                      rejeterTile = 11;
                    });
                  } else {
                    setState(() {
                      selectedTile = -1;
                      recentTile = 1;
                    });
                  }
                },
                key: Key(recentTile.toString()),
                initiallyExpanded: recentTile == selectedTile,
                leading:
                    const Icon(Icons.history, color: Colors.blueGrey, size: 20),
                title: Transform.translate(
                  offset: const Offset(-16, 0),
                  child: Text(
                    'Sinistre récent',
                    style: kSideMenuText,
                  ),
                ),
                children: [
                  DrawerListTile(
                    active: widget.pageActive == "Sinistre_recent_materiel"
                        ? true
                        : false,
                    title: "Matériels",
                    icon: Icons.apps,
                    press: () {
                      Beamer.of(context).beamToNamed(MainScreen.path);
                      setState(() {
                        selectedTile = 1;
                      });
                    },
                  ),
                  DrawerListTile(
                    active: widget.pageActive == "Sinistre_recent_vol"
                        ? true
                        : false,
                    title: "Vols ",
                    icon: Icons.apps,
                    press: () {
                      Beamer.of(context).beamToNamed(VolNonTraiteScreen.path);
                      setState(() {
                        selectedTile = 1;
                      });
                    },
                  ),
                  DrawerListTile(
                    active: widget.pageActive == "Sinistre_recent_incendie"
                        ? true
                        : false,
                    title: "Incendies ",
                    icon: Icons.apps,
                    press: () {
                      Beamer.of(context)
                          .beamToNamed(IncendiesNonTraiteScreen.path);
                      setState(() {
                        selectedTile = 1;
                      });
                    },
                  ),
                  DrawerListTile(
                    active: widget.pageActive == "Sinistre_recent_brise_glass"
                        ? true
                        : false,
                    title: "Bris de glaces ",
                    icon: Icons.apps,
                    press: () {
                      Beamer.of(context)
                          .beamToNamed(BriseGlaceNonTraiteScreen.path);
                      setState(() {
                        selectedTile = 1;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Palette.drawerItemSelectedColor,
                ), // here for open state in replacement of deprecated accentColor
                dividerColor:
                    Colors.transparent, // if you want to remove the border
              ),
              child: ExpansionTile(
                onExpansionChanged: (expanded) {
                  if (expanded) {
                    setState(() {
                      selectedTile = 2;
                      traiteTile = 2;
                      recentTile = 20;
                      rejeterTile = 21;
                    });
                  } else {
                    setState(() {
                      selectedTile = -1;
                      traiteTile = 2;
                    });
                  }
                },
                key: Key(traiteTile.toString()),
                initiallyExpanded: traiteTile == selectedTile,
                leading:
                    const Icon(Icons.event, color: Colors.blueGrey, size: 20),
                title: Transform.translate(
                  offset: const Offset(-16, 0),
                  child: Text(
                    'Sinistre traité',
                    style: kSideMenuText,
                  ),
                ),
                children: [
                  DrawerListTile(
                    active: widget.pageActive == "Sinistre_traite_materiel"
                        ? true
                        : false,
                    title: "Matériels",
                    icon: Icons.access_time,
                    press: () {
                      Beamer.of(context).beamToNamed(ConstatTraite.path);
                      setState(() {
                        selectedTile = 2;
                      });
                    },
                  ),
                  DrawerListTile(
                    active: widget.pageActive == "Sinistre_traite_vol"
                        ? true
                        : false,
                    title: " Vols ",
                    icon: Icons.access_time,
                    press: () {
                      Beamer.of(context).beamToNamed(VolTraite.path);
                      setState(() {
                        selectedTile = 2;
                      });
                    },
                  ),
                  DrawerListTile(
                    active: widget.pageActive == "Sinistre_traite_incendie"
                        ? true
                        : false,
                    title: " Incendies ",
                    icon: Icons.access_time,
                    press: () {
                      Beamer.of(context).beamToNamed(IncendiesTraite.path);
                      setState(() {
                        selectedTile = 2;
                      });
                    },
                  ),
                  DrawerListTile(
                    active: widget.pageActive == "Sinistre_traite_brisse_glace"
                        ? true
                        : false,
                    title: " Bris de glace ",
                    icon: Icons.access_time,
                    press: () {
                      Beamer.of(context).beamToNamed(BriseTraite.path);
                      setState(() {
                        selectedTile = 2;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Palette.drawerItemSelectedColor,
                ), // here for open state in replacement of deprecated accentColor
                dividerColor:
                    Colors.transparent, // if you want to remove the border
              ),
              child: ExpansionTile(
                onExpansionChanged: (expanded) {
                  if (expanded) {
                    setState(() {
                      selectedTile = 3;
                      rejeterTile = 3;
                      recentTile = 13;
                      traiteTile = 14;
                    });
                  } else {
                    setState(() {
                      selectedTile = -1;
                      rejeterTile = 3;
                    });
                  }
                },
                key: Key(rejeterTile.toString()),
                initiallyExpanded: rejeterTile == selectedTile,
                leading:
                    const Icon(Icons.event, color: Colors.blueGrey, size: 20),
                title: Transform.translate(
                  offset: const Offset(-16, 0),
                  child: Text(
                    'Sinistre rejeté',
                    style: kSideMenuText,
                  ),
                ),
                children: [
                  DrawerListTile(
                    title: " Matériels ",
                    active: widget.pageActive == "Sinistre_rejeter_materiel"
                        ? true
                        : false,
                    icon: Icons.access_time,
                    press: () {
                      Beamer.of(context).beamToNamed(ConstatRejete.path);
                      setState(() {
                        selectedTile = 3;
                      });
                    },
                  ),
                  DrawerListTile(
                    active: widget.pageActive == "Sinistre_rejeter_vol"
                        ? true
                        : false,
                    title: " Vols ",
                    icon: Icons.access_time,
                    press: () {
                      Beamer.of(context).beamToNamed(VolRejete.path);
                      setState(() {
                        selectedTile = 3;
                      });
                    },
                  ),
                  DrawerListTile(
                    active: widget.pageActive == "Sinistre_rejeter_incendie"
                        ? true
                        : false,
                    title: " Incendies ",
                    icon: Icons.access_time,
                    press: () {
                      Beamer.of(context).beamToNamed(IncendiesRejete.path);
                      setState(() {
                        selectedTile = 3;
                      });
                    },
                  ),
                  DrawerListTile(
                    active: widget.pageActive == "Sinistre_rejeter_brisse_glass"
                        ? true
                        : false,
                    title: " Bris de glace ",
                    icon: Icons.access_time,
                    press: () {
                      Beamer.of(context).beamToNamed(BriseRejete.path);
                      setState(() {
                        selectedTile = 3;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          DrawerListTile(
            active: widget.pageActive == "Clients" ? true : false,
            title: "Clients",
            icon: Icons.person,
            press: () {
              Beamer.of(context).beamToNamed(ClientDashboard.path);
              setState(() {
                selectedTile = -1;
                rejeterTile = 100;
                recentTile = 200;
                traiteTile = 300;
              });
            },
          ),
          if (widget.role.toLowerCase() == "Super Admin".toLowerCase())
            DrawerListTile(
              active: widget.pageActive == "Administrateur" ? true : false,
              title: "Administrateurs",
              icon: Icons.admin_panel_settings,
              press: () {
                Beamer.of(context).beamToNamed(AdminsDashboard.path);
                setState(() {
                  selectedTile = -1;
                  rejeterTile = 101;
                  recentTile = 202;
                  traiteTile = 303;
                });
              },
            ),
          DrawerListTile(
            active: widget.pageActive == "Statistique" ? true : false,
            title: "Statistique",
            icon: Icons.bar_chart,
            press: () {
              Beamer.of(context).beamToNamed(StatScreen.path);
              setState(() {
                selectedTile = -1;
                rejeterTile = 102;
                recentTile = 203;
                traiteTile = 304;
              });
            },
          ),
          const Divider(),
          ListTile(
            onTap: () async {
              if (await confirm(
                context,
                title: Text(
                  'Se déconnecter',
                  style: GoogleFonts.poppins(
                    color: secondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                content: Text(
                  'Vous êtes sur de se déconnecter?',
                  style: GoogleFonts.poppins(
                    color: secondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                textOK: Text(
                  'Oui',
                  style: GoogleFonts.poppins(
                    color: Palette.drawerItemSelectedColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                textCancel: Text(
                  'Annuler',
                  style: GoogleFonts.poppins(
                    color: Palette.drawerItemSelectedColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )) {
                _prefService.removeToken();
                _prefService.removeRole();
                _prefService.removeUsername();
                context.read<LoginViewModel>().setLoggedIn(false);
                context.beamToReplacementNamed(LoginPage.path);
              }
            },
            selected: true,
            horizontalTitleGap: 0.0,
            leading: Container(
              decoration: const BoxDecoration(
                color: Palette.drawerItemSelectedColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.power_settings_new,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "Se déconnecter",
                style: GoogleFonts.poppins(
                  color: secondaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
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
