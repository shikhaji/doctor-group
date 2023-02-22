import 'dart:convert';

GetTransactionModel getTransactionModelFromJson(String str) =>
    GetTransactionModel.fromJson(json.decode(str));

String getTransactionModelToJson(GetTransactionModel data) =>
    json.encode(data.toJson());

class GetTransactionModel {
  GetTransactionModel({
    required this.status,
    required this.history,
  });

  int status;
  List<TransactionHistoryList> history;

  factory GetTransactionModel.fromJson(Map<String, dynamic> json) =>
      GetTransactionModel(
        status: json["status"],
        history: List<TransactionHistoryList>.from(
            json["HISTORY"].map((x) => TransactionHistoryList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "HISTORY": List<dynamic>.from(history.map((x) => x.toJson())),
      };
}

class TransactionHistoryList {
  TransactionHistoryList({
    required this.cwtId,
    required this.cwtCustomerId,
    required this.cwtTransactionId,
    required this.cwtAmount,
    required this.cwtDate,
    required this.cwtTt,
    required this.cwtPaymentType,
    required this.cwtStatus,
    required this.cwtPaymentStatus,
    required this.cwtAppointmentId,
    required this.cwtBalance,
    required this.branchId,
    required this.branchName,
    required this.branchAddress,
    required this.branchContact,
    required this.branchSubCategory,
    required this.licenceNo,
    required this.ambulanceNo,
    required this.experience,
    required this.aboutUs,
    required this.speciality,
    required this.patientPhoto,
    required this.paymentTypeId,
    required this.paymentTt,
    required this.paymentName,
  });

  String cwtId;
  String cwtCustomerId;
  String cwtTransactionId;
  String cwtAmount;
  String cwtDate;
  String cwtTt;
  String cwtPaymentType;
  String cwtStatus;
  String cwtPaymentStatus;
  String cwtAppointmentId;
  String cwtBalance;
  String branchId;
  String branchName;
  String branchAddress;
  String branchContact;
  String branchSubCategory;
  String licenceNo;
  String ambulanceNo;
  String experience;
  String aboutUs;
  String speciality;
  String patientPhoto;
  String paymentTypeId;
  DateTime paymentTt;
  String paymentName;

  factory TransactionHistoryList.fromJson(Map<String, dynamic> json) =>
      TransactionHistoryList(
        cwtId: json["CWT_ID"],
        cwtCustomerId: json["CWT_CUSTOMER_ID"],
        cwtTransactionId: json["CWT_TRANSACTION_ID"],
        cwtAmount: json["CWT_AMOUNT"],
        cwtDate: json["CWT_DATE"],
        cwtTt: json["CWT_TT"],
        cwtPaymentType: json["CWT_PAYMENT_TYPE"],
        cwtStatus: json["CWT_STATUS"],
        cwtPaymentStatus: json["CWT_PAYMENT_STATUS"],
        cwtAppointmentId: json["CWT_APPOINTMENT_ID"],
        cwtBalance: json["CWT_BALANCE"],
        branchId: json["BRANCH_ID"],
        branchName: json["BRANCH_NAME"],
        branchAddress: json["BRANCH_ADDRESS"],
        branchContact: json["BRANCH_CONTACT"],
        branchSubCategory: json["BRANCH_SUB_CATEGORY"],
        licenceNo: json["LICENCE_NO"],
        ambulanceNo: json["AMBULANCE_NO"],
        experience: json["EXPERIENCE"],
        aboutUs: json["ABOUT_US"],
        speciality: json["SPECIALITY"],
        patientPhoto: json["PATIENT_PHOTO"],
        paymentTypeId: json["PAYMENT_TYPE_ID"],
        paymentTt: DateTime.parse(json["PAYMENT_TT"]),
        paymentName: json["PAYMENT_NAME"],
      );

  Map<String, dynamic> toJson() => {
        "CWT_ID": cwtId,
        "CWT_CUSTOMER_ID": cwtCustomerId,
        "CWT_TRANSACTION_ID": cwtTransactionId,
        "CWT_AMOUNT": cwtAmount,
        "CWT_DATE": cwtDate,
        "CWT_TT": cwtTt,
        "CWT_PAYMENT_TYPE": cwtPaymentType,
        "CWT_STATUS": cwtStatus,
        "CWT_PAYMENT_STATUS": cwtPaymentStatus,
        "CWT_APPOINTMENT_ID": cwtAppointmentId,
        "CWT_BALANCE": cwtBalance,
        "BRANCH_ID": branchId,
        "BRANCH_NAME": branchName,
        "BRANCH_ADDRESS": branchAddress,
        "BRANCH_CONTACT": branchContact,
        "BRANCH_SUB_CATEGORY": branchSubCategory,
        "LICENCE_NO": licenceNo,
        "AMBULANCE_NO": ambulanceNo,
        "EXPERIENCE": experience,
        "ABOUT_US": aboutUs,
        "SPECIALITY": speciality,
        "PATIENT_PHOTO": patientPhoto,
        "PAYMENT_TYPE_ID": paymentTypeId,
        "PAYMENT_TT": paymentTt.toIso8601String(),
        "PAYMENT_NAME": paymentName,
      };
}
