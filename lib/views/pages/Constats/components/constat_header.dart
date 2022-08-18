import 'package:flutter/material.dart';
import 'package:flutter_template/model/constat_model.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:flutter_template/views/pages/Constats/components/custom_constat_header_detail_widget.dart';
import 'package:flutter_template/views/pages/Constats/components/temoin_info_card.dart';
import '../../../../model/MyFiles.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/responsive.dart';
import 'constat_header_info_card.dart';

class constatHeader extends StatelessWidget {
  const constatHeader({
    Key? key,
    required this.constat,
  }) : super(key: key);
  final ConstatModel constat;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Constat",
          style: kBigTitleBlackBold,
        ),
        Responsive(
          mobile: ConstatInfoCardGridView(
              crossAxisCount: SizeConfig.screenWidth < 650 ? 2 : 4,
              childAspectRatio: SizeConfig.screenWidth < 650 ? 1.3 : 1,
              constat: constat),
          tablet: ConstatInfoCardGridView(constat: constat),
          desktop: ConstatInfoCardGridView(
            childAspectRatio: SizeConfig.screenWidth < 1400 ? 1.1 : 1.4,
            constat: constat,
          ),
        ),
      ],
    );
  }
}

class ConstatInfoCardGridView extends StatelessWidget {
  const ConstatInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
    required this.constat,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;
  final ConstatModel constat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomConstatHeaderDetailWidget(
                    title: 'Date de l\'accident',
                    text: constat.dateAccident.toString()),
              ),
              Expanded(
                child: CustomConstatHeaderDetailWidget(
                    title: 'Heure', text: constat.heureAccident.toString()),
              ),
              Expanded(
                child: CustomConstatHeaderDetailWidget(
                    title: 'Lieu', text: constat.lieuAccident.toString()),
              ),
              Expanded(
                child: CustomConstatHeaderDetailWidget(
                    title: 'Blessés même leger',
                    text: constat.blesse.toString()),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 2,
                child: CustomConstatHeaderDetailWidget(
                    title: 'Dégats materiels',
                    text: constat.degatMateriel.toString()),
              ),
              /*ConstatHeaderInfoCard(
                  title: 'Dégats materiels',
                  subTitle: constat.degatMateriel.toString(),
                  icon: Icons.car_rental),*/
              Expanded(
                flex: 4,
                child: CustomTemoinsHeaderDetailWidget(
                    title: 'Temoins', temoins: constat.temoins!),
              ),
            ],
          )
        ],
      ),
    );
  }
}

/*GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: demoMyFiles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => ConstatHeaderInfoCard(constat: constat),
    );*/
