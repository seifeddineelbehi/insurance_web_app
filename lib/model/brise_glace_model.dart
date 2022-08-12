class BriseGlaceModel {
  String? id;
  String? date;
  String? codeClient;
  String? status;
  String? image;

  BriseGlaceModel(
      {this.id, this.date, this.codeClient, this.status, this.image});

  factory BriseGlaceModel.fromJson(Map<String, dynamic> json) =>
      BriseGlaceModel(
          id: json["_id"],
          date: json["date"],
          codeClient: json["codeClient"],
          status: json["status"],
          image: json["image"]);
}
