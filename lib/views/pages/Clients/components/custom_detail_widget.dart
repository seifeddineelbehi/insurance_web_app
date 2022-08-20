import 'package:flutter/material.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDetailWidget extends StatelessWidget {
  const CustomDetailWidget({
    Key? key,
    required this.title,
    this.subTitle = "",
    required this.text,
  }) : super(key: key);
  final String title;
  final String subTitle;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16),
      child: Container(
        width: SizeConfig.safeBlockHorizontal,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: ListTile(
            title: Text(
              title,
              style: GoogleFonts.poppins(
                color: Palette.textColor,
                fontWeight: FontWeight.w700,
                fontSize: SizeConfig.kDefaultSize * 2.5,
              ),
            ),
            subtitle: SelectableText(
              text,
              style: GoogleFonts.poppins(
                color: Palette.textSecondaryColor,
                fontWeight: FontWeight.w600,
                fontSize: SizeConfig.kDefaultSize * 1.75,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
