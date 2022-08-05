import 'package:flutter/material.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({
    Key? key,
    required this.child,
    required this.text,
    this.fontWeight = FontWeight.w600,
    required this.fontSize,
  }) : super(key: key);

  final Widget child;
  final String text;
  final FontWeight fontWeight;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: SizeConfig.safeBlockHorizontal * 85,
        height: SizeConfig.safeBlockVertical * 8,
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
        child: ListTile(
          title: Text(
            text,
            style: GoogleFonts.poppins(
              color: Palette.textColor,
              fontWeight: fontWeight,
              fontSize: fontSize,
            ),
          ),
          trailing: child,
        ),
      ),
    );
  }
}
