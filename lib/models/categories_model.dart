class CategoriesModel {
  CategoriesModel({this.ptId, this.ptName, this.ptImage});

  String? ptId;
  String? ptName;
  String? ptImage;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
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
