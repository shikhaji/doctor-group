import 'dart:convert';

SliderModel sliderModelFromJson(String str) =>
    SliderModel.fromJson(json.decode(str));

String sliderModelToJson(SliderModel data) => json.encode(data.toJson());

class SliderModel {
  SliderModel({
    this.status,
    this.message,
  });

  int? status;
  List<SliderImageList>? message;

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
        status: json["status"],
        message: List<SliderImageList>.from(
            json["message"].map((x) => SliderImageList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": List<dynamic>.from(message!.map((x) => x.toJson())),
      };
}

class SliderImageList {
  SliderImageList({
    required this.id,
    this.rsId,
    required this.sliderImage,
    required this.title,
    required this.discription1,
    required this.buttonLabel,
    required this.discription2,
    required this.districtId,
  });

  String id;
  dynamic rsId;
  String sliderImage;
  String title;
  String discription1;
  String buttonLabel;
  String discription2;
  String districtId;

  factory SliderImageList.fromJson(Map<String, dynamic> json) =>
      SliderImageList(
        id: json["id"],
        rsId: json["rs_id"],
        sliderImage: json["slider_image"],
        title: json["title"],
        discription1: json["discription1"],
        buttonLabel: json["button_label"],
        discription2: json["discription2"],
        districtId: json["DISTRICT_ID"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rs_id": rsId,
        "slider_image": sliderImage,
        "title": title,
        "discription1": discription1,
        "button_label": buttonLabel,
        "discription2": discription2,
        "DISTRICT_ID": districtId,
      };
}
