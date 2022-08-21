import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:printing/printing.dart';

import '../../../../model/vehicule_model.dart';
import '../../../../utils/apis.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/palette.dart';
import '../../../../utils/size_config.dart';

class CustomBriseImage extends StatefulWidget {
  const CustomBriseImage({Key? key, required this.image}) : super(key: key);
  final String image;
  @override
  _CustomBriseImageState createState() => _CustomBriseImageState();
}

class _CustomBriseImageState extends State<CustomBriseImage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16),
      child: Container(
        //width: SizeConfig.safeBlockHorizontal,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
              width: cardDetailConstatBorderThikness,
              color: kCardConstatDetailBordeColor),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Image du Brise glasse',
                style: GoogleFonts.poppins(
                  color: Palette.textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: SizeConfig.kDefaultSize * 3,
                ),
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 0.5,
              ),
              Image(
                image: NetworkImage(
                  widget.image,
                ),
              ),
              /*Image.network(
                widget.image,
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
