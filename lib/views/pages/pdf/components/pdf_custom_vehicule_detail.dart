import 'package:flutter_template/model/vehicule_model.dart';
import 'package:flutter_template/views/pages/pdf/components/pdf_custom_assure_widget.dart';
import 'package:flutter_template/views/pages/pdf/components/pdf_custom_degat.dart';
import 'package:flutter_template/views/pages/pdf/components/pdf_custom_identite_conducteur_widget.dart';
import 'package:flutter_template/views/pages/pdf/components/pdf_custom_observation.dart';
import 'package:flutter_template/views/pages/pdf/components/pdf_custom_point_choc.dart';
import 'package:flutter_template/views/pages/pdf/components/pdf_custom_signature.dart';
import 'package:flutter_template/views/pages/pdf/components/pdf_identite_vehicule.dart';
import 'package:flutter_template/views/pages/pdf/components/pdf_societe_assurance_widget.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../../utils/constants.dart';

Widget PDFCustomVehicumeDetail(
    {required VehiculeModel vehicule,
    required String nomVehicule,
    required PdfColor color,
    required Document pdf}) {
  return Container(
    padding: const EdgeInsets.all(defaultPadding),
    decoration: BoxDecoration(
      color: color,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      border: Border.all(
          width: cardDetailConstatBorderThikness,
          color: const PdfColor.fromInt(0x8A000000)),
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Center(
        child: Text(
          nomVehicule,
          style: TextStyle(
            color: const PdfColor.fromInt(0xFF607D8B),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(
        height: defaultPadding,
      ),
      Divider(
        thickness: 10,
      ),
      SizedBox(
        width: double.infinity,
        child: ListView(
          children: [
            PDFSocieteAssurance(vehicule: vehicule),
            PDFIdentiteConducteur(vehicule: vehicule),
            PDFAssure(vehicule: vehicule),
            PDFIdentiteVehicule(vehicule: vehicule),
            //PDFCustomPointChoc(vehicule: vehicule),
            PDFCustomDegat(vehicule: vehicule),
            PDFCustomObservation(vehicule: vehicule),
            //PDFCustomSignature(vehicule: vehicule),
          ],
        ),
      )
    ]),
  );
}
