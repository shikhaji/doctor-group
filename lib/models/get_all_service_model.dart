import 'dart:convert';

GetAllServicesModel getAllServicesModelFromJson(String str) =>
    GetAllServicesModel.fromJson(json.decode(str));

String getAllServicesModelToJson(GetAllServicesModel data) =>
    json.encode(data.toJson());

class GetAllServicesModel {
  GetAllServicesModel({
    required this.status,
    required this.message,
  });

  int status;
  List<GetAllServicesList> message;

  factory GetAllServicesModel.fromJson(Map<String, dynamic> json) =>
      GetAllServicesModel(
        status: json["status"],
        message: List<GetAllServicesList>.from(
            json["message"].map((x) => GetAllServicesList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": List<dynamic>.from(message.map((x) => x.toJson())),
      };
}

class GetAllServicesList {
  GetAllServicesList({
    required this.ptId,
    required this.ptTt,
    required this.ptName,
    required this.ptImage,
    required this.profileUrl,
    required this.ptSubCatAvailable,
    required this.ptActive,
  });

  String ptId;
  DateTime ptTt;
  String ptName;
  String ptImage;
  String profileUrl;
  String ptSubCatAvailable;
  String ptActive;

  factory GetAllServicesList.fromJson(Map<String, dynamic> json) =>
      GetAllServicesList(
        ptId: json["PT_ID"],
        ptTt: DateTime.parse(json["PT_TT"]),
        ptName: json["PT_NAME"],
        ptImage: json["PT_IMAGE"],
        profileUrl: json["PROFILE_URL"],
        ptSubCatAvailable: json["PT_SUB_CAT_AVAILABLE"],
        ptActive: json["PT_ACTIVE"],
      );

  Map<String, dynamic> toJson() => {
        "PT_ID": ptId,
        "PT_TT": ptTt.toIso8601String(),
        "PT_NAME": ptName,
        "PT_IMAGE": ptImage,
        "PROFILE_URL": profileUrl,
        "PT_SUB_CAT_AVAILABLE": ptSubCatAvailable,
        "PT_ACTIVE": ptActive,
      };
}
