import 'dart:convert';

GetAllProfileModel getAllProfileModelFromJson(String? str) =>
    GetAllProfileModel.fromJson(json.decode(str!));

String? getAllProfileModelToJson(GetAllProfileModel data) =>
    json.encode(data.toJson());

class GetAllProfileModel {
  GetAllProfileModel({
    this.status,
    this.message,
  });

  int? status;
  List<GetAllProfileList>? message;

  factory GetAllProfileModel.fromJson(Map<String, dynamic> json) =>
      GetAllProfileModel(
        status: json["status"],
        message: List<GetAllProfileList>.from(
            json["message"].map((x) => GetAllProfileList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": List<dynamic>.from(message!.map((x) => x.toJson())),
      };
}

class GetAllProfileList {
  GetAllProfileList({
    this.branchId,
    this.firmId,
    this.branchName,
    this.branchCode,
    this.branchAddress,
    this.branchContact,
    this.branchAltContact,
    this.branchPhone,
    this.branchEmail,
    this.branchUsername,
    this.branchPassword,
    this.branchStatus,
    this.companyHrmType,
    this.branchPanNo,
    this.branchBankName,
    this.bankAccNo,
    this.ifscCode,
    this.adharNo,
    this.fatherName,
    this.startDate,
    this.branchViewPassword,
    this.branchReferalCode,
    this.branchCategory,
    this.branchGender,
    this.branchDistrictId,
    this.branchStateId,
    this.profileStatus,
    this.loginToken,
    this.referalCode,
    this.firebaseToken,
    this.branchToken,
    this.branchSubCategory,
    this.licenceNo,
    this.ambulanceNo,
    this.experience,
    this.aboutUs,
    this.speciality,
    this.patientPhoto,
    this.pTSCREEN,
  });

  String? branchId;
  String? firmId;
  String? branchName;
  String? branchCode;
  String? branchAddress;
  String? branchContact;
  String? branchAltContact;
  String? branchPhone;
  String? branchEmail;
  String? branchUsername;
  String? branchPassword;
  String? branchStatus;
  String? companyHrmType;
  String? branchPanNo;
  String? branchBankName;
  String? bankAccNo;
  String? ifscCode;
  String? adharNo;
  String? fatherName;
  String? startDate;
  String? branchViewPassword;
  String? branchReferalCode;
  String? branchCategory;
  String? branchGender;
  String? branchDistrictId;
  String? branchStateId;
  String? profileStatus;
  String? loginToken;
  String? referalCode;
  String? firebaseToken;
  String? branchToken;
  String? branchSubCategory;
  String? licenceNo;
  String? ambulanceNo;
  String? experience;
  String? aboutUs;
  String? speciality;
  String? patientPhoto;
  String? pTSCREEN;

  factory GetAllProfileList.fromJson(Map<String, dynamic> json) =>
      GetAllProfileList(
        branchId: json["BRANCH_ID"],
        firmId: json["FIRM_ID"],
        branchName: json["BRANCH_NAME"],
        branchCode: json["BRANCH_CODE"],
        branchAddress: json["BRANCH_ADDRESS"],
        branchContact: json["BRANCH_CONTACT"],
        branchAltContact: json["BRANCH_ALT_CONTACT"],
        branchPhone: json["BRANCH_PHONE"],
        branchEmail: json["BRANCH_EMAIL"],
        branchUsername: json["BRANCH_USERNAME"],
        branchPassword: json["BRANCH_PASSWORD"],
        branchStatus: json["BRANCH_STATUS"],
        companyHrmType: json["COMPANY_HRM_TYPE"],
        branchPanNo: json["BRANCH_PAN_NO"],
        branchBankName: json["BRANCH_BANK_NAME"],
        bankAccNo: json["BANK_ACC_NO"],
        ifscCode: json["IFSC_CODE"],
        adharNo: json["ADHAR_NO"],
        fatherName: json["FATHER_NAME"],
        startDate: json["START_DATE"],
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
        pTSCREEN: json["PT_SCREEN"],
      );

  Map<String, dynamic> toJson() => {
        "BRANCH_ID": branchId,
        "FIRM_ID": firmId,
        "BRANCH_NAME": branchName,
        "BRANCH_CODE": branchCode,
        "BRANCH_ADDRESS": branchAddress,
        "BRANCH_CONTACT": branchContact,
        "BRANCH_ALT_CONTACT": branchAltContact,
        "BRANCH_PHONE": branchPhone,
        "BRANCH_EMAIL": branchEmail,
        "BRANCH_USERNAME": branchUsername,
        "BRANCH_PASSWORD": branchPassword,
        "BRANCH_STATUS": branchStatus,
        "COMPANY_HRM_TYPE": companyHrmType,
        "BRANCH_PAN_NO": branchPanNo,
        "BRANCH_BANK_NAME": branchBankName,
        "BANK_ACC_NO": bankAccNo,
        "IFSC_CODE": ifscCode,
        "ADHAR_NO": adharNo,
        "FATHER_NAME": fatherName,
        "START_DATE": startDate,
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
        "PT_SCREEN": pTSCREEN,
      };
}
