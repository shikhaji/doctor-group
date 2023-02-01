import 'dart:convert';

GetCategoriesListModel getCategoriesListModelFromJson(String str) =>
    GetCategoriesListModel.fromJson(json.decode(str));

String getCategoriesListModelToJson(GetCategoriesListModel data) =>
    json.encode(data.toJson());

class GetCategoriesListModel {
  GetCategoriesListModel({
    required this.status,
    required this.message,
  });

  int status;
  List<CategoriesData> message;

  factory GetCategoriesListModel.fromJson(Map<String, dynamic> json) =>
      GetCategoriesListModel(
        status: json["status"],
        message: List<CategoriesData>.from(
            json["message"].map((x) => CategoriesData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": List<dynamic>.from(message.map((x) => x.toJson())),
      };
}

class CategoriesData {
  CategoriesData({
    this.ptId,
    this.ptName,
    this.ptImage,
  });

  String? ptId;

  String? ptName;
  String? ptImage;

  factory CategoriesData.fromJson(Map<String, dynamic> json) => CategoriesData(
        ptId: json["PT_ID"],
        ptName: json["PT_NAME"],
        ptImage: json["PT_IMAGE"],
      );

  Map<String, dynamic> toJson() => {
        "PT_ID": ptId,
        "PT_NAME": ptName,
        "PT_IMAGE": ptImage,
      };
}
