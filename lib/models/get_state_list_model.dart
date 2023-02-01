import 'dart:convert';

List<GetStateListModel> getStateListModelFromJson(String str) =>
    List<GetStateListModel>.from(
        json.decode(str).map((x) => GetStateListModel.fromJson(x)));

String getStateListModelToJson(List<GetStateListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetStateListModel {
  GetStateListModel({
    required this.stateId,
    required this.stateName,
    required this.countryId,
  });

  String stateId;
  String stateName;
  String countryId;

  factory GetStateListModel.fromJson(Map<String, dynamic> json) =>
      GetStateListModel(
        stateId: json["STATE_ID"],
        stateName: json["STATE_NAME"],
        countryId: json["COUNTRY_ID"],
      );

  Map<String, dynamic> toJson() => {
        "STATE_ID": stateId,
        "STATE_NAME": stateName,
        "COUNTRY_ID": countryId,
      };
}
