import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/get_doctor_appointmnet_list_model.dart';
import '../../services/api_services.dart';
import '../../services/shared_referances.dart';
import '../../utils/app_color.dart';
import '../../utils/app_sizes.dart';
import '../../utils/app_text.dart';
import '../../utils/app_text_style.dart';
import '../../widget/custom_sized_box.dart';
import '../../widget/dailogs/my_appointment_confirm_dailog.dart';
import '../../widget/primary_botton.dart';

class CompleteAppointment extends StatefulWidget {
  const CompleteAppointment({Key? key}) : super(key: key);

  @override
  State<CompleteAppointment> createState() => _CompleteAppointmentState();
}

class _CompleteAppointmentState extends State<CompleteAppointment> {
  List<GetDoctorAppointmentList> getDoctorAppointmentList = [];
  String userTypeValue = "";
  @override
  void initState() {
    print("completed screen");
    super.initState();
    getType();

    ApiService().getDoctorAppointmentApi(2).then((value) {
      if (value != null) {
        setState(() {
          getDoctorAppointmentList = value.appointDetail;
        });
      }
    });
  }

  Future<void> getType() async {
    String userType = await Preferances.prefGetString("userType", '');
    setState(() {
      userTypeValue =
          userType.replaceAll('"', '').replaceAll('"', '').toString();
    });
    print("userTypeValue:=${userTypeValue}");
  }

  @override
  Widget build(BuildContext context) {
    return getDoctorAppointmentList.isEmpty
        ? const Center(
            child: Text(
              "No complete appointment",
              style: AppTextStyle.textFieldFont,
            ),
          )
        : Container(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                  vertical: Sizes.s20.h, horizontal: Sizes.s12.h),
              shrinkWrap: true,
              itemCount: getDoctorAppointmentList.length,
              itemBuilder: (context, inx) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: Sizes.s12),
                  padding: EdgeInsets.symmetric(
                      horizontal: Sizes.s12, vertical: Sizes.s18),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Sizes.s12),
                      border: Border.all(
                          color: AppColor.textFieldColor, width: Sizes.s2)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        children: [
                          appText(
                            "Appointment on ",
                            style: AppTextStyle.alertSubtitle.copyWith(
                                fontSize: Sizes.s16.sp,
                                color: AppColor.grey,
                                fontWeight: FontWeight.normal),
                          ),
                          getDoctorAppointmentList[inx].appointDate != null
                              ? Text(
                                  "${DateFormat('MMM dd yyyy').format(DateTime.parse(getDoctorAppointmentList[inx].appointDate.toString())).toString()}",
                                  style: AppTextStyle.alertSubtitle.copyWith(
                                      fontSize: Sizes.s16.sp,
                                      color: AppColor.darkGrey),
                                )
                              : SizedBox.shrink(),
                          Text(
                            " 11:23 pm",
                            style: AppTextStyle.alertSubtitle.copyWith(
                                fontSize: Sizes.s16.sp,
                                color: AppColor.darkGrey),
                          )
                        ],
                      ),
                      SizedBoxH6(),
                      Text(
                        "Dr. ${getDoctorAppointmentList[inx].branchName}",
                        style: AppTextStyle.redTextStyle.copyWith(
                          fontSize: Sizes.s18.sp,
                        ),
                      ),
                      SizedBoxH10(),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: Sizes.s12, vertical: Sizes.s18),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Sizes.s12),
                            color: AppColor.textFieldColor),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Patients Info : ",
                              style: AppTextStyle.appName.copyWith(
                                fontSize: Sizes.s16.sp,
                              ),
                            ),
                            SizedBoxH10(),
                            Row(
                              children: [
                                const Icon(
                                  Icons.account_circle_sharp,
                                  color: AppColor.grey,
                                ),
                                SizedBoxW6(),
                                Expanded(
                                  child: Text(
                                    getDoctorAppointmentList[inx].patientName,
                                    style: AppTextStyle.alertSubtitle,
                                  ),
                                )
                              ],
                            ),
                            SizedBoxH8(),
                            Row(
                              children: [
                                const Icon(
                                  Icons.phone,
                                  color: AppColor.grey,
                                ),
                                SizedBoxW6(),
                                Expanded(
                                  child: Text(
                                    getDoctorAppointmentList[inx].patientMobile,
                                    style: AppTextStyle.alertSubtitle,
                                  ),
                                )
                              ],
                            ),
                            SizedBoxH8(),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_rounded,
                                  color: AppColor.grey,
                                ),
                                SizedBoxW6(),
                                Expanded(
                                  child: Text(
                                    getDoctorAppointmentList[inx]
                                        .patientAddress,
                                    style: AppTextStyle.alertSubtitle,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBoxH18(),
                    ],
                  ),
                );
              },
            ),
          );
  }
}
