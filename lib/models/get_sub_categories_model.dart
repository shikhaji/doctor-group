import 'dart:convert';

GetSubCategoryModel getSubCategoryModelFromJson(String str) =>
    GetSubCategoryModel.fromJson(json.decode(str));

String getSubCategoryModelToJson(GetSubCategoryModel data) =>
    json.encode(data.toJson());

class GetSubCategoryModel {
  GetSubCategoryModel({
    required this.status,
    required this.message,
  });

  int status;
  List<GetSubCategoryList> message;

  factory GetSubCategoryModel.fromJson(Map<String, dynamic> json) =>
      GetSubCategoryModel(
        status: json["status"],
        message: List<GetSubCategoryList>.from(
            json["message"].map((x) => GetSubCategoryList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": List<dynamic>.from(message.map((x) => x.toJson())),
      };
}

class GetSubCategoryList {
  GetSubCategoryList({
    required this.categoryId,
    required this.categoryTt,
    required this.categoryName,
    required this.catImage,
    required this.categoryStatus,
    required this.brandId,
  });

  String categoryId;
  DateTime categoryTt;
  String categoryName;
  String catImage;
  String categoryStatus;
  String brandId;

  factory GetSubCategoryList.fromJson(Map<String, dynamic> json) =>
      GetSubCategoryList(
        categoryId: json["CATEGORY_ID"],
        categoryTt: DateTime.parse(json["CATEGORY_TT"]),
        categoryName: json["CATEGORY_NAME"],
        catImage: json["CAT_IMAGE"],
        categoryStatus: json["CATEGORY_STATUS"],
        brandId: json["BRAND_ID"],
      );

  Map<String, dynamic> toJson() => {
        "CATEGORY_ID": categoryId,
        "CATEGORY_TT": categoryTt.toIso8601String(),
        "CATEGORY_NAME": categoryName,
        "CAT_IMAGE": catImage,
        "CATEGORY_STATUS": categoryStatus,
        "BRAND_ID": brandId,
      };
}
