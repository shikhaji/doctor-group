import 'dart:convert';

AllMainCategoryModel allMainCategoryModelFromJson(String str) =>
    AllMainCategoryModel.fromJson(json.decode(str));

String allMainCategoryModelToJson(AllMainCategoryModel data) =>
    json.encode(data.toJson());

class AllMainCategoryModel {
  AllMainCategoryModel({
    required this.status,
    required this.message,
  });

  int status;
  List<Message> message;

  factory AllMainCategoryModel.fromJson(Map<String, dynamic> json) =>
      AllMainCategoryModel(
        status: json["status"],
        message:
            List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": List<dynamic>.from(message.map((x) => x.toJson())),
      };
}

class Message {
  Message({
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

  factory Message.fromJson(Map<String, dynamic> json) => Message(
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
