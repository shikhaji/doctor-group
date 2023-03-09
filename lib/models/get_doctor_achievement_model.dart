import 'dart:convert';

GetDoctorAchievementModel getDoctorAchievementModelFromJson(String str) =>
    GetDoctorAchievementModel.fromJson(json.decode(str));

String getDoctorAchievementModelToJson(GetDoctorAchievementModel data) =>
    json.encode(data.toJson());

class GetDoctorAchievementModel {
  GetDoctorAchievementModel({
    required this.status,
    required this.message,
    required this.achievement,
  });

  int status;
  String message;
  List<AchievementList> achievement;

  factory GetDoctorAchievementModel.fromJson(Map<String, dynamic> json) =>
      GetDoctorAchievementModel(
        status: json["status"],
        message: json["message"],
        achievement: List<AchievementList>.from(
            json["achievement"].map((x) => AchievementList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "achievement": List<dynamic>.from(achievement.map((x) => x.toJson())),
      };
}

class AchievementList {
  AchievementList({
    required this.daId,
    required this.daFileName,
    required this.daDoctorId,
  });

  String daId;
  String daFileName;
  String daDoctorId;

  factory AchievementList.fromJson(Map<String, dynamic> json) =>
      AchievementList(
        daId: json["DA_ID"],
        daFileName: json["DA_FILE_NAME"],
        daDoctorId: json["DA_DOCTOR_ID"],
      );

  Map<String, dynamic> toJson() => {
        "DA_ID": daId,
        "DA_FILE_NAME": daFileName,
        "DA_DOCTOR_ID": daDoctorId,
      };
}
