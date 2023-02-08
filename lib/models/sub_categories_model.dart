class SubCategoriesModel {
  SubCategoriesModel(
      {this.categoryId,
      this.brandId,
      this.categoryName,
      this.categoryStatus,
      this.catImage});

  String? categoryId;
  String? categoryName;
  String? catImage;
  String? categoryStatus;
  String? brandId;

  factory SubCategoriesModel.fromJson(Map<String, dynamic> json) =>
      SubCategoriesModel(
        categoryId: json["CATEGORY_ID"],
        categoryName: json["CATEGORY_NAME"],
        catImage: json["CAT_IMAGE"],
        categoryStatus: json["CATEGORY_STATUS"],
        brandId: json["BRAND_ID"],
      );

  Map<String, dynamic> toJson() => {
        "CATEGORY_ID": categoryId,
        "CATEGORY_NAME": categoryName,
        "CAT_IMAGE": catImage,
        "CATEGORY_STATUS": categoryStatus,
        "BRAND_ID": brandId,
      };
}
