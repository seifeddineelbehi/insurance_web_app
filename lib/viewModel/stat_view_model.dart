import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_template/Services/Incendies_service.dart';
import 'package:flutter_template/Services/brise_service.dart';
import 'package:flutter_template/Services/vols_service.dart';
import 'package:flutter_template/model/stat_data.dart';

import '../Services/constat_service.dart';

class StatViewModel with ChangeNotifier {
  StatData? _data;

  StatData get data => _data!;

  set setData(StatData value) {
    _data = value;
  }

  getAllDataLength() async {
    _data = StatData();
    Map<String, dynamic> mapConstat =
        (await ConstatService.getConstatLength()) as Map<String, dynamic>;

    if (mapConstat.isNotEmpty) {
      _data?.materielLentgth = mapConstat["Length"] as int;
      _data?.materielNonTraite = mapConstat["NonTraiterLength"] as int;
      _data?.materielTraite = mapConstat["TerminerLength"] as int;
      _data?.materielRejeter = mapConstat["RejeterLength"] as int;
      log(data.toString());
    } else {
      _data?.materielLentgth = 0;
      _data?.materielNonTraite = 0;
      _data?.materielTraite = 0;
      _data?.materielRejeter = 0;
    }

    Map<String, dynamic> mapVol =
        (await VolService.getLength()) as Map<String, dynamic>;

    if (mapVol.isNotEmpty) {
      _data?.volLentgth = mapVol["Length"] as int;
      _data?.volNonTraite = mapVol["NonTraiterLength"] as int;
      _data?.volTraite = mapVol["TerminerLength"] as int;
      _data?.volRejeter = mapVol["RejeterLength"] as int;
    } else {
      log('Empty Vol');
      _data?.volLentgth = 0;
      _data?.volNonTraite = 0;
      _data?.volTraite = 0;
      _data?.volRejeter = 0;
    }

    Map<String, dynamic> mapBrise =
        (await BriseService.getLength()) as Map<String, dynamic>;

    if (mapBrise.isNotEmpty) {
      _data?.brisLentgth = mapBrise["Length"] as int;
      _data?.brisNonTraite = mapBrise["NonTraiterLength"] as int;
      _data?.brisTraite = mapBrise["TerminerLength"] as int;
      _data?.brisRejeter = mapBrise["RejeterLength"] as int;
    } else {
      log('Empty Bris');
      _data?.brisLentgth = 0;
      _data?.brisNonTraite = 0;
      _data?.brisTraite = 0;
      _data?.brisRejeter = 0;
    }

    Map<String, dynamic> mapIncendie =
        (await IncendiesService.getLength()) as Map<String, dynamic>;

    if (mapIncendie.isNotEmpty) {
      _data?.incendieLentgth = mapIncendie["Length"] as int;
      _data?.incendieNonTraite = mapIncendie["NonTraiterLength"] as int;
      _data?.incendieTraite = mapIncendie["TerminerLength"] as int;
      _data?.incendieRejeter = mapIncendie["RejeterLength"] as int;
    } else {
      log('Empty constat');
      _data?.incendieLentgth = 0;
      _data?.incendieNonTraite = 0;
      _data?.incendieTraite = 0;
      _data?.incendieRejeter = 0;
    }
  }

  Future<Map<String, dynamic>> getAllConstatsLength() async {
    Map<String, dynamic> map = {};
    map = (await ConstatService.getConstatLength()) as Map<String, dynamic>;
    if (map.isNotEmpty) {
      return map;
    } else {
      log('aaaaaaa');
      Map<String, dynamic> map = {};
      return map;
    }
  }

  Future<Map<String, dynamic>> getAllVolsLength() async {
    Map<String, dynamic> map = {};
    map = (await VolService.getLength()) as Map<String, dynamic>;
    if (map.isNotEmpty) {
      return map;
    } else {
      log('aaaaaaa');
      Map<String, dynamic> map = {};
      return map;
    }
  }

  Future<Map<String, dynamic>> getAllBrisesLength() async {
    Map<String, dynamic> map = {};
    map = (await BriseService.getLength()) as Map<String, dynamic>;
    if (map.isNotEmpty) {
      return map;
    } else {
      log('aaaaaaa');
      Map<String, dynamic> map = {};
      return map;
    }
  }

  Future<Map<String, dynamic>> getAllIncendiesLength() async {
    Map<String, dynamic> map = {};
    map = (await IncendiesService.getLength()) as Map<String, dynamic>;
    if (map.isNotEmpty) {
      return map;
    } else {
      log('aaaaaaa');
      Map<String, dynamic> map = {};
      return map;
    }
  }
}
