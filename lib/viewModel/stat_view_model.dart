import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_template/Services/Incendies_service.dart';
import 'package:flutter_template/Services/brise_service.dart';
import 'package:flutter_template/Services/vols_service.dart';

import '../Services/constat_service.dart';

class StatViewModel with ChangeNotifier {
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
