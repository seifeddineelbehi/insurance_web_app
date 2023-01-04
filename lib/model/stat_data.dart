class StatData {
  int? materielLentgth;
  int? materielNonTraite;
  int? materielTraite;
  int? materielRejeter;

  int? incendieLentgth;
  int? incendieNonTraite;
  int? incendieTraite;
  int? incendieRejeter;

  int? volLentgth;
  int? volNonTraite;
  int? volTraite;
  int? volRejeter;

  int? brisLentgth;
  int? brisNonTraite;
  int? brisTraite;
  int? brisRejeter;

  StatData();

  /*factory StatData.fromJson(Map<String, dynamic> json) => StatData(
        brisLentgth: json["_id"],
        brisNonTraite: json["NonTraiterLength"],
        brisRejeter: json["RejeterLength"],
        brisTraite: json["TerminerLength"],
        incendieLentgth: json["tel"],
        incendieNonTraite: json["tel"],
        incendieRejeter: json["tel"],
        incendieTraite: json["tel"],
        materielLentgth: json["tel"],
        materielNonTraite: json["tel"],
        materielRejeter: json["tel"],
        materielTraite: json["tel"],
        volLentgth: json["tel"],
        volNonTraite: json["tel"],
        volRejeter: json["tel"],
        volTraite: json["tel"],
      );*/
}
