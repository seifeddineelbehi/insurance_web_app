import 'package:flutter/material.dart';
import 'package:flutter_template/model/vehicule_model.dart';
import 'package:flutter_template/views/pages/Constats/components/assure_widget.dart';
import 'package:flutter_template/views/pages/Constats/components/degat_widget.dart';
import 'package:flutter_template/views/pages/Constats/components/identite_conducteur_widget.dart';
import 'package:flutter_template/views/pages/Constats/components/identite_vehicule_widget.dart';
import 'package:flutter_template/views/pages/Constats/components/image_accident_widget.dart';
import 'package:flutter_template/views/pages/Constats/components/observation_widget.dart';
import 'package:flutter_template/views/pages/Constats/components/point_choc_widget.dart';
import 'package:flutter_template/views/pages/Constats/components/signature_widget.dart';
import 'package:flutter_template/views/pages/Constats/components/societe_assurance_widget.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/size_config.dart';
import 'custom_constat_header_detail_widget.dart';

class CustumVehiculedetails extends StatefulWidget {
  const CustumVehiculedetails(
      {Key? key,
      required this.vehicule,
      required this.nomVehicule,
      required this.color})
      : super(key: key);
  final VehiculeModel vehicule;
  final String nomVehicule;
  final Color color;

  @override
  _CustumVehiculedetailsState createState() => _CustumVehiculedetailsState();
}

class _CustumVehiculedetailsState extends State<CustumVehiculedetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
            width: cardDetailConstatBorderThikness,
            color: kCardConstatDetailBordeColor),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(
          child: Text(
            widget.nomVehicule,
            style: kMediumTitleBlackBold.copyWith(
              color: Colors.blueGrey,
            ),
          ),
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        const Divider(
          thickness: 10,
        ),
        SizedBox(
          width: double.infinity,
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              SocieteAssurance(vehicule: widget.vehicule),
              IdentiteConsucteur(vehicule: widget.vehicule),
              Assure(vehicule: widget.vehicule),
              IdentiteVehicule(vehicule: widget.vehicule),
              CustomPointChoc(vehicule: widget.vehicule),
              CustomDegat(vehicule: widget.vehicule),
              CustomObservation(vehicule: widget.vehicule),
              CustomSignature(vehicule: widget.vehicule),
              CustomImagesAccident(vehicule: widget.vehicule),
            ],
          ),
        )
      ]),
    );
  }
}
