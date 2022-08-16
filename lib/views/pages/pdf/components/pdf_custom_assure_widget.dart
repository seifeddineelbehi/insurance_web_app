import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../../model/vehicule_model.dart';
import '../../../../utils/palette.dart';
import '../../../../utils/size_config.dart';

Widget PDFAssure({required VehiculeModel vehicule}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4),
    child: Container(
      //width: SizeConfig.safeBlockHorizontal,
      decoration: const BoxDecoration(
        color: PdfColor.fromInt(0xFFFFFFFF),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Assuré',
              style: TextStyle(
                color: const PdfColor.fromInt(0xFF333333),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Nom : ' + vehicule.nomAssure.toString(),
              style: TextStyle(
                color: const PdfColor.fromInt(0xFFC1C1C1),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Prenom : ' + vehicule.prenomAssure.toString(),
              style: TextStyle(
                color: const PdfColor.fromInt(0xFFC1C1C1),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Adresse ' + vehicule.addresseAssure.toString(),
              style: TextStyle(
                color: const PdfColor.fromInt(0xFFC1C1C1),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'tel :' + vehicule.telAssure.toString(),
              style: TextStyle(
                color: const PdfColor.fromInt(0xFFC1C1C1),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
