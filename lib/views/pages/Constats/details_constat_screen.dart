import 'package:flutter/material.dart';
import 'package:flutter_template/model/constat_model.dart';
import 'package:flutter_template/views/pages/Constats/components/constat_header.dart';
import 'package:flutter_template/views/pages/Constats/components/croquis_widget.dart';
import 'package:flutter_template/views/pages/Constats/components/custom-vehicule_detail.dart';
import 'package:flutter_template/views/pages/Constats/components/custom_circonstances.dart';

import '../../../utils/constants.dart';
import '../../../utils/responsive.dart';

class DetailsConstat extends StatefulWidget {
  static const path = "/home/detailConstat";
  final String ConstatId;
  final ConstatModel constat;
  const DetailsConstat(
      {Key? key, required this.ConstatId, required this.constat})
      : super(key: key);

  @override
  _DetailsConstatState createState() => _DetailsConstatState();
}

class _DetailsConstatState extends State<DetailsConstat> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.all(defaultPadding),
        child: Container(
          padding: const EdgeInsets.all(defaultPadding * 6),
          decoration: const BoxDecoration(
            color: kPageColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            children: [
              constatHeader(constat: widget.constat),
              const SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        //const MyFiles(),
                        const SizedBox(height: defaultPadding),
                        CustumVehiculedetails(
                          vehicule: widget.constat.vehiculeA!,
                          nomVehicule: 'Vehicule A',
                          color: kVehiculeAColor,
                        ),
                        if (Responsive.isMobile(context))
                          const SizedBox(height: defaultPadding),
                        if (Responsive.isMobile(context))
                          Column(
                            children: [
                              CustomCirconstance(
                                  vehiculeA: widget.constat.vehiculeA!,
                                  vehiculeB: widget.constat.vehiculeB!),
                              CustomCroquis(
                                  croquis: widget.constat.croquis.toString()),
                            ],
                          ),
                        if (Responsive.isMobile(context))
                          const SizedBox(height: defaultPadding),
                        if (Responsive.isMobile(context))
                          CustumVehiculedetails(
                            vehicule: widget.constat.vehiculeB!,
                            nomVehicule: 'Vehicule B',
                            color: kVehiculeBColor,
                          ),
                      ],
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    const SizedBox(width: defaultPadding),
                  // On Mobile means if the screen is less than 850 we dont want to show it
                  if (!Responsive.isMobile(context))
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          CustomCirconstance(
                              vehiculeA: widget.constat.vehiculeA!,
                              vehiculeB: widget.constat.vehiculeB!),
                          CustomCroquis(
                              croquis: widget.constat.croquis.toString()),
                        ],
                      ),
                    ),
                  if (!Responsive.isMobile(context))
                    const SizedBox(width: defaultPadding),
                  // On Mobile means if the screen is less than 850 we dont want to show it
                  if (!Responsive.isMobile(context))
                    Expanded(
                      flex: 2,
                      child: CustumVehiculedetails(
                        vehicule: widget.constat.vehiculeB!,
                        nomVehicule: 'Vehicule B',
                        color: kVehiculeBColor,
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
