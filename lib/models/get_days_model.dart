import 'dart:convert';

GetDaysModel getDaysModelFromJson(String str) =>
    GetDaysModel.fromJson(json.decode(str));

String getDaysModelToJson(GetDaysModel data) => json.encode(data.toJson());

class GetDaysModel {
  GetDaysModel({
    required this.status,
    required this.data,
  });

  int status;
  List<GetDaysList> data;

  factory GetDaysModel.fromJson(Map<String, dynamic> json) => GetDaysModel(
        status: json["status"],
        data: List<GetDaysList>.from(
            json["data"].map((x) => GetDaysList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GetDaysList {
  GetDaysList({
    required this.dlId,
    required this.dlTt,
    required this.dlName,
  });

  String dlId;
  DateTime dlTt;
  String dlName;

  factory GetDaysList.fromJson(Map<String, dynamic> json) => GetDaysList(
        dlId: json["DL_ID"],
        dlTt: DateTime.parse(json["DL_TT"]),
        dlName: json["DL_NAME"],
      );

  Map<String, dynamic> toJson() => {
        "DL_ID": dlId,
        "DL_TT": dlTt.toIso8601String(),
        "DL_NAME": dlName,
      };
}
