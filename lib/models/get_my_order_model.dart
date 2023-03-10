import 'dart:convert';

GetMyOrderModel getMyOrderModelFromJson(String str) =>
    GetMyOrderModel.fromJson(json.decode(str));

String getMyOrderModelToJson(GetMyOrderModel data) =>
    json.encode(data.toJson());

class GetMyOrderModel {
  GetMyOrderModel({
    required this.status,
    required this.message,
    required this.profile,
  });

  int status;
  String message;
  List<GetOrderList> profile;

  factory GetMyOrderModel.fromJson(Map<String, dynamic> json) =>
      GetMyOrderModel(
        status: json["status"],
        message: json["message"],
        profile: List<GetOrderList>.from(
            json["profile"].map((x) => GetOrderList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "profile": List<dynamic>.from(profile.map((x) => x.toJson())),
      };
}

class GetOrderList {
  GetOrderList({
    required this.upbpId,
    required this.upbpTt,
    required this.upbpReferBy,
    required this.upbpDesc,
    required this.upbpReportFile,
    required this.loginId,
    required this.upbpReportFileByShop,
    required this.upbpPathalogyLoginId,
  });

  String upbpId;
  DateTime upbpTt;
  String upbpReferBy;
  String upbpDesc;
  String upbpReportFile;
  String loginId;
  String upbpReportFileByShop;
  String upbpPathalogyLoginId;

  factory GetOrderList.fromJson(Map<String, dynamic> json) => GetOrderList(
        upbpId: json["UPBP_ID"],
        upbpTt: DateTime.parse(json["UPBP_TT"]),
        upbpReferBy: json["UPBP_REFER_BY"],
        upbpDesc: json["UPBP_DESC"],
        upbpReportFile: json["UPBP_REPORT_FILE"],
        loginId: json["LOGIN_ID"],
        upbpReportFileByShop: json["UPBP_REPORT_FILE_BY_SHOP"],
        upbpPathalogyLoginId: json["UPBP_PATHALOGY_LOGIN_ID"],
      );

  Map<String, dynamic> toJson() => {
        "UPBP_ID": upbpId,
        "UPBP_TT": upbpTt.toIso8601String(),
        "UPBP_REFER_BY": upbpReferBy,
        "UPBP_DESC": upbpDesc,
        "UPBP_REPORT_FILE": upbpReportFile,
        "LOGIN_ID": loginId,
        "UPBP_REPORT_FILE_BY_SHOP": upbpReportFileByShop,
        "UPBP_PATHALOGY_LOGIN_ID": upbpPathalogyLoginId,
      };
}
