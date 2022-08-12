import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';

class Chart extends StatelessWidget {
  const Chart({
    Key? key,
    required this.map,
  }) : super(key: key);
  final Map<String, dynamic> map;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: _getpaiChartSelectionDatas(map),
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: defaultPadding),
                Text(
                  map["Length"].toString(),
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

_getpaiChartSelectionDatas(Map<String, dynamic> map) {
  List<PieChartSectionData> paiChartSelectionDatas = [
    PieChartSectionData(
      color: Color(0xFFFFCF26),
      value: double.parse(map["NonTraiterLength"].toString()),
      showTitle: false,
      radius: 25,
    ),
    PieChartSectionData(
      color: primaryColor,
      value: double.parse(map["TerminerLength"].toString()),
      showTitle: false,
      radius: 25,
    ),
    PieChartSectionData(
      color: Color(0xFFEE2727),
      value: double.parse(map["RejeterLength"].toString()),
      showTitle: false,
      radius: 25,
    )
  ];

  return paiChartSelectionDatas;
}

List<PieChartSectionData> paiChartSelectionDatas = [
  PieChartSectionData(
    color: primaryColor,
    value: 25,
    showTitle: false,
    radius: 25,
  ),
  PieChartSectionData(
    color: Color(0xFF26E5FF),
    value: 20,
    showTitle: false,
    radius: 22,
  ),
  PieChartSectionData(
    color: Color(0xFFFFCF26),
    value: 10,
    showTitle: false,
    radius: 19,
  ),
  PieChartSectionData(
    color: Color(0xFFEE2727),
    value: 15,
    showTitle: false,
    radius: 16,
  ),
  PieChartSectionData(
    color: primaryColor.withOpacity(0.1),
    value: 25,
    showTitle: false,
    radius: 13,
  ),
];
