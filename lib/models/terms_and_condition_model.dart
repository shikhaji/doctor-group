import 'dart:convert';

TermsAndConditionModel termsAndConditionModelFromJson(String str) =>
    TermsAndConditionModel.fromJson(json.decode(str));

String termsAndConditionModelToJson(TermsAndConditionModel data) =>
    json.encode(data.toJson());

class TermsAndConditionModel {
  TermsAndConditionModel({
    required this.status,
    required this.message,
  });

  int status;
  Message message;

  factory TermsAndConditionModel.fromJson(Map<String, dynamic> json) =>
      TermsAndConditionModel(
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
    required this.orgTermsConditions,
  });

  String orgTermsConditions;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        orgTermsConditions: json["ORG_TERMS_CONDITIONS"],
      );

  Map<String, dynamic> toJson() => {
        "ORG_TERMS_CONDITIONS": orgTermsConditions,
      };
}
