import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter_template/Services/shared_preferences_service.dart';
import 'package:flutter_template/Services/shared_service.dart';

import '../model/constat_model.dart';
import '../utils/apis.dart';

class ConstatService {
  final PrefService _prefService = PrefService();
  static Future<Object?> getAllConstatNonTraite() async {
    var token = "";
    await ConstatService()._prefService.readToken("token").then((value) {
      token = value.toString();
    });

    List<ConstatModel> data = [];
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
      'Authorization': token.toString()
    };
    Uri uri = Uri.parse(localURL + AllConstatNonTraite);

    try {
      var response = await http.get(uri, headers: requestHeaders);
      log('response.body : ' + response.body);
      log('response.status : ' + response.statusCode.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> res = json.decode(response.body);

        if (res["list"] != null && res["list"].isNotEmpty) {
          res["list"].forEach((e) {
            ConstatModel constat = ConstatModel.fromJson(e);
            data.add(constat);
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

  static Future<Object?> getAllConstatTraite() async {
    var token = "";
    await ConstatService()._prefService.readToken("token").then((value) {
      token = value.toString();
    });

    List<ConstatModel> data = [];
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
      'Authorization': token.toString()
    };
    Uri uri = Uri.parse(localURL + AllConstatTraite);

    try {
      log('dkhaaal : ');
      var response = await http.get(uri, headers: requestHeaders);
      log('response.body : ' + response.body);
      log('response.status : ' + response.statusCode.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> res = json.decode(response.body);

        if (res["list"] != null && res["list"].isNotEmpty) {
          res["list"].forEach((e) {
            ConstatModel constat = ConstatModel.fromJson(e);
            data.add(constat);
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

  static Future<Object?> getAllConstatRejete() async {
    var token = "";
    await ConstatService()._prefService.readToken("token").then((value) {
      token = value.toString();
    });

    List<ConstatModel> data = [];
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
      'Authorization': token.toString()
    };
    Uri uri = Uri.parse(localURL + AllConstatRejete);

    try {
      var response = await http.get(uri, headers: requestHeaders);
      log('response.body : ' + response.body);
      log('response.status : ' + response.statusCode.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> res = json.decode(response.body);

        if (res["list"] != null && res["list"].isNotEmpty) {
          res["list"].forEach((e) {
            ConstatModel constat = ConstatModel.fromJson(e);
            data.add(constat);
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

  static Future<Object?> getConstatLength() async {
    var token = "";
    await ConstatService()._prefService.readToken("token").then((value) {
      token = value.toString();
    });
    Map<String, dynamic> data = {};
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
      'Authorization': token.toString()
    };

    Uri uri = Uri.parse(localURL + lengthConstat);

    try {
      var response = await http.get(uri, headers: requestHeaders);
      log('response.body : ' + response.body);
      log('response.status : ' + response.statusCode.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> res = json.decode(response.body);

        if (res["success"] == true) {
          data["Length"] = res["ConstatLength"];
          data["TerminerLength"] = res["TerminerLength"];
          data["RejeterLength"] = res["RejeterLength"];
          data["NonTraiterLength"] = res["NonTraiterLength"];

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

  static Future<Object?> updateConstat(
      String idAccident, String response) async {
    var token = "";
    await ConstatService()._prefService.readToken("token").then((value) {
      token = value.toString();
    });
    Map<String, dynamic> data = {};
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
      'Authorization': token.toString()
    };

    Uri uri = Uri.parse(localURL + updateConstatAccident);
    var body = {
      "idAccident": idAccident,
      "response": response,
    };
    try {
      var response =
          await http.put(uri, headers: requestHeaders, body: jsonEncode(body));
      log('response.body : ' + response.body);
      log('response.status : ' + response.statusCode.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> res = json.decode(response.body);

        if (res["success"] == true) {
          return true;
        }
      } else {
        if (response.body.toString() == "Unauthorized") {
          return false;
        }
      }
    } catch (exception) {
      return false;
    }
  }
}
