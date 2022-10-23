import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_template/model/temoin_model.dart';
import 'package:flutter_template/utils/responsive.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTemoinsHeaderDetailWidget extends StatelessWidget {
  const CustomTemoinsHeaderDetailWidget({
    Key? key,
    required this.title,
    this.subTitle = "",
    required this.temoins,
  }) : super(key: key);
  final String title;
  final String subTitle;
  final List<TemoinModel> temoins;

  @override
  Widget build(BuildContext context) {
    var kDetailBigText = Responsive.isDesktop(context)
        ? kBigTextBlackBold
        : Responsive.isTablet(context)
            ? kBigTextBlackBold
            : kMediumTextBlackBold;
    var kDetailSmallText = Responsive.isDesktop(context)
        ? kBigTextBlack
        : Responsive.isTablet(context)
            ? kBigTextBlack
            : kMediumTextBlack;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        //width: SizeConfig.safeBlockHorizontal,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: cardDetailConstatBorderThikness, color: kCardConstatDetailBordeColor),
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
            padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 15.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      //width: SizeConfig.safeBlockHorizontal * 75,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: kDetailBigText,
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 0.5,
                          ),
                          if (temoins.isEmpty)
                            Text(
                              "Pas de temoins",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                color: Palette.textColor,
                                fontWeight: FontWeight.w700,
                                fontSize: SizeConfig.kDefaultSize * 1.75,
                              ),
                            )
                          else
                            for (var item in temoins) itemTemoin(item, kDetailSmallText),

                          /*ListView.builder(
                            shrinkWrap: true,

                            itemCount: temoins.length,
                            itemBuilder: (BuildContext context, int index) {
                              return itemTemoin(temoins[index]);
                            })*/
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

Widget itemTemoin(TemoinModel temoin, var kDetailSmallText) {
  return SelectableText(
    temoin.nom.toString() +
        " " +
        temoin.adress.toString() +
        " " +
        temoin.tel.toString() +
        " " +
        temoin.appartenance.toString(),
    style: kDetailSmallText,
  );
}
