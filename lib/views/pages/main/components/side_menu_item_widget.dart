import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/utils/responsive.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/palette.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.icon,
    required this.press,
    required this.active,
    required this.length,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback press;
  final bool active;
  final int length;

  @override
  Widget build(BuildContext context) {
    var kSideMenuText = Responsive.isDesktop(context)
        ? GoogleFonts.poppins(
            color: active ? Colors.white : secondaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 15.0,
          )
        : Responsive.isTablet(context)
            ? GoogleFonts.poppins(
                color: active ? Colors.white : secondaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
              )
            : GoogleFonts.poppins(
                color: active ? Colors.white : secondaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
              );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: active
            ? const BoxDecoration(
                color: Palette.drawerItemSelectedColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              )
            : const BoxDecoration(),
        child: ListTile(
          onTap: press,
          selected: true,
          horizontalTitleGap: 0.0,
          leading: Icon(icon,
              color: active ? Colors.white : Colors.blueGrey, size: 20),
          trailing: length > 0
              ? Text(
                  length.toString(),
                  style: kSideMenuText,
                )
              : Text(
                  "",
                  style: kSideMenuText,
                ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title, style: kSideMenuText),
            ],
          ),
        ),
      ),
    );
  }
}
