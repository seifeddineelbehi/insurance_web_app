import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/model/client_data.dart';
import 'package:flutter_template/model/client_model.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:flutter_template/views/pages/Clients/components/client_accident_table_cells.dart';
import 'package:flutter_template/views/pages/Clients/components/client_brise_table_cells.dart';
import 'package:flutter_template/views/pages/Clients/components/client_incendies_table_cells.dart';
import 'package:flutter_template/views/pages/Clients/components/client_vol_table_cells.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';
import '../../../utils/palette.dart';
import '../../../viewModel/clients_screen_view_model.dart';
import 'components/custom_detail_widget.dart';

class DetailClient extends StatefulWidget {
  static const path = "/home/clientDetail";
  final String clientId;
  final ClientModel client;

  const DetailClient({Key? key, required this.clientId, required this.client})
      : super(key: key);

  @override
  _DetailClientState createState() => _DetailClientState();
}

class _DetailClientState extends State<DetailClient> {
  @override
  Widget build(BuildContext context) {
    return Title(
      title: "Detail Client",
      color: Colors.blueGrey,
      child: Scaffold(
        backgroundColor: kPageColor,
        body: SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(
                height: defaultPadding,
              ),
              Center(
                child: Text(
                  "Detail Client",
                  style: kBigTitleBlackBold,
                ),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              const Divider(
                thickness: 10,
              ),
              FutureBuilder<ClientDataModel?>(
                future: context
                    .read<ClientsViewModel>()
                    .getClientData(widget.client.refAssurance!),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 2,
                              child: CustomDetailWidget(
                                title: "Nom",
                                text: snapshot.data!.nomClient!,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: CustomDetailWidget(
                                title: "Prénom",
                                text: snapshot.data!.prenomClient!,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: CustomDetailWidget(
                                title: "Adresse",
                                text: snapshot.data!.addresseClient!,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 3,
                              child: CustomDetailWidget(
                                title: "Assureur",
                                text: snapshot.data!.assureur!,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: CustomDetailWidget(
                                title: "Agence",
                                text: snapshot.data!.agence!,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 2,
                              child: CustomDetailWidget(
                                title: "Numéro Contrat",
                                text: snapshot.data!.numContrat!,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: CustomDetailWidget(
                                title: "Date Début Contrat",
                                text: snapshot.data!.DBContrat!,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: CustomDetailWidget(
                                title: "Date Fin Contrat",
                                text: snapshot.data!.DFContrat!,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 3,
                              child: CustomDetailWidget(
                                title: "Voiture ",
                                text: snapshot.data!.voiture!,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: CustomDetailWidget(
                                title: "Immatriculation",
                                text: snapshot.data!.immatriculation!,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              if (widget.client.constatsAccidents!.isNotEmpty)
                const Divider(
                  thickness: 10,
                ),
              if (widget.client.constatsAccidents!.isNotEmpty)
                Text(
                  "Liste des constats",
                  style: kMediumTitleBlackBold.copyWith(
                    color: Colors.blueGrey,
                  ),
                ),
              if (widget.client.constatsAccidents!.isNotEmpty)
                const SizedBox(
                  height: defaultPadding,
                ),
              if (widget.client.constatsAccidents!.isNotEmpty)
                const Divider(
                  thickness: 10,
                ),
              if (widget.client.constatsAccidents!.isNotEmpty)
                DataTable2(
                  showCheckboxColumn: false,
                  columnSpacing: defaultPadding,
                  minWidth: 600,
                  columns: [
                    DataColumn(
                      label: Text(
                        "Date",
                        style: kMediumTableColumnWhiteBold.copyWith(
                          color: bgColor,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Client 1",
                        style: kMediumTableColumnWhiteBold.copyWith(
                          color: bgColor,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Client 2",
                        style: kMediumTableColumnWhiteBold.copyWith(
                          color: bgColor,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Actions",
                        style: kMediumTableColumnWhiteBold.copyWith(
                          color: bgColor,
                        ),
                      ),
                    ),
                  ],
                  rows: List.generate(
                    widget.client.constatsAccidents!.length,
                    (index) => listConstatClientDataRow(
                        widget.client.constatsAccidents![index], context),
                  ),
                ),
              if (widget.client.vols!.isNotEmpty)
                const Divider(
                  thickness: 10,
                ),
              if (widget.client.vols!.isNotEmpty)
                Text(
                  "Liste des vols",
                  style: kMediumTitleBlackBold.copyWith(
                    color: Colors.blueGrey,
                  ),
                ),
              if (widget.client.vols!.isNotEmpty)
                const SizedBox(
                  height: defaultPadding,
                ),
              if (widget.client.vols!.isNotEmpty)
                const Divider(
                  thickness: 10,
                ),
              if (widget.client.vols!.isNotEmpty)
                DataTable2(
                  empty: Text(
                    "Aucune declaration de vols pour le moment",
                    style: kMediumTitleWhiteBold.copyWith(
                      color: kPrimaryColor,
                    ),
                  ),
                  showCheckboxColumn: false,
                  columnSpacing: defaultPadding,
                  minWidth: 600,
                  columns: [
                    DataColumn(
                      label: Text(
                        "Date",
                        style: kMediumTableColumnWhiteBold.copyWith(
                          color: bgColor,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Description",
                        style: kMediumTableColumnWhiteBold.copyWith(
                          color: bgColor,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Actions",
                        style: kMediumTableColumnWhiteBold.copyWith(
                          color: bgColor,
                        ),
                      ),
                    ),
                  ],
                  rows: List.generate(
                    widget.client.vols!.length,
                    (index) => ClientVolDataRow(widget.client.vols![index],
                        context, widget.client.vols!),
                  ),
                ),
              if (widget.client.incendies!.isNotEmpty)
                const Divider(
                  thickness: 10,
                ),
              if (widget.client.incendies!.isNotEmpty)
                Text(
                  "Liste des Incendies",
                  style: kMediumTitleBlackBold.copyWith(
                    color: Colors.blueGrey,
                  ),
                ),
              if (widget.client.incendies!.isNotEmpty)
                const SizedBox(
                  height: defaultPadding,
                ),
              if (widget.client.incendies!.isNotEmpty)
                const Divider(
                  thickness: 10,
                ),
              if (widget.client.incendies!.isNotEmpty)
                DataTable2(
                  showCheckboxColumn: false,
                  columnSpacing: defaultPadding,
                  minWidth: 600,
                  columns: [
                    DataColumn(
                      label: Text(
                        "Date",
                        style: kMediumTableColumnWhiteBold.copyWith(
                          color: bgColor,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Description",
                        style: kMediumTableColumnWhiteBold.copyWith(
                          color: bgColor,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Actions",
                        style: kMediumTableColumnWhiteBold.copyWith(
                          color: bgColor,
                        ),
                      ),
                    ),
                  ],
                  rows: List.generate(
                    widget.client.incendies!.length,
                    (index) => ClientIncendiesDataRow(
                        widget.client.incendies![index],
                        context,
                        widget.client.incendies!),
                  ),
                ),
              if (widget.client.briseGlace!.isNotEmpty)
                const Divider(
                  thickness: 10,
                ),
              if (widget.client.briseGlace!.isNotEmpty)
                Text(
                  "Liste des Brises glasses",
                  style: kMediumTitleBlackBold.copyWith(
                    color: Colors.blueGrey,
                  ),
                ),
              if (widget.client.briseGlace!.isNotEmpty)
                const SizedBox(
                  height: defaultPadding,
                ),
              if (widget.client.briseGlace!.isNotEmpty)
                const Divider(
                  thickness: 10,
                ),
              if (widget.client.briseGlace!.isNotEmpty)
                DataTable2(
                  showCheckboxColumn: false,
                  columnSpacing: defaultPadding,
                  minWidth: 600,
                  columns: [
                    DataColumn(
                      label: Text(
                        "Date",
                        style: kMediumTableColumnWhiteBold.copyWith(
                          color: bgColor,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Description",
                        style: kMediumTableColumnWhiteBold.copyWith(
                          color: bgColor,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Etat",
                        style: kMediumTableColumnWhiteBold.copyWith(
                          color: bgColor,
                        ),
                      ),
                    ),
                  ],
                  rows: List.generate(
                    widget.client.briseGlace!.length,
                    (index) => ClientBriseDataRow(
                        widget.client.briseGlace![index], context),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
