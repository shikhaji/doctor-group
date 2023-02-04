// To parse this JSON data, do
//
//     final privacyPolicyModel = privacyPolicyModelFromJson(jsonString);

import 'dart:convert';

PrivacyPolicyModel privacyPolicyModelFromJson(String str) => PrivacyPolicyModel.fromJson(json.decode(str));

String privacyPolicyModelToJson(PrivacyPolicyModel data) => json.encode(data.toJson());

class PrivacyPolicyModel {
  PrivacyPolicyModel({
    this.status,
   this.message,
  });

  int? status;
  Message? message;

  factory PrivacyPolicyModel.fromJson(Map<String, dynamic> json) => PrivacyPolicyModel(
    status: json["status"],
    message: Message.fromJson(json["message"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message!.toJson(),
  };
}

class Message {
  Message({
    required this.orgPrivacyPolicy,
  });

  String orgPrivacyPolicy;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    orgPrivacyPolicy: json["ORG_PRIVACY_POLICY"],
  );

  Map<String, dynamic> toJson() => {
    "ORG_PRIVACY_POLICY": orgPrivacyPolicy,
  };
}
