import 'package:flutter/material.dart';
import 'package:flutter_template/model/vehicule_model.dart';
import 'package:flutter_template/utils/apis.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/palette.dart';
import '../../../../utils/size_config.dart';

class CustomPointChoc extends StatefulWidget {
  const CustomPointChoc({Key? key, required this.vehicule}) : super(key: key);
  final VehiculeModel vehicule;
  @override
  _CustomPointChocState createState() => _CustomPointChocState();
}

class _CustomPointChocState extends State<CustomPointChoc> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16),
      child: Container(
        //width: SizeConfig.safeBlockHorizontal,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Point choc initiale',
                style: GoogleFonts.poppins(
                  color: Palette.textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: SizeConfig.kDefaultSize * 2.3,
                ),
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 0.5,
              ),
              Image.network(
                widget.vehicule.pointChoc.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
