import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:flutter_template/Services/shared_preferences_service.dart';
import 'package:flutter_template/model/vol_model.dart';

import '../utils/apis.dart';

class VolService {
  final PrefService _prefService = PrefService();

  static Future<Object?> getAllVolsNonTraite() async {
    var token = "";
    await VolService()._prefService.readCache("token").then((value) {
      token = value.toString();
    });

    List<VolModel> data = [];
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
      'Authorization': token.toString()
    };
    Uri uri = Uri.parse(localURL + AllVolsNonTraite);

    try {
      var response = await http.get(uri, headers: requestHeaders);
      log('response.body : ' + response.body);
      log('response.status : ' + response.statusCode.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> res = json.decode(response.body);

        if (res["list"] != null && res["list"].isNotEmpty) {
          res["list"].forEach((e) {
            VolModel vol = VolModel.fromJson(e);
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

  static Future<Object?> getAllVolsTraite() async {
    var token = "";
    await VolService()._prefService.readCache("token").then((value) {
      token = value.toString();
    });

    List<VolModel> data = [];
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
      'Authorization': token.toString()
    };
    Uri uri = Uri.parse(localURL + AllVolsTraite);

    try {
      log('dkhaaal : ');
      var response = await http.get(uri, headers: requestHeaders);
      log('response.body : ' + response.body);
      log('response.status : ' + response.statusCode.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> res = json.decode(response.body);

        if (res["list"] != null && res["list"].isNotEmpty) {
          res["list"].forEach((e) {
            VolModel vols = VolModel.fromJson(e);
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

  static Future<Object?> getAllVolsRejete() async {
    var token = "";
    await VolService()._prefService.readCache("token").then((value) {
      token = value.toString();
    });

    List<VolModel> data = [];
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
      'Authorization': token.toString()
    };
    Uri uri = Uri.parse(localURL + AllVolsRejete);

    try {
      var response = await http.get(uri, headers: requestHeaders);
      log('response.body : ' + response.body);
      log('response.status : ' + response.statusCode.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> res = json.decode(response.body);

        if (res["list"] != null && res["list"].isNotEmpty) {
          res["list"].forEach((e) {
            VolModel vols = VolModel.fromJson(e);
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
    await VolService()._prefService.readCache("token").then((value) {
      token = value.toString();
    });
    Map<String, dynamic> data = {};
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
      'Authorization': token.toString()
    };

    Uri uri = Uri.parse(localURL + lengthVolsApi);

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

  static Future<Object?> updateVols(String idVol, String response) async {
    var token = "";
    await VolService()._prefService.readCache("token").then((value) {
      token = value.toString();
    });
    Map<String, dynamic> data = {};
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
      'Authorization': token.toString()
    };

    Uri uri = Uri.parse(localURL + updateVolsApi);
    var body = {
      "idVol": idVol,
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
