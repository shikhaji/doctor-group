import 'dart:convert';

GetDoctorAppointmentDistrictModel getDoctorAppointmentDistrictModelFromJson(
        String str) =>
    GetDoctorAppointmentDistrictModel.fromJson(json.decode(str));

String getDoctorAppointmentDistrictModelToJson(
        GetDoctorAppointmentDistrictModel data) =>
    json.encode(data.toJson());

class GetDoctorAppointmentDistrictModel {
  GetDoctorAppointmentDistrictModel({
    required this.status,
    required this.message,
    required this.achievement,
  });

  int status;
  String message;
  List<DoctorAppointmentDistrictList> achievement;

  factory GetDoctorAppointmentDistrictModel.fromJson(
          Map<String, dynamic> json) =>
      GetDoctorAppointmentDistrictModel(
        status: json["status"],
        message: json["message"],
        achievement: List<DoctorAppointmentDistrictList>.from(
            json["achievement"]
                .map((x) => DoctorAppointmentDistrictList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "achievement": List<dynamic>.from(achievement.map((x) => x.toJson())),
      };
}

class DoctorAppointmentDistrictList {
  DoctorAppointmentDistrictList({
    required this.dmsId,
    required this.dmsTt,
    required this.dmsDoctorId,
    required this.dmsTimeSlotId,
    required this.dmsDayId,
    required this.dmsStateId,
    required this.dmsDistrictId,
    required this.districtId,
    required this.districtName,
    required this.stateId,
  });

  String dmsId;
  DateTime dmsTt;
  String dmsDoctorId;
  String dmsTimeSlotId;
  String dmsDayId;
  String dmsStateId;
  String dmsDistrictId;
  String districtId;
  String districtName;
  String stateId;

  factory DoctorAppointmentDistrictList.fromJson(Map<String, dynamic> json) =>
      DoctorAppointmentDistrictList(
        dmsId: json["DMS_ID"],
        dmsTt: DateTime.parse(json["DMS_TT"]),
        dmsDoctorId: json["DMS_DOCTOR_ID"],
        dmsTimeSlotId: json["DMS_TIME_SLOT_ID"],
        dmsDayId: json["DMS_DAY_ID"],
        dmsStateId: json["DMS_STATE_ID"],
        dmsDistrictId: json["DMS_DISTRICT_ID"],
        districtId: json["DISTRICT_ID"],
        districtName: json["DISTRICT_NAME"],
        stateId: json["STATE_ID"],
      );

  Map<String, dynamic> toJson() => {
        "DMS_ID": dmsId,
        "DMS_TT": dmsTt.toIso8601String(),
        "DMS_DOCTOR_ID": dmsDoctorId,
        "DMS_TIME_SLOT_ID": dmsTimeSlotId,
        "DMS_DAY_ID": dmsDayId,
        "DMS_STATE_ID": dmsStateId,
        "DMS_DISTRICT_ID": dmsDistrictId,
        "DISTRICT_ID": districtId,
        "DISTRICT_NAME": districtName,
        "STATE_ID": stateId,
      };
}
