import 'dart:convert';

MobileVerifyModel mobileVerifyModelFromJson(String str) =>
    MobileVerifyModel.fromJson(json.decode(str));

String mobileVerifyModelToJson(MobileVerifyModel data) =>
    json.encode(data.toJson());

class MobileVerifyModel {
  MobileVerifyModel({
    required this.status,
    required this.message,
    required this.count,
  });

  int status;
  String message;
  int count;

  factory MobileVerifyModel.fromJson(Map<String, dynamic> json) =>
      MobileVerifyModel(
        status: json["status"],
        message: json["message"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "count": count,
      };
}
