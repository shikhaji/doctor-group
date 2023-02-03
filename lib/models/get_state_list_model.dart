import 'dart:convert';

GetStateListModel getStateListModelFromJson(String str) => GetStateListModel.fromJson(json.decode(str));

String getStateListModelToJson(GetStateListModel data) => json.encode(data.toJson());

class GetStateListModel {
  GetStateListModel({
    required this.status,
    required this.message,
  });

  int status;
  List<Message> message;

  factory GetStateListModel.fromJson(Map<String, dynamic> json) => GetStateListModel(
    status: json["status"],
    message: List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": List<dynamic>.from(message.map((x) => x.toJson())),
  };
}

class Message {
  Message({
    required this.stateId,
    required this.stateName,
    required this.countryId,
  });

  String stateId;
  String stateName;
  String countryId;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
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
