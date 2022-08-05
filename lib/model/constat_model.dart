import 'package:flutter_template/model/temoin_model.dart';
import 'package:flutter_template/model/vehicule_model.dart';

class ConstatModel {
  String? id;
  String? status;
  String? dateAccident;
  String? heureAccident;
  String? lieuAccident;
  String? blesse;
  String? degatMateriel;
  String? croquis;
  List<TemoinModel>? temoins;
  VehiculeModel? vehiculeA;
  VehiculeModel? vehiculeB;
  DateTime? createdAt;
  DateTime? updatedAt;
  ConstatModel({
    this.id,
    this.status,
    this.dateAccident,
    this.heureAccident,
    this.lieuAccident,
    this.blesse,
    this.degatMateriel,
    this.croquis,
    this.temoins,
    this.vehiculeA,
    this.vehiculeB,
    this.createdAt,
    this.updatedAt,
  });

  factory ConstatModel.fromJson(Map<String, dynamic> json) => ConstatModel(
        id: json["_id"],
        status: json["status"],
        dateAccident: json["dateAccident"],
        heureAccident: json["heureAccident"],
        lieuAccident: json["lieuAccident"],
        blesse: json["blesse"],
        degatMateriel: json["degatMateriel"],
        croquis: json["croquis"],
        temoins: List<TemoinModel>.from(
            json["temoins"].map((x) => TemoinModel.fromJson(x))),
        vehiculeA: VehiculeModel.fromJson(json["VehiculeA"]),
        vehiculeB: VehiculeModel.fromJson(json["VehiculeB"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );
}
