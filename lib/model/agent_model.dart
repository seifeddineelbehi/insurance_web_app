class AgentModel {
  String? id;
  String? codeAgent;
  String? nom;
  String? prenom;
  String? CIN;
  String? tel;
  String? email;
  String? password;
  String? agence;
  String? assurance;
  List<String>? deviceIds;

  AgentModel(
      {this.id,
      this.codeAgent,
      this.nom,
      this.prenom,
      this.CIN,
      this.tel,
      this.email,
      this.password,
      this.agence,
      this.assurance,
      this.deviceIds});
  AgentModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    codeAgent = json["codeAgent"];
    nom = json["nom"];
    prenom = json["prenom"];
    CIN = json["CIN"];
    tel = json["tel"];
    email = json["email"];
    password = json["password"];
    agence = json["agence"];
    assurance = json["assurance"];
    deviceIds = List<String>.from(json["deviceIds"].map((x) => x));
  }
  Map<String, dynamic> toJSON() {
    return {
      "id": id,
      "codeAgent": codeAgent,
      "prenom": prenom,
      "CIN": CIN,
      "tel": tel,
      "email": email,
      "password": password,
      "agence": agence,
      "assurance": assurance,
      "deviceIds": deviceIds,
    };
  }
}
