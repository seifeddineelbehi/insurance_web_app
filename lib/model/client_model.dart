import 'package:flutter_template/model/conducteur_model.dart';
import 'package:flutter_template/model/constat_model.dart';

class ClientModel {
  String? id;
  String? email;
  String? username;
  String? password;
  String? status;
  String? codeClient;
  String? refAssurance;
  String? delivreancePermis;
  int? numPermis;
  List<ConducteurModel>? conducteurs;
  List<ConstatModel>? constatsAccidents;
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
    this.constatsAccidents,
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
      );
}
