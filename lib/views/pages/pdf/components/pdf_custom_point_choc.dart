import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../../model/vehicule_model.dart';
import '../../../../utils/palette.dart';
import '../../../../utils/size_config.dart';
import 'package:printing/printing.dart';

Widget PDFCustomPointChoc({required ImageProvider image}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16),
    child: Container(
      //width: SizeConfig.safeBlockHorizontal,
      decoration: BoxDecoration(
        color: const PdfColor.fromInt(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Point choc initiale',
              style: TextStyle(
                color: const PdfColor.fromInt(0xFF333333),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 0.5,
            ),
            Image(
              image,
            ),
          ],
        ),
      ),
    ),
  );
}
