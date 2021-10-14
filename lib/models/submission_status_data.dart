import 'dart:convert';

SubStatusData subStatusDataFromJson(String str) =>
    SubStatusData.fromJson(json.decode(str));

String subStatusDataToJson(SubStatusData data) => json.encode(data.toJson());

class SubStatusData {
  SubStatusData({
    this.ac,
    this.ce,
    this.mle,
    this.ptl,
    this.re,
    this.tle,
    this.wa,
  });

  int? ac;
  int? ce;
  int? mle;
  int? ptl;
  int? re;
  int? tle;
  int? wa;

  factory SubStatusData.fromJson(Map<String, dynamic> json) => SubStatusData(
        ac: json["ac"],
        ce: json["ce"],
        mle: json["mle"],
        ptl: json["ptl"],
        re: json["re"],
        tle: json["tle"],
        wa: json["wa"],
      );

  Map<String, dynamic> toJson() => {
        "ac": ac,
        "ce": ce,
        "mle": mle,
        "ptl": ptl,
        "re": re,
        "tle": tle,
        "wa": wa,
      };
}
