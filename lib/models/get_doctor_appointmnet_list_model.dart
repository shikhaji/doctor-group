import 'dart:convert';

GetDoctorAppointmentModel getDoctorAppointmentListFromJson(String str) =>
    GetDoctorAppointmentModel.fromJson(json.decode(str));

String getDoctorAppointmentListToJson(GetDoctorAppointmentModel data) =>
    json.encode(data.toJson());

class GetDoctorAppointmentModel {
  GetDoctorAppointmentModel({
    required this.status,
    required this.message,
    required this.appointDetail,
  });

  int status;
  String message;
  List<GetDoctorAppointmentList> appointDetail;

  factory GetDoctorAppointmentModel.fromJson(Map<String, dynamic> json) =>
      GetDoctorAppointmentModel(
        status: json["status"],
        message: json["message"],
        appointDetail: List<GetDoctorAppointmentList>.from(
            json["appoint_detail"]
                .map((x) => GetDoctorAppointmentList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "appoint_detail":
            List<dynamic>.from(appointDetail.map((x) => x.toJson())),
      };
}

class GetDoctorAppointmentList {
  GetDoctorAppointmentList({
    required this.daId,
    required this.daTt,
    required this.doctorId,
    required this.patientName,
    required this.patientMobile,
    required this.patientAddress,
    required this.appointDate,
    required this.appointSlot,
    required this.appointType,
    required this.daLoginId,
    required this.daDiseas,
    required this.daDistrictId,
    required this.patientBookingId,
    required this.daStatus,
    required this.daMessage,
    required this.daTempId,
    required this.branchId,
    required this.branchName,
    required this.branchAddress,
    required this.branchContact,
    required this.branchEmail,
    required this.branchTt,
    required this.branchUsername,
    required this.branchPassword,
    required this.branchStatus,
    required this.branchViewPassword,
    required this.branchReferalCode,
    required this.branchCategory,
    required this.branchGender,
    required this.branchDistrictId,
    required this.branchStateId,
    required this.profileStatus,
    required this.loginToken,
    required this.referalCode,
    required this.firebaseToken,
    required this.branchToken,
    required this.branchSubCategory,
    required this.licenceNo,
    required this.ambulanceNo,
    required this.experience,
    required this.aboutUs,
    required this.speciality,
    required this.patientPhoto,
  });

  String daId;
  DateTime daTt;
  String doctorId;
  String patientName;
  String patientMobile;
  String patientAddress;
  DateTime appointDate;
  String appointSlot;
  String appointType;
  String daLoginId;
  String daDiseas;
  String daDistrictId;
  String patientBookingId;
  String daStatus;
  String daMessage;
  String daTempId;
  String branchId;
  String branchName;
  String branchAddress;
  String branchContact;
  String branchEmail;
  DateTime branchTt;
  String branchUsername;
  String branchPassword;
  String branchStatus;
  String branchViewPassword;
  String branchReferalCode;
  String branchCategory;
  String branchGender;
  String branchDistrictId;
  String branchStateId;
  String profileStatus;
  String loginToken;
  String referalCode;
  String firebaseToken;
  String branchToken;
  String branchSubCategory;
  String licenceNo;
  String ambulanceNo;
  String experience;
  String aboutUs;
  String speciality;
  String patientPhoto;

  factory GetDoctorAppointmentList.fromJson(Map<String, dynamic> json) =>
      GetDoctorAppointmentList(
        daId: json["DA_ID"],
        daTt: DateTime.parse(json["DA_TT"]),
        doctorId: json["DOCTOR_ID"],
        patientName: json["PATIENT_NAME"],
        patientMobile: json["PATIENT_MOBILE"],
        patientAddress: json["PATIENT_ADDRESS"],
        appointDate: DateTime.parse(json["APPOINT_DATE"]),
        appointSlot: json["APPOINT_SLOT"],
        appointType: json["APPOINT_TYPE"],
        daLoginId: json["DA_LOGIN_ID"],
        daDiseas: json["DA_DISEAS"],
        daDistrictId: json["DA_DISTRICT_ID"],
        patientBookingId: json["PATIENT_BOOKING_ID"],
        daStatus: json["DA_STATUS"],
        daMessage: json["DA_MESSAGE"],
        daTempId: json["DA_TEMP_ID"],
        branchId: json["BRANCH_ID"],
        branchName: json["BRANCH_NAME"],
        branchAddress: json["BRANCH_ADDRESS"],
        branchContact: json["BRANCH_CONTACT"],
        branchEmail: json["BRANCH_EMAIL"],
        branchTt: DateTime.parse(json["BRANCH_TT"]),
        branchUsername: json["BRANCH_USERNAME"],
        branchPassword: json["BRANCH_PASSWORD"],
        branchStatus: json["BRANCH_STATUS"],
        branchViewPassword: json["BRANCH_VIEW_PASSWORD"],
        branchReferalCode: json["BRANCH_REFERAL_CODE"],
        branchCategory: json["BRANCH_CATEGORY"],
        branchGender: json["BRANCH_GENDER"],
        branchDistrictId: json["BRANCH_DISTRICT_ID"],
        branchStateId: json["BRANCH_STATE_ID"],
        profileStatus: json["PROFILE_STATUS"],
        loginToken: json["LOGIN_TOKEN"],
        referalCode: json["REFERAL_CODE"],
        firebaseToken: json["FIREBASE_TOKEN"],
        branchToken: json["BRANCH_TOKEN"],
        branchSubCategory: json["BRANCH_SUB_CATEGORY"],
        licenceNo: json["LICENCE_NO"],
        ambulanceNo: json["AMBULANCE_NO"],
        experience: json["EXPERIENCE"],
        aboutUs: json["ABOUT_US"],
        speciality: json["SPECIALITY"],
        patientPhoto: json["PATIENT_PHOTO"],
      );

  Map<String, dynamic> toJson() => {
        "DA_ID": daId,
        "DA_TT": daTt.toIso8601String(),
        "DOCTOR_ID": doctorId,
        "PATIENT_NAME": patientName,
        "PATIENT_MOBILE": patientMobile,
        "PATIENT_ADDRESS": patientAddress,
        "APPOINT_DATE":
            "${appointDate.year.toString().padLeft(4, '0')}-${appointDate.month.toString().padLeft(2, '0')}-${appointDate.day.toString().padLeft(2, '0')}",
        "APPOINT_SLOT": appointSlot,
        "APPOINT_TYPE": appointType,
        "DA_LOGIN_ID": daLoginId,
        "DA_DISEAS": daDiseas,
        "DA_DISTRICT_ID": daDistrictId,
        "PATIENT_BOOKING_ID": patientBookingId,
        "DA_STATUS": daStatus,
        "DA_MESSAGE": daMessage,
        "DA_TEMP_ID": daTempId,
        "BRANCH_ID": branchId,
        "BRANCH_NAME": branchName,
        "BRANCH_ADDRESS": branchAddress,
        "BRANCH_CONTACT": branchContact,
        "BRANCH_EMAIL": branchEmail,
        "BRANCH_TT": branchTt.toIso8601String(),
        "BRANCH_USERNAME": branchUsername,
        "BRANCH_PASSWORD": branchPassword,
        "BRANCH_STATUS": branchStatus,
        "BRANCH_VIEW_PASSWORD": branchViewPassword,
        "BRANCH_REFERAL_CODE": branchReferalCode,
        "BRANCH_CATEGORY": branchCategory,
        "BRANCH_GENDER": branchGender,
        "BRANCH_DISTRICT_ID": branchDistrictId,
        "BRANCH_STATE_ID": branchStateId,
        "PROFILE_STATUS": profileStatus,
        "LOGIN_TOKEN": loginToken,
        "REFERAL_CODE": referalCode,
        "FIREBASE_TOKEN": firebaseToken,
        "BRANCH_TOKEN": branchToken,
        "BRANCH_SUB_CATEGORY": branchSubCategory,
        "LICENCE_NO": licenceNo,
        "AMBULANCE_NO": ambulanceNo,
        "EXPERIENCE": experience,
        "ABOUT_US": aboutUs,
        "SPECIALITY": speciality,
        "PATIENT_PHOTO": patientPhoto,
      };
}
