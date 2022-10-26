import 'package:beamer/beamer.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/model/admin_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../Services/shared_preferences_service.dart';
import '../../../../controllers/MenuController.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/palette.dart';
import '../../../../utils/responsive.dart';
import '../../../../viewModel/login_view_model.dart';
import '../../login/login_screen.dart';

class Header extends StatefulWidget {
  const Header({Key? key, required this.headerTitle}) : super(key: key);
  final String headerTitle;
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  //late AdminModel admin;
  String username = "";
  final PrefService _prefService = PrefService();
  @override
  void initState() {
    _prefService.readUsername().then((value) {
      print("Header username : " + value.toString());
      if (value != null) {
        setState(() {
          username = value.toString();
          //admin = context.read<LoginViewModel>().admin;
        });
      } else {
        Beamer.of(context).beamToReplacementNamed(LoginPage.path);
      }
    });
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context) && !Responsive.isTablet(context))
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: context.read<MenuController>().controlMenu,
          ),
        if (!Responsive.isMobile(context))
          Text(
            widget.headerTitle,
            style: kBigTitleBlackBold,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        //const Expanded(child: SearchField()),
        Expanded(
          child: ProfileCard(
            username: username,
            prefService: _prefService,
          ),
        )
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  ProfileCard({Key? key, required this.username, required this.prefService})
      : super(key: key);
  String username;
  PrefService prefService;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: defaultPadding),
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: kPageColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: ExpansionTile(
        title: Row(
          children: [
            Image.asset(
              "assets/images/profile.png",
              height: 38,
            ),
            if (!Responsive.isMobile(context))
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                child: Text(username.toString()),
              ),
          ],
        ),
        children: [
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
                prefService.removeToken();
                prefService.removeRole();
                prefService.removeUsername();
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
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: kPageColor,
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(defaultPadding * 0.75),
            margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: const BoxDecoration(
              color: kSecondaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
