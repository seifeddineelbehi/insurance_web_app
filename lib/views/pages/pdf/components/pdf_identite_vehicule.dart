import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../../model/vehicule_model.dart';
import '../../../../utils/palette.dart';
import '../../../../utils/size_config.dart';

Widget PDFIdentiteVehicule({required VehiculeModel vehicule}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4),
    child: Container(
      //width: SizeConfig.safeBlockHorizontal,
      decoration: BoxDecoration(
        color: const PdfColor.fromInt(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Identité de Vehicule',
              style: TextStyle(
                  color: const PdfColor.fromInt(0xFF333333),
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
            Text(
              'Marque, type : ' + vehicule.marqueTypeVoiture.toString(),
              style: TextStyle(
                  color: const PdfColor.fromInt(0xFFC1C1C1),
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
            Text(
              'N° d\'immatriculation: ' + vehicule.immatriculation.toString(),
              style: TextStyle(
                  color: const PdfColor.fromInt(0xFFC1C1C1),
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
            Text(
              'Sens Suivi : ' + vehicule.sensSuivi.toString(),
              style: TextStyle(
                  color: const PdfColor.fromInt(0xFFC1C1C1),
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
            Text(
              'Venant de ' + vehicule.venantDe.toString(),
              style: TextStyle(
                  color: const PdfColor.fromInt(0xFFC1C1C1),
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
            Text(
              'Allant à : ' + vehicule.allantA.toString(),
              style: TextStyle(
                  color: const PdfColor.fromInt(0xFFC1C1C1),
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ],
        ),
      ),
    ),
  );
}
