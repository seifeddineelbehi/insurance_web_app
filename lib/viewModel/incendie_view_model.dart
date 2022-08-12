import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_template/Services/Incendies_service.dart';
import 'package:flutter_template/Services/vols_service.dart';
import 'package:flutter_template/model/incendies_model.dart';
import 'package:flutter_template/model/vol_model.dart';

class IncendiesViewModel with ChangeNotifier {
  List<IncendiesModel> _allIncendiesNontraite = [];

  setAllIncendiessNonTraite(List<IncendiesModel> incendies) {
    _allIncendiesNontraite = incendies;
  }

// ignore: non_constant_identifier_names
  List<IncendiesModel> get AllIncendiesNontraite {
    return [..._allIncendiesNontraite];
  }

  Future<List<IncendiesModel>> getAllNonTraite() async {
    var list = await IncendiesService.getAllNonTraite();
    if (list is List<IncendiesModel>) {
      setAllIncendiessNonTraite(list);
      return list;
    } else {
      log('aaaaaaa');
      List<IncendiesModel> list = [];
      return list;
    }
  }

  Future<List<IncendiesModel>> getAllTraite() async {
    var list = await IncendiesService.getAllTraite();
    if (list is List<IncendiesModel>) {
      //setAllConstatNonTraite(constats);
      return list;
    } else {
      log('aaaaaaa');
      List<IncendiesModel> list = [];
      return list;
    }
  }

  Future<List<IncendiesModel>> getAllRejete() async {
    var list = await IncendiesService.getAllRejete();
    if (list is List<IncendiesModel>) {
      //setAllConstatNonTraite(constats);
      return list;
    } else {
      log('aaaaaaa');
      List<IncendiesModel> list = [];
      return list;
    }
  }

  update(String id, String response) async {
    var res = await IncendiesService.update(id, response);
    return res;
  }
}
