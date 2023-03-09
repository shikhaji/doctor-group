class SendArguments {
  String? phoneNumber;
  int? otpStatus;
  String? userId;
  String? ptId;
  String? catId;
  String? doctorId;
  String? servicesTypeName;
  String? doctorName;
  int? bottomIndex;
  bool? backIcon;

  SendArguments(
      {this.phoneNumber,
      this.otpStatus,
      this.bottomIndex,
      this.doctorName,
      this.userId,
      this.servicesTypeName,
      this.ptId,
      this.backIcon,
      this.catId,
      this.doctorId});
}
