import 'dart:convert';

GetCityListModel getCityListModelFromJson(String str) =>
    GetCityListModel.fromJson(json.decode(str));

String getCityListModelToJson(GetCityListModel data) =>
    json.encode(data.toJson());

class GetCityListModel {
  GetCityListModel({
    required this.status,
    required this.message,
  });

  int status;
  List<Message> message;

  factory GetCityListModel.fromJson(Map<String, dynamic> json) =>
      GetCityListModel(
        status: json["status"],
        message:
            List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": List<dynamic>.from(message.map((x) => x.toJson())),
      };
}

class Message {
  Message({
    required this.districtId,
    required this.districtName,
    required this.stateId,
  });

  String districtId;
  String districtName;
  String stateId;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        districtId: json["DISTRICT_ID"],
        districtName: json["DISTRICT_NAME"],
        stateId: json["STATE_ID"],
      );

  Map<String, dynamic> toJson() => {
        "DISTRICT_ID": districtId,
        "DISTRICT_NAME": districtName,
        "STATE_ID": stateId,
      };
}
