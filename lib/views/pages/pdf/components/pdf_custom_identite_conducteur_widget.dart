import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../../model/vehicule_model.dart';
import '../../../../utils/palette.dart';
import '../../../../utils/size_config.dart';

Widget PDFIdentiteConducteur({required VehiculeModel vehicule}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 2),
    child: Container(
      //width: SizeConfig.safeBlockHorizontal,
      decoration: const BoxDecoration(
        color: PdfColor.fromInt(0xFFFFFFFF),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Identité de Conducteur',
              style: TextStyle(
                  color: const PdfColor.fromInt(0xFF333333),
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
            Text(
              'Nom : ' + vehicule.nomConducteur.toString(),
              style: TextStyle(
                  color: const PdfColor.fromInt(0xFFC1C1C1),
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
            Text(
              'Prenom : ' + vehicule.prenomConducteur.toString(),
              style: TextStyle(
                  color: const PdfColor.fromInt(0xFFC1C1C1),
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
            Text(
              'Adresse ' + vehicule.addresseConducteur.toString(),
              style: TextStyle(
                  color: const PdfColor.fromInt(0xFFC1C1C1),
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
            Text(
              'Permis de conduire N°:' + vehicule.permisConducteur.toString(),
              style: TextStyle(
                  color: const PdfColor.fromInt(0xFFC1C1C1),
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
            Text(
              'Délivré le : ' + vehicule.delivrancePermisConducteur.toString(),
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
