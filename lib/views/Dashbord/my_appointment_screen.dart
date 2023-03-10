import 'package:date_picker_timeline/extra/color.dart';
import 'package:dio/dio.dart';
import 'package:doctor_on_call/services/api_services.dart';
import 'package:doctor_on_call/utils/app_text.dart';
import 'package:doctor_on_call/views/Dashbord/pending_appointmnet.dart';
import 'package:doctor_on_call/views/Dashbord/upcoming_appointment.dart';
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
import 'complete_appointmnet.dart';

class MyAppointmentScreen extends StatefulWidget {
  const MyAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<MyAppointmentScreen> createState() => _MyAppointmentScreenState();
}

class _MyAppointmentScreenState extends State<MyAppointmentScreen>
    with SingleTickerProviderStateMixin {
  // TabController? tabController;
  List<GetDoctorAppointmentList> getDoctorAppointmentList = [];
  String userTypeValue = "";

  @override
  void initState() {
    super.initState();
    getType();
    // tabController =
    //     TabController(length: 3, vsync: this, animationDuration: Duration.zero);

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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
                    // controller: tabController,
                    indicatorPadding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    // onTap: (index) {
                    //   if (index == 0) {
                    //     print("index  value is 0 here:=$index");
                    //     const PendingAppointment();
                    //   } else if (index == 1) {
                    //     print("index  value is 1 here:=$index");
                    //     const UpComingAppointment();
                    //   } else {
                    //     print("index  value is 2 here:=$index");
                    //     const CompleteAppointment();
                    //   }
                    // },
                    tabs: const [
                      Tab(text: "Pending"),
                      Tab(text: "Upcoming"),
                      Tab(text: "Completed"),
                    ],
                  ),
                ),
              )),
        ),
        body: TabBarView(physics: const NeverScrollableScrollPhysics(),
            // controller: tabController,
            children: const [
              PendingAppointment(),
              UpComingAppointment(),
              CompleteAppointment(),
            ]),
      ),
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
