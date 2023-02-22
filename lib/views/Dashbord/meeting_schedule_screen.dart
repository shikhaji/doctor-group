import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:dio/dio.dart';
import 'package:doctor_on_call/services/api_services.dart';
import 'package:doctor_on_call/utils/app_text_style.dart';
import 'package:doctor_on_call/utils/validation_mixin.dart';
import 'package:doctor_on_call/widget/custom_sized_box.dart';
import 'package:doctor_on_call/widget/dailogs/city_picker.dart';
import 'package:doctor_on_call/widget/dailogs/state_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/city_model.dart';
import '../../models/get_days_model.dart';
import '../../models/get_time_slot_model.dart';
import '../../models/state_model.dart';
import '../../services/shared_referances.dart';
import '../../utils/app_color.dart';
import '../../utils/app_sizes.dart';
import '../../utils/app_text.dart';
import '../../utils/file_utils.dart';
import '../../widget/primary_appbar.dart';
import '../../widget/primary_botton.dart';
import '../../widget/primary_textfield.dart';
import '../../widget/scrollview.dart';

class MeetingSchedule extends StatefulWidget {
  const MeetingSchedule({Key? key}) : super(key: key);

  @override
  State<MeetingSchedule> createState() => _MeetingScheduleState();
}

class _MeetingScheduleState extends State<MeetingSchedule>
    with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _city = TextEditingController();

  StateModel stateModel = StateModel();
  CityModel cityModel = CityModel();
  List<GetTimeSlotList?> getTimeSlotList = [];
  List<GetDaysList?> getDaysList = [];
  var selectDay = "";

  List<String> selectTimeList = [];

  @override
  void initState() {
    super.initState();
    ApiService().getTimeSlotList().then((value) {
      getTimeSlotList = value!.data!;
      setState(() {});
    });
    ApiService().getDaysList().then((value) {
      getDaysList = value!.data;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Sizes.s16.h, vertical: Sizes.s28.h),
        child: PrimaryButton(
          lable: "Schedule Meeting",
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              if (selectDay == "") {
                Fluttertoast.showToast(
                  msg: 'Please Select Date',
                  backgroundColor: Colors.grey,
                );
              } else if (selectTimeList.isEmpty) {
                Fluttertoast.showToast(
                  msg: 'Please Select Time',
                  backgroundColor: Colors.grey,
                );
              } else {
                String? id = await Preferances.getString("userId");
                print("selectTimeList pass:=${selectTimeList}");
                FormData data() {
                  return FormData.fromMap({
                    "login_id":
                        id!.replaceAll('"', '').replaceAll('"', '').toString(),
                    "slot_id": selectTimeList,
                    "day_id": selectDay,
                    "state_id": stateModel.stateId,
                    "district_id": cityModel.districtId,
                  });
                }

                ApiService().addDoctorMeetingSchedule(context, data: data());
              }
            }
          },
        ),
      )),
      body: Form(
        key: _formKey,
        child: CustomScroll(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            appText(
              "Select Date",
              style: AppTextStyle.headingTextTile,
            ),
            SizedBoxH8(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(getDaysList.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      selectDay = getDaysList[index]!.dlId;
                      setState(() {});
                      print("Selected Days := ${getDaysList[index]!.dlId}");
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
                              color: Colors.grey
                                  .withOpacity(0.4), //color of shadow
                              spreadRadius: 2, //spread radius
                              blurRadius: 2, // blur radius
                              offset: Offset(0, 2),
                            )
                          ],
                          color: getDaysList[index]!.dlId == selectDay
                              ? AppColor.orange
                              : AppColor.white,
                          borderRadius: BorderRadius.circular(Sizes.s12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.check,
                                size: Sizes.s18,
                                color: getDaysList[index]!.dlId == selectDay
                                    ? AppColor.white
                                    : AppColor.white,
                              )
                            ],
                          ),
                          Text(
                            getDaysList[index]!.dlName,
                            style: getDaysList[index]!.dlId == selectDay
                                ? AppTextStyle.timeTitle
                                : AppTextStyle.timeTitle
                                    .copyWith(color: AppColor.black),
                          )
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBoxH34(),
            appText(
              "Select Time",
              style: AppTextStyle.headingTextTile,
            ),
            SizedBoxH8(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(getTimeSlotList.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      getTimeSlotList[index]!.selectTime =
                          !getTimeSlotList[index]!.selectTime;
                      setState(() {});
                      selectTimeList.add("${getTimeSlotList[index]!.dTSID}");

                      print("Selected selectTimeList := ${selectTimeList}");
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
                              color: Colors.grey
                                  .withOpacity(0.4), //color of shadow
                              spreadRadius: 2, //spread radius
                              blurRadius: 2, // blur radius
                              offset: Offset(0, 2),
                            )
                          ],
                          color: getTimeSlotList[index]?.selectTime == true
                              ? AppColor.orange
                              : AppColor.white,
                          borderRadius: BorderRadius.circular(Sizes.s12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.check,
                                size: Sizes.s18,
                                color:
                                    getTimeSlotList[index]!.selectTime == true
                                        ? AppColor.white
                                        : AppColor.white,
                              )
                            ],
                          ),
                          Text(
                            "${getTimeSlotList[index]!.dTSTIME}",
                            style: getTimeSlotList[index]!.selectTime == true
                                ? AppTextStyle.timeTitle
                                : AppTextStyle.timeTitle
                                    .copyWith(color: AppColor.black),
                          )
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBoxH20(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      appText("Select state", style: AppTextStyle.lable),
                      SizedBoxH8(),
                      PrimaryTextField(
                        controller: _state,
                        readOnly: true,
                        hintText: "Select State",
                        suffix: Icon(
                          Icons.arrow_drop_down,
                          size: Sizes.s30.h,
                        ),
                        onTap: () async {
                          stateModel = await StatePickerDailog.show(context);
                          _state.text = stateModel.stateName ?? '';
                          _city.clear();
                          setState(() {});
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please select state';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBoxW10(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      appText("Select city", style: AppTextStyle.lable),
                      SizedBoxH8(),
                      PrimaryTextField(
                        controller: _city,
                        hintText: "Select City",
                        readOnly: true,
                        suffix: Icon(
                          Icons.arrow_drop_down,
                          size: Sizes.s30.h,
                        ),
                        onTap: () async {
                          cityModel = await CityPickerDailog.show(
                              context, "${stateModel.stateId}");
                          _city.text = cityModel.districtName ?? '';
                          setState(() {});
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please select city';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBoxH34(),
            SizedBoxH34(),
            SizedBoxH34(),
          ],
        ),
      ),
      appBar: SecondaryAppBar(
        title: "Meeting Schedule",
        isLeading: true,
        leadingIcon: Icons.arrow_back_ios,
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
