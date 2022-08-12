import 'dart:developer';

import 'package:beamer/beamer.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/model/client_model.dart';
import 'package:flutter_template/viewModel/clients_screen_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../utils/constants.dart';
import '../../login/login_screen.dart';
import '../detail_client.dart';

class ClientsTable extends StatefulWidget {
  const ClientsTable({Key? key}) : super(key: key);

  @override
  _ClientsTableState createState() => _ClientsTableState();
}

class _ClientsTableState extends State<ClientsTable> {
  late Future<List<ClientModel>> fetchedClients;

  @override
  void initState() {
    //fetchedClients = context.read<ClientsViewModel>().getAllClients();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final adminsViewModel =
        Provider.of<ClientsViewModel>(context, listen: false);
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: kPageColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Liste des Clients",
            style: kMediumTitleBlackBold.copyWith(
              color: Colors.blueGrey,
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
            child: FutureBuilder<List<ClientModel>>(
              future: context.read<ClientsViewModel>().getAllClients(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data!.isNotEmpty) {
                    return DataTable2(
                      showCheckboxColumn: false,
                      columnSpacing: defaultPadding,
                      minWidth: 600,
                      columns: [
                        DataColumn(
                          label: Text("réference",
                              style: kMediumTitleWhiteBold.copyWith(
                                color: kPrimaryColor,
                              )),
                        ),
                        DataColumn(
                          label: Text(
                            "Code Assurance",
                            style: kMediumTitleWhiteBold.copyWith(
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Nom",
                            style: kMediumTitleWhiteBold.copyWith(
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Validité",
                            style: kMediumTitleWhiteBold.copyWith(
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                      rows: List.generate(
                        snapshot.data!.length,
                        (index) =>
                            recentFileDataRow(snapshot.data![index], context),
                      ),
                    );
                  } else {
                    return Expanded(
                        child: Text(
                      "Aucun Client pour le moment",
                      style: kMediumTitleWhiteBold.copyWith(
                        color: kPrimaryColor,
                      ),
                    ));
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(ClientModel client, BuildContext context) {
  return DataRow(
    onSelectChanged: (selected) {
      if (selected!) {
        log('row-selected: ${client.id}');
        context.beamToNamed(DetailClient.path + "/" + client.id!, data: client);
      }
    },
    cells: [
      DataCell(
        SelectableText(
          client.codeClient!,
          maxLines: 1,
          //overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: secondaryColor,
          ),
        ),
      ),
      DataCell(
        SelectableText(
          client.refAssurance!,
          maxLines: 1,
          //overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: secondaryColor,
          ),
        ),
      ),
      DataCell(
        SelectableText(
          client.username!,
          maxLines: 1,
          //overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: secondaryColor,
          ),
        ),
      ),
      DataCell(
        Container(
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              client.status!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: kPageColor,
              ),
            ),
          ),
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: client.status! == "Unactive" ? Colors.red : Colors.green,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    ],
  );
}
