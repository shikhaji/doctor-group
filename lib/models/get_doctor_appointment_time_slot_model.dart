import 'dart:convert';

GetDoctorAppointmentTimeSlotModel getDoctorAppointmentTimeSlotModelFromJson(
        String str) =>
    GetDoctorAppointmentTimeSlotModel.fromJson(json.decode(str));

String getDoctorAppointmentTimeSlotModelToJson(
        GetDoctorAppointmentTimeSlotModel data) =>
    json.encode(data.toJson());

class GetDoctorAppointmentTimeSlotModel {
  GetDoctorAppointmentTimeSlotModel({
    required this.status,
    required this.message,
    required this.achievement,
  });

  int status;
  String message;
  List<DoctorAppointmentTimeSlotList> achievement;

  factory GetDoctorAppointmentTimeSlotModel.fromJson(
          Map<String, dynamic> json) =>
      GetDoctorAppointmentTimeSlotModel(
        status: json["status"],
        message: json["message"],
        achievement: List<DoctorAppointmentTimeSlotList>.from(
            json["achievement"]
                .map((x) => DoctorAppointmentTimeSlotList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "achievement": List<dynamic>.from(achievement.map((x) => x.toJson())),
      };
}

class DoctorAppointmentTimeSlotList {
  DoctorAppointmentTimeSlotList({
    required this.dmsId,
    required this.dmsTt,
    required this.dmsDoctorId,
    required this.dmsTimeSlotId,
    required this.dmsDayId,
    required this.dmsStateId,
    required this.dmsDistrictId,
    required this.dlId,
    required this.dlTt,
    required this.dlName,
    required this.districtId,
    required this.districtName,
    required this.stateId,
    required this.dtsId,
    required this.dtsTt,
    required this.dtsTime,
  });

  String dmsId;
  DateTime dmsTt;
  String dmsDoctorId;
  String dmsTimeSlotId;
  String dmsDayId;
  String dmsStateId;
  String dmsDistrictId;
  String dlId;
  DateTime dlTt;
  String dlName;
  String districtId;
  String districtName;
  String stateId;
  String dtsId;
  String dtsTt;
  String dtsTime;

  factory DoctorAppointmentTimeSlotList.fromJson(Map<String, dynamic> json) =>
      DoctorAppointmentTimeSlotList(
        dmsId: json["DMS_ID"],
        dmsTt: DateTime.parse(json["DMS_TT"]),
        dmsDoctorId: json["DMS_DOCTOR_ID"],
        dmsTimeSlotId: json["DMS_TIME_SLOT_ID"],
        dmsDayId: json["DMS_DAY_ID"],
        dmsStateId: json["DMS_STATE_ID"],
        dmsDistrictId: json["DMS_DISTRICT_ID"],
        dlId: json["DL_ID"],
        dlTt: DateTime.parse(json["DL_TT"]),
        dlName: json["DL_NAME"],
        districtId: json["DISTRICT_ID"],
        districtName: json["DISTRICT_NAME"],
        stateId: json["STATE_ID"],
        dtsId: json["DTS_ID"],
        dtsTt: json["DTS_TT"],
        dtsTime: json["DTS_TIME"],
      );

  Map<String, dynamic> toJson() => {
        "DMS_ID": dmsId,
        "DMS_TT": dmsTt.toIso8601String(),
        "DMS_DOCTOR_ID": dmsDoctorId,
        "DMS_TIME_SLOT_ID": dmsTimeSlotId,
        "DMS_DAY_ID": dmsDayId,
        "DMS_STATE_ID": dmsStateId,
        "DMS_DISTRICT_ID": dmsDistrictId,
        "DL_ID": dlId,
        "DL_TT": dlTt.toIso8601String(),
        "DL_NAME": dlName,
        "DISTRICT_ID": districtId,
        "DISTRICT_NAME": districtName,
        "STATE_ID": stateId,
        "DTS_ID": dtsId,
        "DTS_TT": dtsTt,
        "DTS_TIME": dtsTime,
      };
}
