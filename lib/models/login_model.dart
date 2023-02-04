import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.status,
    required this.message,
    required this.id,
    required this.loginToken,
    required this.keyId,
    required this.keySecret,
   // this.referalCode,
    required this.name,
    required this.contact,
    required this.playStoreUrl,
    required this.profileStatus,
    required this.businessType,
    required this.firebaseToken,
  });

  int status;
  String message;
  String id;
  String loginToken;
  String keyId;
  String keySecret;
 // dynamic referalCode;
  String name;
  String contact;
  String playStoreUrl;
  String profileStatus;
  String businessType;
  String firebaseToken;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json["status"],
    message: json["message"],
    id: json["id"],
    loginToken: json["LOGIN_TOKEN"],
    keyId: json["KEY_ID"],
    keySecret: json["KEY_SECRET"],
   // referalCode: json["REFERAL_CODE"],
    name: json["name"],
    contact: json["contact"],
    playStoreUrl: json["PLAY_STORE_URL"],
    profileStatus: json["PROFILE_STATUS"],
    businessType: json["BUSINESS_TYPE"],
    firebaseToken: json["FIREBASE_TOKEN"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "id": id,
    "LOGIN_TOKEN": loginToken,
    "KEY_ID": keyId,
    "KEY_SECRET": keySecret,
    //"REFERAL_CODE": referalCode,
    "name": name,
    "contact": contact,
    "PLAY_STORE_URL": playStoreUrl,
    "PROFILE_STATUS": profileStatus,
    "BUSINESS_TYPE": businessType,
    "FIREBASE_TOKEN": firebaseToken,
  };
}
