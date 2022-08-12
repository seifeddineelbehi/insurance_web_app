import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/model/constat_model.dart';

import '../../../../model/MyFiles.dart';
import '../../../../utils/constants.dart';

class ConstatHeaderInfoCard extends StatelessWidget {
  const ConstatHeaderInfoCard({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.icon,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(defaultPadding),
        decoration: const BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: ListTile(
          title: SelectableText(title.toString()),
          subtitle: SelectableText(subTitle.toString()),
          leading: Icon(icon),
        ));
  }
}
