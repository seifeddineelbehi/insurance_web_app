class TemoinModel {
  String? adress;
  String? nom;
  String? appartenance;
  int? tel;
  String? id;

  TemoinModel({
    this.adress,
    this.nom,
    this.appartenance,
    this.tel,
    this.id,
  });

  factory TemoinModel.fromJson(Map<String, dynamic> json) => TemoinModel(
        id: json["_id"],
        adress: json["adress"],
        nom: json["nom"],
        appartenance: json["appartenance"],
        tel: json["tel"],
      );
}
