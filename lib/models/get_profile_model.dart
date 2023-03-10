import 'dart:convert';

GetProfileDataModel getProfileDataModelFromJson(String str) =>
    GetProfileDataModel.fromJson(json.decode(str));

String getProfileDataModelToJson(GetProfileDataModel data) =>
    json.encode(data.toJson());

class GetProfileDataModel {
  GetProfileDataModel({
    required this.status,
    required this.message,
    required this.profile,
  });

  int status;
  String message;
  GetProfileData profile;

  factory GetProfileDataModel.fromJson(Map<String, dynamic> json) =>
      GetProfileDataModel(
        status: json["status"],
        message: json["message"],
        profile: GetProfileData.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "profile": profile.toJson(),
      };
}

class GetProfileData {
  GetProfileData({
    this.branchId,
    this.branchName,
    this.branchAddress,
    this.branchContact,
    this.branchEmail,
    this.branchUsername,
    this.branchPassword,
    this.branchStatus,
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
    this.ptScreen,
    this.speciality,
    this.patientPhoto,
    this.districtName,
    this.stateId,
    this.stateName,
    this.categoryName,
  });

  String? branchId;
  String? branchName;
  String? branchAddress;
  String? branchContact;
  String? branchEmail;

  String? branchUsername;
  String? branchPassword;
  String? branchStatus;
  String? branchViewPassword;
  String? branchReferalCode;
  String? branchCategory;
  String? branchGender;
  String? branchDistrictId;

  String? districtName;
  String? stateId;
  String? stateName;
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
  String? ptScreen;
  String? categoryName;

  factory GetProfileData.fromJson(Map<String, dynamic> json) => GetProfileData(
        branchId: json["BRANCH_ID"] ?? "",
        branchName: json["BRANCH_NAME"] ?? "",
        branchAddress: json["BRANCH_ADDRESS"] ?? "",
        branchContact: json["BRANCH_CONTACT"] ?? "",
        branchEmail: json["BRANCH_EMAIL"] ?? "",
        branchUsername: json["BRANCH_USERNAME"] ?? "",
        branchPassword: json["BRANCH_PASSWORD"] ?? "",
        branchStatus: json["BRANCH_STATUS"] ?? "",
        branchViewPassword: json["BRANCH_VIEW_PASSWORD"] ?? "",
        branchReferalCode: json["BRANCH_REFERAL_CODE"] ?? "",
        branchCategory: json["BRANCH_CATEGORY"] ?? "",
        branchGender: json["BRANCH_GENDER"] ?? "",
        branchDistrictId: json["BRANCH_DISTRICT_ID"] ?? "",
        branchStateId: json["BRANCH_STATE_ID"] ?? "",
        profileStatus: json["PROFILE_STATUS"] ?? "",
        loginToken: json["LOGIN_TOKEN"] ?? "",
        referalCode: json["REFERAL_CODE"] ?? "",
        firebaseToken: json["FIREBASE_TOKEN"] ?? "",
        branchToken: json["BRANCH_TOKEN"] ?? "",
        branchSubCategory: json["BRANCH_SUB_CATEGORY"] ?? "",
        licenceNo: json["LICENCE_NO"] ?? "",
        ambulanceNo: json["AMBULANCE_NO"] ?? "",
        experience: json["EXPERIENCE"] ?? "",
        aboutUs: json["ABOUT_US"] ?? "",
        speciality: json["SPECIALITY"] ?? "",
        patientPhoto: json["PATIENT_PHOTO"] ?? "",
        districtName: json["DISTRICT_NAME"] ?? "",
        stateId: json["STATE_ID"] ?? "",
        stateName: json["STATE_NAME"] ?? "",
        ptScreen: json["PT_SCREEN"] ?? "",
        categoryName: json["CATEGORY_NAME"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "BRANCH_ID": branchId ?? "",
        "BRANCH_NAME": branchName ?? "",
        "BRANCH_ADDRESS": branchAddress ?? "",
        "BRANCH_CONTACT": branchContact ?? "",
        "BRANCH_EMAIL": branchEmail ?? "",
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
        "DISTRICT_NAME": districtName,
        "STATE_ID": stateId,
        "STATE_NAME": stateName,
        "PT_SCREEN": ptScreen,
        "CATEGORY_NAME": categoryName,
      };
}
