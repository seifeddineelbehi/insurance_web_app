import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_template/viewModel/stat_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../utils/constants.dart';
import '../../../../viewModel/home_view_model.dart';
import '../../dashboard/components/chart.dart';
import '../../dashboard/components/storage_info_card.dart';

class ConstatsStat extends StatefulWidget {
  const ConstatsStat({Key? key}) : super(key: key);

  @override
  _ConstatsStatState createState() => _ConstatsStatState();
}

class _ConstatsStatState extends State<ConstatsStat> {
  Map<String, dynamic> map = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: kPageColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: FutureBuilder<Map<String, dynamic>>(
        future: context.read<StatViewModel>().getAllConstatsLength(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            map = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Constat Statestiques",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: defaultPadding),
                Chart(map: snapshot.data!),
                StorageInfoCard(
                  svgSrc: "assets/icons/Documents.svg",
                  title: "Constat non traité",
                  amountOfFiles: snapshot.data!["NonTraiterLength"].toString(),
                  numOfFiles: 1328,
                ),
                StorageInfoCard(
                  svgSrc: "assets/icons/Documents.svg",
                  title: "Constat traité",
                  amountOfFiles: snapshot.data!["TerminerLength"].toString(),
                  numOfFiles: 1328,
                ),
                StorageInfoCard(
                  svgSrc: "assets/icons/Documents.svg",
                  title: "Constat rejeté",
                  amountOfFiles: snapshot.data!["RejeterLength"].toString(),
                  numOfFiles: 1328,
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
    );
  }
}
