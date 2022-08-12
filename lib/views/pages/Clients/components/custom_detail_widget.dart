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
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 18.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: SizeConfig.safeBlockHorizontal * 75,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: GoogleFonts.poppins(
                                color: Palette.textColor,
                                fontWeight: FontWeight.w700,
                                fontSize: SizeConfig.kDefaultSize * 3,
                              ),
                            ),
                            subTitle != ""
                                ? Text(
                                    subTitle,
                                    style: GoogleFonts.poppins(
                                      color: Palette.textColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: SizeConfig.kDefaultSize * 2,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical * 0.5,
                        ),
                        SelectableText(
                          text,
                          style: GoogleFonts.poppins(
                            color: Palette.textSecondaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.kDefaultSize * 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
