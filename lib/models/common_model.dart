import 'dart:convert';

CommonModel commonModelFromJson(String str) =>
    CommonModel.fromJson(json.decode(str));

String commonModelToJson(CommonModel data) => json.encode(data.toJson());

class CommonModel {
  CommonModel({
    this.status,
    this.message,
  });

  int? status;
  String? message;

  factory CommonModel.fromJson(Map<String, dynamic> json) => CommonModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
