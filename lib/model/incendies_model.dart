class IncendiesModel {
  String? id;
  String? date;
  String? codeClient;
  String? status;
  String? observation;

  IncendiesModel(
      {this.id, this.date, this.codeClient, this.status, this.observation});

  factory IncendiesModel.fromJson(Map<String, dynamic> json) => IncendiesModel(
      id: json["_id"],
      date: json["date"],
      codeClient: json["codeClient"],
      status: json["status"],
      observation: json["observation"]);
}
