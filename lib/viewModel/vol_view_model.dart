import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_template/Services/vols_service.dart';
import 'package:flutter_template/model/vol_model.dart';

class VolViewModel with ChangeNotifier {
  List<VolModel> _allVolsNontraite = [];

  setAllVolsNonTraite(List<VolModel> vols) {
    _allVolsNontraite = vols;
  }

// ignore: non_constant_identifier_names
  List<VolModel> get AllVolsNonTraite {
    return [..._allVolsNontraite];
  }

  Future<List<VolModel>> getAllVolsNonTraite() async {
    var vols = await VolService.getAllVolsNonTraite();
    if (vols is List<VolModel>) {
      setAllVolsNonTraite(vols);
      return vols;
    } else {
      log('aaaaaaa');
      List<VolModel> vols = [];
      return vols;
    }
  }

  Future<List<VolModel>> getAllVolsTraite() async {
    var constats = await VolService.getAllVolsTraite();
    if (constats is List<VolModel>) {
      //setAllConstatNonTraite(constats);
      return constats;
    } else {
      log('aaaaaaa');
      List<VolModel> constat = [];
      return constat;
    }
  }

  Future<List<VolModel>> getAllVolsRejete() async {
    var constats = await VolService.getAllVolsRejete();
    if (constats is List<VolModel>) {
      //setAllConstatNonTraite(constats);
      return constats;
    } else {
      log('aaaaaaa');
      List<VolModel> constat = [];
      return constat;
    }
  }

  updateVol(String idVol, String response) async {
    var res = await VolService.updateVols(idVol, response);
    return res;
  }
}
