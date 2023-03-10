import 'package:date_picker_timeline/extra/color.dart';
import 'package:dio/dio.dart';
import 'package:doctor_on_call/services/api_services.dart';
import 'package:doctor_on_call/utils/app_text.dart';
import 'package:doctor_on_call/widget/custom_sized_box.dart';
import 'package:doctor_on_call/widget/primary_botton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../../models/get_doctor_appointmnet_list_model.dart';
import '../../services/shared_referances.dart';
import '../../utils/app_color.dart';
import '../../utils/app_sizes.dart';
import '../../utils/app_text_style.dart';
import '../../utils/screen_utils.dart';
import '../../widget/dailogs/my_appointment_confirm_dailog.dart';
import '../../widget/drawer_widget.dart';
import '../../widget/primary_appbar.dart';

class MyAppointmentScreen extends StatefulWidget {
  const MyAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<MyAppointmentScreen> createState() => _MyAppointmentScreenState();
}

class _MyAppointmentScreenState extends State<MyAppointmentScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController? tabController;
  List<GetDoctorAppointmentList> getDoctorAppointmentList = [];
  String userTypeValue = "";
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  void initState() {
    super.initState();
    getType();
    tabController =
        TabController(length: 3, vsync: this, animationDuration: Duration.zero);

    ApiService().getDoctorAppointmentApi(0).then((value) {
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
    return Scaffold(
      key: _scaffoldKey,
      body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [
            getDoctorAppointmentList.isNotEmpty
                ? pendingList(context)
                : const Center(
                    child: Text(
                      "No pending appointment",
                      style: AppTextStyle.textFieldFont,
                    ),
                  ),
            getDoctorAppointmentList.isNotEmpty
                ? upComingList(context)
                : const Center(
                    child: Text(
                      "No pending appointment",
                      style: AppTextStyle.textFieldFont,
                    ),
                  ),
            getDoctorAppointmentList.isNotEmpty
                ? completedList(context)
                : const Center(
                    child: Text(
                      "No pending appointment",
                      style: AppTextStyle.textFieldFont,
                    ),
                  ),
          ]),
      drawer: Drawer(
        backgroundColor: Colors.white,
        elevation: 0,
        width: ScreenUtil().screenWidth * 0.8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(Sizes.s20.r),
            bottomRight: Radius.circular(Sizes.s20.r),
          ),
        ),
        child: const DrawerWidget(),
      ),
      appBar: TabAppBar(
        title: "My Appointment",
        action: const SizedBox.shrink(),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: Sizes.s20.w, left: Sizes.s10.w, right: Sizes.s10.w),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Sizes.s5.w,
                  vertical: Sizes.s5.h,
                ),
                width: ScreenUtil().screenWidth,
                height: 60,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TabBar(
                  controller: tabController,
                  onTap: (index) {
                    if (index == 0) {
                      ApiService().getDoctorAppointmentApi(0).then((value) {
                        if (value != null) {
                          getDoctorAppointmentList = value.appointDetail;
                        }
                      });
                    } else if (index == 1) {
                      ApiService().getDoctorAppointmentApi(1).then((value) {
                        if (value != null) {
                          getDoctorAppointmentList = value.appointDetail;
                        }
                      });
                    } else {
                      ApiService().getDoctorAppointmentApi(2).then((value) {
                        if (value != null) {
                          getDoctorAppointmentList = value.appointDetail;
                        }
                      });
                    }
                  },
                  indicatorPadding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  tabs: const [
                    Tab(text: "Pending"),
                    Tab(text: "Upcoming"),
                    Tab(text: "Completed"),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget pendingList(BuildContext context) {
    return ListView.builder(
      padding:
          EdgeInsets.symmetric(vertical: Sizes.s20.h, horizontal: Sizes.s12.h),
      shrinkWrap: true,
      itemCount: getDoctorAppointmentList.length,
      itemBuilder: (context, inx) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: Sizes.s12),
          padding:
              EdgeInsets.symmetric(horizontal: Sizes.s12, vertical: Sizes.s18),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.s12),
              border:
                  Border.all(color: AppColor.textFieldColor, width: Sizes.s2)),
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
                  Text(
                    "${DateFormat('MMM dd yyyy').format(DateTime.parse(getDoctorAppointmentList[inx].appointDate.toString())).toString()}",
                    style: AppTextStyle.alertSubtitle.copyWith(
                        fontSize: Sizes.s16.sp, color: AppColor.darkGrey),
                  ),
                  Text(
                    " 11:23 pm",
                    style: AppTextStyle.alertSubtitle.copyWith(
                        fontSize: Sizes.s16.sp, color: AppColor.darkGrey),
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
                            getDoctorAppointmentList[inx].patientAddress,
                            style: AppTextStyle.alertSubtitle,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBoxH18(),
              userTypeValue == 2
                  ? PrimaryButton(
                      lable: "Cancel",
                      onPressed: () {
                        MyAppointmentConfirmDailog.show(
                                context,
                                'Cancel your appointment?',
                                'Are you sure you want to cancel the appointment.  You will not be able to recover it')
                            .then((value) async {
                          if (value == true) {
                            print("call api for cancel");
                            String? id = await Preferances.getString("userId");
                            FormData data() {
                              return FormData.fromMap({
                                "appointid": getDoctorAppointmentList[inx].daId,
                                "status": 2,
                                "loginid": id!
                                    .replaceAll('"', '')
                                    .replaceAll('"', '')
                                    .toString()
                              });
                            }

                            ApiService().updateApproveBookingStatusApi(context,
                                data: data());
                            await ApiService()
                                .getDoctorAppointmentApi(1)
                                .then((value) {
                              if (value != null) {
                                setState(() {
                                  getDoctorAppointmentList =
                                      value.appointDetail;
                                });
                              }
                            });
                          }
                        });
                      })
                  : PrimaryButton(
                      lable: "Approved",
                      onPressed: () {
                        MyAppointmentConfirmDailog.show(
                                context,
                                'Approved your appointment?',
                                'Are you sure you want to approved the appointment.')
                            .then((value) async {
                          if (value == true) {
                            print("call api for approved");
                            String? id = await Preferances.getString("userId");
                            FormData data() {
                              return FormData.fromMap({
                                "appointid": getDoctorAppointmentList[inx].daId,
                                "status": 0,
                                "loginid": id!
                                    .replaceAll('"', '')
                                    .replaceAll('"', '')
                                    .toString()
                              });
                            }

                            ApiService().updateApproveBookingStatusApi(context,
                                data: data());
                            await ApiService()
                                .getDoctorAppointmentApi(0)
                                .then((value) {
                              if (value != null) {
                                setState(() {
                                  getDoctorAppointmentList =
                                      value.appointDetail;
                                });
                              }
                            });
                          }
                        });
                      })
            ],
          ),
        );
      },
    );
  }

  Widget upComingList(BuildContext context) {
    return ListView.builder(
      padding:
          EdgeInsets.symmetric(vertical: Sizes.s20.h, horizontal: Sizes.s12.h),
      shrinkWrap: true,
      itemCount: getDoctorAppointmentList.length,
      itemBuilder: (context, inx) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: Sizes.s12),
          padding:
              EdgeInsets.symmetric(horizontal: Sizes.s12, vertical: Sizes.s18),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.s12),
              border:
                  Border.all(color: AppColor.textFieldColor, width: Sizes.s2)),
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
                  Text(
                    "${DateFormat('MMM dd yyyy').format(DateTime.parse(getDoctorAppointmentList[inx].appointDate.toString())).toString()}",
                    style: AppTextStyle.alertSubtitle.copyWith(
                        fontSize: Sizes.s16.sp, color: AppColor.darkGrey),
                  ),
                  Text(
                    "11:23 pm",
                    style: AppTextStyle.alertSubtitle.copyWith(
                        fontSize: Sizes.s16.sp, color: AppColor.darkGrey),
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
                            getDoctorAppointmentList[inx].patientAddress,
                            style: AppTextStyle.alertSubtitle,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBoxH18(),
              completeAndCancel("Complete", "Cancel", onTapComplete: () {
                MyAppointmentConfirmDailog.show(
                        context,
                        'Complete your appointment?',
                        'Are you sure you want to Complete the appointment.')
                    .then((value) async {
                  if (value == true) {
                    print("call api for complete");
                    String? id = await Preferances.getString("userId");
                    FormData data() {
                      return FormData.fromMap({
                        "appointid": getDoctorAppointmentList[inx].daId,
                        "status": 1,
                        "loginid": id!
                            .replaceAll('"', '')
                            .replaceAll('"', '')
                            .toString()
                      });
                    }

                    ApiService()
                        .updateApproveBookingStatusApi(context, data: data());
                    await ApiService().getDoctorAppointmentApi(1).then((value) {
                      if (value != null) {
                        setState(() {
                          getDoctorAppointmentList = value.appointDetail;
                        });
                      }
                    });
                  }
                });
              }, onTapCancel: () {
                MyAppointmentConfirmDailog.show(
                        context,
                        'Cancel your appointment?',
                        'Are you sure you want to cancel the appointment.  You will not be able to recover it')
                    .then((value) async {
                  if (value == true) {
                    print("call api for cancel");
                    String? id = await Preferances.getString("userId");
                    FormData data() {
                      return FormData.fromMap({
                        "appointid": getDoctorAppointmentList[inx].daId,
                        "status": 2,
                        "loginid": id!
                            .replaceAll('"', '')
                            .replaceAll('"', '')
                            .toString()
                      });
                    }

                    ApiService()
                        .updateApproveBookingStatusApi(context, data: data());
                    await ApiService().getDoctorAppointmentApi(1).then((value) {
                      if (value != null) {
                        setState(() {
                          getDoctorAppointmentList = value.appointDetail;
                        });
                      }
                    });
                  }
                });
              }),
            ],
          ),
        );
      },
    );
  }

  Widget completedList(BuildContext context) {
    return ListView.builder(
      padding:
          EdgeInsets.symmetric(vertical: Sizes.s20.h, horizontal: Sizes.s12.h),
      shrinkWrap: true,
      itemCount: getDoctorAppointmentList.length,
      itemBuilder: (context, inx) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: Sizes.s12),
          padding:
              EdgeInsets.symmetric(horizontal: Sizes.s12, vertical: Sizes.s18),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.s12),
              border:
                  Border.all(color: AppColor.textFieldColor, width: Sizes.s2)),
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
                  Text(
                    "${DateFormat('MMM dd yyyy').format(DateTime.parse(getDoctorAppointmentList[inx].appointDate.toString())).toString()}",
                    style: AppTextStyle.alertSubtitle.copyWith(
                        fontSize: Sizes.s16.sp, color: AppColor.darkGrey),
                  ),
                  Text(
                    "11:23 pm",
                    style: AppTextStyle.alertSubtitle.copyWith(
                        fontSize: Sizes.s16.sp, color: AppColor.darkGrey),
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
                            getDoctorAppointmentList[inx].patientAddress,
                            style: AppTextStyle.alertSubtitle,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

Widget completeAndCancel(String complete, String cancel,
    {GestureTapCallback? onTapComplete, GestureTapCallback? onTapCancel}) {
  return Row(
    children: [
      Expanded(
        child: InkWell(
          onTap: onTapComplete,
          child: Container(
            margin: EdgeInsets.only(right: 03),
            height: 50,
            decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(25))),
            child: Center(
                child: appText(complete,
                    style: AppTextStyle.buttonTextStyle,
                    textAlign: TextAlign.center)),
          ),
        ),
      ),
      Expanded(
        child: InkWell(
          onTap: onTapCancel,
          child: Container(
            margin: const EdgeInsets.only(left: 03),
            height: 50,
            decoration: const BoxDecoration(
                color: AppColor.red,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: Center(
                child: appText(cancel,
                    style: AppTextStyle.buttonTextStyle,
                    textAlign: TextAlign.center)),
          ),
        ),
      ),
    ],
  );
}
