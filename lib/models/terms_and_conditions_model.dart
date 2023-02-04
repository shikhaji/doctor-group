import 'dart:convert';

TermsAndConditionsModel termsAndConditionsModelFromJson(String str) => TermsAndConditionsModel.fromJson(json.decode(str));

String termsAndConditionsModelToJson(TermsAndConditionsModel data) => json.encode(data.toJson());

class TermsAndConditionsModel {
  TermsAndConditionsModel({
    required this.status,
    required this.message,
  });

  int status;
  Message message;

  factory TermsAndConditionsModel.fromJson(Map<String, dynamic> json) => TermsAndConditionsModel(
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
