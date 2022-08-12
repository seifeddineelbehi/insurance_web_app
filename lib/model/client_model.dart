import 'package:flutter_template/model/conducteur_model.dart';
import 'package:flutter_template/model/constat_model.dart';
import 'package:flutter_template/model/vol_model.dart';

import 'brise_glace_model.dart';
import 'incendies_model.dart';

class ClientModel {
  String? id;
  String? email;
  String? username;
  String? password;
  String? status;
  String? codeClient;
  String? refAssurance;
  String? numContrat;
  String? delivreancePermis;
  int? numPermis;
  List<ConducteurModel>? conducteurs;
  List<ConstatModel>? constatsAccidents;
  List<VolModel>? vols;
  List<IncendiesModel>? incendies;
  List<BriseGlaceModel>? briseGlace;
  DateTime? createdAt;
  DateTime? updatedAt;

  ClientModel({
    this.id,
    this.email,
    this.username,
    this.password,
    this.status,
    this.codeClient,
    this.refAssurance,
    this.conducteurs,
    this.delivreancePermis,
    this.numPermis,
    this.numContrat,
    this.constatsAccidents,
    this.vols,
    this.incendies,
    this.briseGlace,
    this.createdAt,
    this.updatedAt,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
        id: json["_id"],
        email: json["email"],
        username: json["username"],
        status: json["status"],
        delivreancePermis: json["delivreancePermis"],
        numPermis: json["numPermis"],
        codeClient: json["codeClient"],
        refAssurance: json["refAssurance"],
        conducteurs: List<ConducteurModel>.from(
            json["conducteurs"].map((x) => ConducteurModel.fromJson(x))),
        constatsAccidents: List<ConstatModel>.from(
            json["constatsAccidents"].map((x) => ConstatModel.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        vols: List<VolModel>.from(
            json["vols"].map((x) => ConstatModel.fromJson(x))),
        incendies: List<IncendiesModel>.from(
            json["incendies"].map((x) => ConstatModel.fromJson(x))),
        briseGlace: List<BriseGlaceModel>.from(
            json["briseGlace"].map((x) => ConstatModel.fromJson(x))),
      );
}
