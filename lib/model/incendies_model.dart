class IncendiesModel {
  String? id;
  String? date;
  String? codeClient;
  String? status;
  String? observation;
  String? image;

  IncendiesModel(
      {this.id,
      this.date,
      this.codeClient,
      this.status,
      this.observation,
      this.image});

  factory IncendiesModel.fromJson(Map<String, dynamic> json) => IncendiesModel(
      id: json["_id"],
      date: json["date"],
      codeClient: json["codeClient"],
      status: json["status"],
      image: json["image"],
      observation: json["observation"]);
}
