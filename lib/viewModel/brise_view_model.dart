import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_template/Services/Incendies_service.dart';
import 'package:flutter_template/Services/brise_service.dart';
import 'package:flutter_template/Services/vols_service.dart';
import 'package:flutter_template/model/brise_glace_model.dart';
import 'package:flutter_template/model/incendies_model.dart';
import 'package:flutter_template/model/vol_model.dart';

class BriseViewModel with ChangeNotifier {
  List<BriseGlaceModel> _allBrisesNontraite = [];

  setAllBrisessNonTraite(List<BriseGlaceModel> Brises) {
    _allBrisesNontraite = Brises;
  }

// ignore: non_constant_identifier_names
  List<BriseGlaceModel> get AllBrisesNontraite {
    return [..._allBrisesNontraite];
  }

  Future<List<BriseGlaceModel>> getAllNonTraite() async {
    var list = await BriseService.getAllNonTraite();
    if (list is List<BriseGlaceModel>) {
      setAllBrisessNonTraite(list);
      return list;
    } else {
      log('aaaaaaa');
      List<BriseGlaceModel> list = [];
      return list;
    }
  }

  Future<List<BriseGlaceModel>> getAllTraite() async {
    var list = await BriseService.getAllTraite();
    if (list is List<BriseGlaceModel>) {
      //setAllConstatNonTraite(constats);
      return list;
    } else {
      log('aaaaaaa');
      List<BriseGlaceModel> list = [];
      return list;
    }
  }

  Future<List<BriseGlaceModel>> getAllRejete() async {
    var list = await BriseService.getAllRejete();
    if (list is List<BriseGlaceModel>) {
      //setAllConstatNonTraite(constats);
      return list;
    } else {
      log('aaaaaaa');
      List<BriseGlaceModel> list = [];
      return list;
    }
  }

  updateBrise(String id, String response) async {
    var res = await BriseService.update(id, response);
    log("res : " + res.toString());
    return res;
  }
}
