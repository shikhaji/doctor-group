import 'dart:convert';

AboutUsModel aboutUsModelFromJson(String str) =>
    AboutUsModel.fromJson(json.decode(str));

String aboutUsModelToJson(AboutUsModel data) => json.encode(data.toJson());

class AboutUsModel {
  AboutUsModel({
    required this.status,
    required this.message,
  });

  int status;
  Message message;

  factory AboutUsModel.fromJson(Map<String, dynamic> json) => AboutUsModel(
        status: json["status"],
        message: Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message.toJson(),
      };
}

class Message {
  Message({
    required this.aboutUs,
  });

  String aboutUs;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        aboutUs: json["ABOUT_US"],
      );

  Map<String, dynamic> toJson() => {
        "ABOUT_US": aboutUs,
      };
}
