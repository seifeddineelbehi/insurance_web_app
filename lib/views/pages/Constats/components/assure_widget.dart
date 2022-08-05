import 'package:flutter/material.dart';
import 'package:flutter_template/model/vehicule_model.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/palette.dart';
import '../../../../utils/size_config.dart';

class Assure extends StatelessWidget {
  const Assure({Key? key, required this.vehicule}) : super(key: key);

  final VehiculeModel vehicule;
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
                'Assuré',
                style: GoogleFonts.poppins(
                  color: Palette.textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: SizeConfig.kDefaultSize * 3,
                ),
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical * 0.5,
              ),
              Text(
                'Nom : ' + vehicule.nomAssure.toString(),
                style: GoogleFonts.poppins(
                  color: Palette.textSecondaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: SizeConfig.kDefaultSize * 2,
                ),
              ),
              Text(
                'Prenom : ' + vehicule.prenomAssure.toString(),
                style: GoogleFonts.poppins(
                  color: Palette.textSecondaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: SizeConfig.kDefaultSize * 2,
                ),
              ),
              Text(
                'Adresse ' + vehicule.addresseAssure.toString(),
                style: GoogleFonts.poppins(
                  color: Palette.textSecondaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: SizeConfig.kDefaultSize * 2,
                ),
              ),
              Text(
                'tel :' + vehicule.telAssure.toString(),
                style: GoogleFonts.poppins(
                  color: Palette.textSecondaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: SizeConfig.kDefaultSize * 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
