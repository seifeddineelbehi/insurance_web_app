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
    SizeConfig().init(context);
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
            width: cardDetailConstatBorderThikness, color: Colors.grey),
      ),
      child: Expanded(
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
          ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (vehiculeA.circonstances!
                      .contains(Circonstances[0].toString()))
                    const Icon(
                      Icons.check_box,
                      color: kVehiculeAColor,
                    ),
                  Expanded(
                    child: Center(
                      child: SelectableText(
                        (Circonstances.indexOf(Circonstances[0]) + 1)
                                .toString() +
                            "-" +
                            Circonstances[0].toString(),
                        style: GoogleFonts.poppins(
                          color: Palette.textColor,
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.kDefaultSize * 1.75,
                        ),
                      ),
                    ),
                  ),
                  if (vehiculeB.circonstances!
                      .contains(Circonstances[0].toString()))
                    const Icon(
                      Icons.check_box,
                      color: kVehiculeBColor,
                    ),
                ],
              ),
              const Divider(
                thickness: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (vehiculeA.circonstances!
                      .contains(Circonstances[1].toString()))
                    const Icon(
                      Icons.check_box,
                      color: kVehiculeAColor,
                    ),
                  Expanded(
                    child: Center(
                      child: SelectableText(
                        (Circonstances.indexOf(Circonstances[1]) + 1)
                                .toString() +
                            "-" +
                            Circonstances[1].toString(),
                        style: GoogleFonts.poppins(
                          color: Palette.textColor,
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.kDefaultSize * 1.75,
                        ),
                      ),
                    ),
                  ),
                  if (vehiculeB.circonstances!
                      .contains(Circonstances[1].toString()))
                    const Icon(
                      Icons.check_box,
                      color: kVehiculeBColor,
                    ),
                ],
              ),
              const Divider(
                thickness: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (vehiculeA.circonstances!
                      .contains(Circonstances[2].toString()))
                    const Icon(
                      Icons.check_box,
                      color: kVehiculeAColor,
                    ),
                  Expanded(
                    child: Center(
                      child: SelectableText(
                        (Circonstances.indexOf(Circonstances[2]) + 1)
                                .toString() +
                            "-" +
                            Circonstances[2].toString(),
                        style: GoogleFonts.poppins(
                          color: Palette.textColor,
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.kDefaultSize * 1.75,
                        ),
                      ),
                    ),
                  ),
                  if (vehiculeB.circonstances!
                      .contains(Circonstances[2].toString()))
                    const Icon(
                      Icons.check_box,
                      color: kVehiculeBColor,
                    ),
                ],
              ),
              const Divider(
                thickness: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (vehiculeA.circonstances!
                      .contains(Circonstances[3].toString()))
                    const Icon(
                      Icons.check_box,
                      color: kVehiculeAColor,
                    ),
                  Expanded(
                    child: Center(
                      child: SelectableText(
                        (Circonstances.indexOf(Circonstances[3]) + 1)
                                .toString() +
                            "-" +
                            Circonstances[3].toString(),
                        style: GoogleFonts.poppins(
                          color: Palette.textColor,
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.kDefaultSize * 1.75,
                        ),
                      ),
                    ),
                  ),
                  if (vehiculeB.circonstances!
                      .contains(Circonstances[3].toString()))
                    const Icon(
                      Icons.check_box,
                      color: kVehiculeBColor,
                    ),
                ],
              ),
              const Divider(
                thickness: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (vehiculeA.circonstances!
                      .contains(Circonstances[4].toString()))
                    const Icon(
                      Icons.check_box,
                      color: kVehiculeAColor,
                    ),
                  Expanded(
                    child: Center(
                      child: SelectableText(
                        (Circonstances.indexOf(Circonstances[4]) + 1)
                                .toString() +
                            "-" +
                            Circonstances[4].toString(),
                        style: GoogleFonts.poppins(
                          color: Palette.textColor,
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.kDefaultSize * 1.75,
                        ),
                      ),
                    ),
                  ),
                  if (vehiculeB.circonstances!
                      .contains(Circonstances[4].toString()))
                    const Icon(
                      Icons.check_box,
                      color: kVehiculeBColor,
                    ),
                ],
              ),
              const Divider(
                thickness: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (vehiculeA.circonstances!
                      .contains(Circonstances[5].toString()))
                    const Icon(
                      Icons.check_box,
                      color: kVehiculeAColor,
                    ),
                  Expanded(
                    child: Center(
                      child: SelectableText(
                        (Circonstances.indexOf(Circonstances[5]) + 1)
                                .toString() +
                            "-" +
                            Circonstances[5].toString(),
                        style: GoogleFonts.poppins(
                          color: Palette.textColor,
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.kDefaultSize * 1.75,
                        ),
                      ),
                    ),
                  ),
                  if (vehiculeB.circonstances!
                      .contains(Circonstances[5].toString()))
                    const Icon(
                      Icons.check_box,
                      color: kVehiculeBColor,
                    ),
                ],
              ),
              const Divider(
                thickness: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (vehiculeA.circonstances!
                      .contains(Circonstances[6].toString()))
                    const Icon(
                      Icons.check_box,
                      color: kVehiculeAColor,
                    ),
                  Expanded(
                    child: Center(
                      child: SelectableText(
                        (Circonstances.indexOf(Circonstances[6]) + 1)
                                .toString() +
                            "-" +
                            Circonstances[6].toString(),
                        style: GoogleFonts.poppins(
                          color: Palette.textColor,
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.kDefaultSize * 1.75,
                        ),
                      ),
                    ),
                  ),
                  if (vehiculeB.circonstances!
                      .contains(Circonstances[6].toString()))
                    const Icon(
                      Icons.check_box,
                      color: kVehiculeBColor,
                    ),
                ],
              ),
              const Divider(
                thickness: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (vehiculeA.circonstances!
                      .contains(Circonstances[7].toString()))
                    const Icon(
                      Icons.check_box,
                      color: kVehiculeAColor,
                    ),
                  Expanded(
                    child: Center(
                      child: SelectableText(
                        (Circonstances.indexOf(Circonstances[7]) + 1)
                                .toString() +
                            "-" +
                            Circonstances[7].toString(),
                        style: GoogleFonts.poppins(
                          color: Palette.textColor,
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.kDefaultSize * 1.75,
                        ),
                      ),
                    ),
                  ),
                  if (vehiculeB.circonstances!
                      .contains(Circonstances[7].toString()))
                    const Icon(
                      Icons.check_box,
                      color: kVehiculeBColor,
                    ),
                ],
              ),
              const Divider(
                thickness: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (vehiculeA.circonstances!
                      .contains(Circonstances[8].toString()))
                    const Icon(
                      Icons.check_box,
                      color: kVehiculeAColor,
                    ),
                  Expanded(
                    child: Center(
                      child: SelectableText(
                        (Circonstances.indexOf(Circonstances[8]) + 1)
                                .toString() +
                            "-" +
                            Circonstances[8].toString(),
                        style: GoogleFonts.poppins(
                          color: Palette.textColor,
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.kDefaultSize * 1.75,
                        ),
                      ),
                    ),
                  ),
                  if (vehiculeB.circonstances!
                      .contains(Circonstances[8].toString()))
                    const Icon(
                      Icons.check_box,
                      color: kVehiculeBColor,
                    ),
                ],
              ),
              const Divider(
                thickness: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (vehiculeA.circonstances!
                      .contains(Circonstances[9].toString()))
                    const Icon(
                      Icons.check_box,
                      color: kVehiculeAColor,
                    ),
                  Expanded(
                    child: Center(
                      child: SelectableText(
                        (Circonstances.indexOf(Circonstances[9]) + 1)
                                .toString() +
                            "-" +
                            Circonstances[9].toString(),
                        style: GoogleFonts.poppins(
                          color: Palette.textColor,
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.kDefaultSize * 1.75,
                        ),
                      ),
                    ),
                  ),
                  if (vehiculeB.circonstances!
                      .contains(Circonstances[9].toString()))
                    const Icon(
                      Icons.check_box,
                      color: kVehiculeBColor,
                    ),
                ],
              ),
              const Divider(
                thickness: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (vehiculeA.circonstances!
                      .contains(Circonstances[10].toString()))
                    const Icon(
                      Icons.check_box,
                      color: kVehiculeAColor,
                    ),
                  Expanded(
                    child: Center(
                      child: SelectableText(
                        (Circonstances.indexOf(Circonstances[10]) + 1)
                                .toString() +
                            "-" +
                            Circonstances[10].toString(),
                        style: GoogleFonts.poppins(
                          color: Palette.textColor,
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.kDefaultSize * 1.75,
                        ),
                      ),
                    ),
                  ),
                  if (vehiculeB.circonstances!
                      .contains(Circonstances[10].toString()))
                    const Icon(
                      Icons.check_box,
                      color: kVehiculeBColor,
                    ),
                ],
              ),
              const Divider(
                thickness: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (vehiculeA.circonstances!
                      .contains(Circonstances[11].toString()))
                    const Icon(
                      Icons.check_box,
                      color: kVehiculeAColor,
                    ),
                  Expanded(
                    child: Center(
                      child: SelectableText(
                        (Circonstances.indexOf(Circonstances[11]) + 1)
                                .toString() +
                            "-" +
                            Circonstances[11].toString(),
                        style: GoogleFonts.poppins(
                          color: Palette.textColor,
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.kDefaultSize * 1.75,
                        ),
                      ),
                    ),
                  ),
                  if (vehiculeB.circonstances!
                      .contains(Circonstances[11].toString()))
                    const Icon(
                      Icons.check_box,
                      color: kVehiculeBColor,
                    ),
                ],
              ),
              const Divider(
                thickness: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (vehiculeA.circonstances!
                      .contains(Circonstances[12].toString()))
                    const Icon(
                      Icons.check_box,
                      color: kVehiculeAColor,
                    ),
                  Expanded(
                    child: Center(
                      child: SelectableText(
                        (Circonstances.indexOf(Circonstances[12]) + 1)
                                .toString() +
                            "-" +
                            Circonstances[12].toString(),
                        style: GoogleFonts.poppins(
                          color: Palette.textColor,
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.kDefaultSize * 1.75,
                        ),
                      ),
                    ),
                  ),
                  if (vehiculeB.circonstances!
                      .contains(Circonstances[12].toString()))
                    const Icon(
                      Icons.check_box,
                      color: kVehiculeBColor,
                    ),
                ],
              ),
              const Divider(
                thickness: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (vehiculeA.circonstances!
                      .contains(Circonstances[13].toString()))
                    const Icon(
                      Icons.check_box,
                      color: kVehiculeAColor,
                    ),
                  Expanded(
                    child: Center(
                      child: SelectableText(
                        (Circonstances.indexOf(Circonstances[13]) + 1)
                                .toString() +
                            "-" +
                            Circonstances[13].toString(),
                        style: GoogleFonts.poppins(
                          color: Palette.textColor,
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.kDefaultSize * 1.75,
                        ),
                      ),
                    ),
                  ),
                  if (vehiculeB.circonstances!
                      .contains(Circonstances[13].toString()))
                    const Icon(
                      Icons.check_box,
                      color: kVehiculeBColor,
                    ),
                ],
              ),
              const Divider(
                thickness: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (vehiculeA.circonstances!
                      .contains(Circonstances[14].toString()))
                    const Icon(
                      Icons.check_box,
                      color: kVehiculeAColor,
                    ),
                  Expanded(
                    child: Center(
                      child: SelectableText(
                        (Circonstances.indexOf(Circonstances[14]) + 1)
                                .toString() +
                            "-" +
                            Circonstances[14].toString(),
                        style: GoogleFonts.poppins(
                          color: Palette.textColor,
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.kDefaultSize * 1.75,
                        ),
                      ),
                    ),
                  ),
                  if (vehiculeB.circonstances!
                      .contains(Circonstances[14].toString()))
                    const Icon(
                      Icons.check_box,
                      color: kVehiculeBColor,
                    ),
                ],
              ),
              const Divider(
                thickness: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (vehiculeA.circonstances!
                      .contains(Circonstances[15].toString()))
                    const Icon(
                      Icons.check_box,
                      color: kVehiculeAColor,
                    ),
                  Expanded(
                    child: Center(
                      child: SelectableText(
                        (Circonstances.indexOf(Circonstances[15]) + 1)
                                .toString() +
                            "-" +
                            Circonstances[15].toString(),
                        style: GoogleFonts.poppins(
                          color: Palette.textColor,
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.kDefaultSize * 1.75,
                        ),
                      ),
                    ),
                  ),
                  if (vehiculeB.circonstances!
                      .contains(Circonstances[15].toString()))
                    const Icon(
                      Icons.check_box,
                      color: kVehiculeBColor,
                    ),
                ],
              ),
              const Divider(
                thickness: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (vehiculeA.circonstances!
                      .contains(Circonstances[16].toString()))
                    const Icon(
                      Icons.check_box,
                      color: kVehiculeAColor,
                    ),
                  Expanded(
                    child: Center(
                      child: SelectableText(
                        (Circonstances.indexOf(Circonstances[16]) + 1)
                                .toString() +
                            "-" +
                            Circonstances[16].toString(),
                        style: GoogleFonts.poppins(
                          color: Palette.textColor,
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.kDefaultSize * 1.75,
                        ),
                      ),
                    ),
                  ),
                  if (vehiculeB.circonstances!
                      .contains(Circonstances[16].toString()))
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
          )
        ]),
      ),
    );
  }
}
