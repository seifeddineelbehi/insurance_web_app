import 'dart:developer';

import 'package:beamer/beamer.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
  TextEditingController controller = TextEditingController();
  String _searchResult = "";
  String _searchValue = "";
  bool taped = false;
  bool empty = true;
  List<ClientModel> clientFiltered = [];
  List<ClientModel> Allclients = [];
  @override
  void initState() {
    //fetchedClients = context.read<ClientsViewModel>().getAllClients();
    setState(() {
      clientFiltered = Allclients;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          ListTile(
            title: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Search",
                fillColor: kPageColor,
                filled: true,
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      taped = true;
                      _searchResult = _searchValue;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(defaultPadding * 0.75),
                    margin: const EdgeInsets.symmetric(
                        horizontal: defaultPadding / 2),
                    decoration: const BoxDecoration(
                      color: const Color(0xFFFFA113),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: SvgPicture.asset("assets/icons/Search.svg"),
                  ),
                ),
              ),
              onChanged: (value) {
                log('searche value :' + value);
                _searchValue = value;
              },
            ),
            trailing: IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () {
                setState(() {
                  controller.clear();
                  _searchResult = '';
                  clientFiltered = Allclients;
                });
              },
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: FutureBuilder<List<ClientModel>>(
              future: context.read<ClientsViewModel>().getAllClients(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data!.isNotEmpty) {
                    empty = false;

                    Allclients = snapshot.data!;
                    clientFiltered = snapshot.data!;
                    return Column(
                      children: [
                        DataTable2(
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
                                "Email",
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
                            snapshot.data!
                                .where((element) =>
                                    element.email!.contains(_searchResult))
                                .toList()
                                .length,
                            (index) => ClientDataRow(
                                snapshot.data!
                                    .where((element) =>
                                        element.email!.contains(_searchResult))
                                    .toList()[index],
                                context),
                          ),
                        ),
                      ],
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

DataRow ClientDataRow(ClientModel client, BuildContext context) {
  return DataRow(
    onSelectChanged: (selected) {
      if (selected!) {
        log('row-selected: ${client.id}');
        context.beamToNamed(DetailClient.path + "/" + client.id!,
            data: client,
            beamBackOnPop: true,
            popBeamLocationOnPop: true,
            replaceRouteInformation: true);
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
          client.email!,
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
