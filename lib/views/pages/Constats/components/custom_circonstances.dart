import 'package:flutter/material.dart';
import 'package:flutter_template/data/circonstance.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../model/vehicule_model.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/palette.dart';
import '../../../../utils/size_config.dart';

class CustomCirconstance extends StatelessWidget {
  const CustomCirconstance(
      {Key? key, required this.vehiculeA, required this.vehiculeB})
      : super(key: key);
  final VehiculeModel vehiculeA;
  final VehiculeModel vehiculeB;
  @override
  Widget build(BuildContext context) {
    List<String> circonstances = Circonstances;

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: kPageColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(
          child: Text(
            'Circonstances',
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
              for (var item in Circonstances)
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (vehiculeA.circonstances!
                              .contains(item.toString()))
                            const Icon(
                              Icons.check_box,
                              color: kVehiculeAColor,
                            ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                item.toString(),
                                style: GoogleFonts.poppins(
                                  color: Palette.textColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: SizeConfig.kDefaultSize * 3,
                                ),
                              ),
                            ),
                          ),
                          if (vehiculeB.circonstances!
                              .contains(item.toString()))
                            const Icon(
                              Icons.check_box,
                              color: kVehiculeBColor,
                            ),
                        ],
                      ),
                      const Divider(
                        thickness: 5,
                      ),
                    ],
                  ),
                )
            ],
          ),
        )
      ]),
    );
  }
}
