import 'dart:convert';
import 'dart:developer';

import 'package:flutter_template/model/brise_glace_model.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:flutter_template/Services/shared_preferences_service.dart';
import 'package:flutter_template/model/vol_model.dart';

import '../utils/apis.dart';

class BriseService {
  final PrefService _prefService = PrefService();

  static Future<Object?> getAllNonTraite() async {
    var token = "";
    await BriseService()._prefService.readToken("token").then((value) {
      token = value.toString();
    });

    List<BriseGlaceModel> data = [];
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
      'Authorization': token.toString()
    };
    Uri uri = Uri.parse(localURL + AllBrisesNonTraite);

    try {
      var response = await http.get(uri, headers: requestHeaders);
      log('response.body : ' + response.body);
      log('response.status : ' + response.statusCode.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> res = json.decode(response.body);

        if (res["list"] != null && res["list"].isNotEmpty) {
          res["list"].forEach((e) {
            BriseGlaceModel vol = BriseGlaceModel.fromJson(e);
            data.add(vol);
          });
          return data;
        }
      } else {
        if (response.body.toString() == "Unauthorized") {
          return data;
        }
      }
    } catch (exception) {
      return false;
    }
  }

  static Future<Object?> getAllTraite() async {
    var token = "";
    await BriseService()._prefService.readToken("token").then((value) {
      token = value.toString();
    });

    List<BriseGlaceModel> data = [];
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
      'Authorization': token.toString()
    };
    Uri uri = Uri.parse(localURL + AllBrisesTraite);

    try {
      log('dkhaaal : ');
      var response = await http.get(uri, headers: requestHeaders);
      log('response.body : ' + response.body);
      log('response.status : ' + response.statusCode.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> res = json.decode(response.body);

        if (res["list"] != null && res["list"].isNotEmpty) {
          res["list"].forEach((e) {
            BriseGlaceModel vols = BriseGlaceModel.fromJson(e);
            data.add(vols);
          });
          return data;
        }
      } else {
        if (response.body.toString() == "Unauthorized") {
          return data;
        }
      }
    } catch (exception) {
      return false;
    }
  }

  static Future<Object?> getAllRejete() async {
    var token = "";
    await BriseService()._prefService.readToken("token").then((value) {
      token = value.toString();
    });

    List<BriseGlaceModel> data = [];
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
      'Authorization': token.toString()
    };
    Uri uri = Uri.parse(localURL + AllBrisesRejete);

    try {
      var response = await http.get(uri, headers: requestHeaders);
      log('response.body : ' + response.body);
      log('response.status : ' + response.statusCode.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> res = json.decode(response.body);

        if (res["list"] != null && res["list"].isNotEmpty) {
          res["list"].forEach((e) {
            BriseGlaceModel vols = BriseGlaceModel.fromJson(e);
            data.add(vols);
          });
          return data;
        }
      } else {
        if (response.body.toString() == "Unauthorized") {
          return data;
        }
      }
    } catch (exception) {
      return false;
    }
  }

  static Future<Object?> getLength() async {
    var token = "";
    await BriseService()._prefService.readToken("token").then((value) {
      token = value.toString();
    });
    Map<String, dynamic> data = {};
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
      'Authorization': token.toString()
    };

    Uri uri = Uri.parse(localURL + lengthBriseApi);

    try {
      var response = await http.get(uri, headers: requestHeaders);
      log('response.body : ' + response.body);
      log('response.status : ' + response.statusCode.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> res = json.decode(response.body);

        if (res["success"] == true) {
          data["Length"] = res["Length"];
          data["TerminerLength"] = res["Terminer"];
          data["RejeterLength"] = res["Rejeter"];
          data["NonTraiterLength"] = res["NonTraiter"];

          return data;
        }
      } else {
        if (response.body.toString() == "Unauthorized") {
          return data;
        }
      }
    } catch (exception) {
      return false;
    }
  }

  static Future<Object?> update(String id, String response) async {
    var token = "";
    await BriseService()._prefService.readToken("token").then((value) {
      token = value.toString();
    });
    Map<String, dynamic> data = {};
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
      'Authorization': token.toString()
    };

    Uri uri = Uri.parse(localURL + updateBriseApi);
    var body = {
      "idBriseGlace": id,
      "response": response,
    };
    try {
      var response =
          await http.put(uri, headers: requestHeaders, body: jsonEncode(body));
      log('response.body : ' + response.body);
      log('response.status : ' + response.statusCode.toString());
      if (response.statusCode == 200) {
        var res = json.decode(response.body);

        return res["success"];
      }
      if (response.body == 'Unauthorized') {
        return false;
      }
      if (response.statusCode != 200) {
        var res = json.decode(response.body);
        return res['message'];
      }
    } catch (exception) {
      return false;
    }
  }
}
