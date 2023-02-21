import 'dart:convert';

GetTimeSlotByDoctorModel getTimeSlotByDoctorModelFromJson(String str) =>
    GetTimeSlotByDoctorModel.fromJson(json.decode(str));

String getTimeSlotByDoctorModelToJson(GetTimeSlotByDoctorModel data) =>
    json.encode(data.toJson());

class GetTimeSlotByDoctorModel {
  GetTimeSlotByDoctorModel({
    required this.status,
    required this.data,
  });

  int status;
  List<TimeSlotByDoctorList> data;

  factory GetTimeSlotByDoctorModel.fromJson(Map<String, dynamic> json) =>
      GetTimeSlotByDoctorModel(
        status: json["status"],
        data: List<TimeSlotByDoctorList>.from(
            json["data"].map((x) => TimeSlotByDoctorList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class TimeSlotByDoctorList {
  TimeSlotByDoctorList({
    required this.dtsTime,
    required this.dmsId,
  });

  String dtsTime;
  String dmsId;

  factory TimeSlotByDoctorList.fromJson(Map<String, dynamic> json) =>
      TimeSlotByDoctorList(
        dtsTime: json["DTS_TIME"],
        dmsId: json["DMS_ID"],
      );

  Map<String, dynamic> toJson() => {
        "DTS_TIME": dtsTime,
        "DMS_ID": dmsId,
      };
}
