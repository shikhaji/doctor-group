class GenderModel {
  GenderModel({

    this.genderName,

  });

  String? genderName;

  factory GenderModel.fromJson(Map<String, dynamic> json) => GenderModel(
    genderName: json["GENDER_NAME"],

  );

  Map<String, dynamic> toJson() => {
    "GENDER_NAME": genderName,

  };
}
