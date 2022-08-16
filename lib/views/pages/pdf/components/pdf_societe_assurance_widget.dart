import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../../model/vehicule_model.dart';
import '../../../../utils/palette.dart';
import '../../../../utils/size_config.dart';

Widget PDFSocieteAssurance({required VehiculeModel vehicule}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 2),
    child: Container(
      //width: SizeConfig.safeBlockHorizontal,
      decoration: const BoxDecoration(
        color: PdfColor.fromInt(0xFFFFFFFF),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Société d\'assurance ',
              style: TextStyle(
                  color: const PdfColor.fromInt(0xFF333333),
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
          Text(
            'Vehicule Assuré par : ' + vehicule.assurePar.toString(),
            style: TextStyle(
                color: const PdfColor.fromInt(0xFFC1C1C1),
                fontWeight: FontWeight.bold,
                fontSize: 12),
          ),
          Text(
            'Contrat N° : ' + vehicule.numContratAssurance.toString(),
            style: TextStyle(
                color: const PdfColor.fromInt(0xFFC1C1C1),
                fontWeight: FontWeight.bold,
                fontSize: 12),
          ),
          Text(
            'Agence : ' + vehicule.agence.toString(),
            style: TextStyle(
                color: const PdfColor.fromInt(0xFFC1C1C1),
                fontWeight: FontWeight.bold,
                fontSize: 12),
          ),
          Text(
            'Attestation valable',
            style: TextStyle(
                color: const PdfColor.fromInt(0xFFC1C1C1),
                fontWeight: FontWeight.bold,
                fontSize: 12),
          ),
          Text(
            'du : ' + vehicule.debutValid.toString(),
            style: TextStyle(
                color: const PdfColor.fromInt(0xFFC1C1C1),
                fontWeight: FontWeight.bold,
                fontSize: 12),
          ),
          Text(
            'au : ' + vehicule.finValid.toString(),
            style: TextStyle(
                color: const PdfColor.fromInt(0xFFC1C1C1),
                fontWeight: FontWeight.bold,
                fontSize: 12),
          ),
        ],
      ),
    ),
  );
}
