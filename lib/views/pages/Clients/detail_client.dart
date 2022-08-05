import 'package:flutter/material.dart';
import 'package:flutter_template/model/client_data.dart';
import 'package:flutter_template/model/client_model.dart';
import 'package:flutter_template/utils/size_config.dart';
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: FutureBuilder<ClientDataModel?>(
                  future: context
                      .read<ClientsViewModel>()
                      .getClientData(widget.client.refAssurance!),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return ListView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          CustomDetailWidget(
                            title: "Nom",
                            text: snapshot.data!.nomClient!,
                          ),
                          CustomDetailWidget(
                            title: "Prénom",
                            text: snapshot.data!.prenomClient!,
                          ),
                          CustomDetailWidget(
                            title: "Adresse",
                            text: snapshot.data!.addresseClient!,
                          ),
                          CustomDetailWidget(
                            title: "Assureur",
                            text: snapshot.data!.assureur!,
                          ),
                          CustomDetailWidget(
                            title: "Agence",
                            text: snapshot.data!.agence!,
                          ),
                          CustomDetailWidget(
                            title: "Numéro Contrat",
                            text: snapshot.data!.numContrat!,
                          ),
                          CustomDetailWidget(
                            title: "Date Début Contrat",
                            text: snapshot.data!.DBContrat!,
                          ),
                          CustomDetailWidget(
                            title: "Date Fin Contrat",
                            text: snapshot.data!.DFContrat!,
                          ),
                          CustomDetailWidget(
                            title: "Voiture ",
                            text: snapshot.data!.voiture!,
                          ),
                          CustomDetailWidget(
                            title: "Immatriculation",
                            text: snapshot.data!.immatriculation!,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
