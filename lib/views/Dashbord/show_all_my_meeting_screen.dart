import 'package:doctor_on_call/services/api_services.dart';
import 'package:flutter/material.dart';

import '../../models/get_doctor_appointment_by_days_model.dart';
import '../../models/get_doctor_appointment_district_model.dart';
import '../../models/get_doctor_appointment_time_slot_model.dart';
import '../../utils/app_color.dart';
import '../../utils/app_sizes.dart';
import '../../utils/app_text_style.dart';
import '../../widget/custom_sized_box.dart';
import '../../widget/primary_appbar.dart';
import '../../widget/scrollview.dart';

class ShowAllMyMeetingScreen extends StatefulWidget {
  const ShowAllMyMeetingScreen({Key? key}) : super(key: key);

  @override
  State<ShowAllMyMeetingScreen> createState() => _ShowAllMyMeetingScreenState();
}

class _ShowAllMyMeetingScreenState extends State<ShowAllMyMeetingScreen> {
  List<DoctorAppointmentDistrictList> doctorAppointmentDistrictList = [];
  List<DoctorAppointmentByDaysList> doctorAppointmentByDaysList = [];
  List<DoctorAppointmentTimeSlotList> doctorAppointmentTimeSlotList = [];
  String selectedDistrict = "";
  String selectedDay = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiService().getDoctorAppointmentDistrict().then((value) {
      if (value != null) {
        setState(() {
          doctorAppointmentDistrictList = value.achievement;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.white,
        body: SafeArea(
            child: CustomScroll(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBoxH28(),
            _buildDistrictView(),
            SizedBoxH28(),
            _buildDayView(),
            SizedBoxH28(),
            _buildTimeSlotView(),
          ],
        )),
        appBar: SecondaryAppBar(
          title: "Doctor all meeting",
          isLeading: true,
          onBackPressed: () {
            Navigator.pop(context);
          },
        ));
  }

  Widget _buildDistrictView() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(doctorAppointmentDistrictList.length, (index) {
          return GestureDetector(
            onTap: () {
              selectedDistrict =
                  doctorAppointmentDistrictList[index].districtId;
              doctorAppointmentTimeSlotList = [];

              setState(() {});
              ApiService()
                  .getDoctorAppointmentByDay(selectedDistrict)
                  .then((value) {
                setState(() {
                  doctorAppointmentByDaysList = value!.achievement;
                });
              });
            },
            child: Container(
                margin: const EdgeInsets.all(Sizes.s8),
                padding: const EdgeInsets.only(
                    top: Sizes.s12,
                    bottom: Sizes.s12,
                    left: Sizes.s12,
                    right: Sizes.s12),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4), //color of shadow
                        spreadRadius: 2, //spread radius
                        blurRadius: 2, // blur radius
                        offset: Offset(0, 2),
                      )
                    ],
                    color: doctorAppointmentDistrictList[index].districtId ==
                            selectedDistrict
                        ? AppColor.orange
                        : AppColor.white,
                    borderRadius: BorderRadius.circular(Sizes.s12)),
                child: Text(
                  doctorAppointmentDistrictList[index].districtName,
                  style: doctorAppointmentDistrictList[index].districtId ==
                          selectedDistrict
                      ? AppTextStyle.timeTitle
                      : AppTextStyle.timeTitle.copyWith(color: AppColor.black),
                )),
          );
        }),
      ),
    );
  }

  Widget _buildDayView() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(doctorAppointmentByDaysList.length, (index) {
          return GestureDetector(
            onTap: () {
              selectedDay = doctorAppointmentByDaysList[index].dlId;
              setState(() {});
              ApiService()
                  .getDoctorAppointmentTimeSlot(selectedDistrict, selectedDay)
                  .then((value) {
                setState(() {
                  doctorAppointmentTimeSlotList = value!.achievement;
                });
              });
            },
            child: Container(
                margin: const EdgeInsets.all(Sizes.s8),
                padding: const EdgeInsets.only(
                    top: Sizes.s12,
                    bottom: Sizes.s12,
                    left: Sizes.s12,
                    right: Sizes.s12),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4), //color of shadow
                        spreadRadius: 2, //spread radius
                        blurRadius: 2, // blur radius
                        offset: Offset(0, 2),
                      )
                    ],
                    color:
                        doctorAppointmentByDaysList[index].dlId == selectedDay
                            ? AppColor.orange
                            : AppColor.white,
                    borderRadius: BorderRadius.circular(Sizes.s12)),
                child: Text(
                  doctorAppointmentByDaysList[index].dlName,
                  style: doctorAppointmentByDaysList[index].dlId == selectedDay
                      ? AppTextStyle.timeTitle
                      : AppTextStyle.timeTitle.copyWith(color: AppColor.black),
                )),
          );
        }),
      ),
    );
  }

  Widget _buildTimeSlotView() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(doctorAppointmentTimeSlotList.length, (index) {
          return GestureDetector(
            onTap: () {},
            child: Container(
                margin: const EdgeInsets.all(Sizes.s8),
                padding: const EdgeInsets.only(
                    top: Sizes.s12,
                    bottom: Sizes.s12,
                    left: Sizes.s12,
                    right: Sizes.s12),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4), //color of shadow
                        spreadRadius: 2, //spread radius
                        blurRadius: 2, // blur radius
                        offset: Offset(0, 2),
                      )
                    ],
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(Sizes.s12)),
                child: Text(
                  doctorAppointmentTimeSlotList[index].dtsTime,
                  style: AppTextStyle.timeTitle.copyWith(color: AppColor.black),
                )),
          );
        }),
      ),
    );
  }
}
