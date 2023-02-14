import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:doctor_on_call/services/api_services.dart';
import 'package:doctor_on_call/utils/app_text_style.dart';
import 'package:doctor_on_call/utils/validation_mixin.dart';
import 'package:doctor_on_call/widget/custom_sized_box.dart';
import 'package:doctor_on_call/widget/dailogs/city_picker.dart';
import 'package:doctor_on_call/widget/dailogs/state_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/city_model.dart';
import '../../models/get_days_model.dart';
import '../../models/get_time_slot_model.dart';
import '../../models/state_model.dart';
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
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final ValueNotifier<TimeOfDay?> startTime = ValueNotifier(null);
  final ValueNotifier<TimeOfDay?> endTime = ValueNotifier(null);
  StateModel stateModel = StateModel();
  CityModel cityModel = CityModel();
  List<GetTimeSlotList?> getTimeSlotList = [];
  List<GetDaysList?> getDaysList = [];
  var selectDay = "";

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
      body: CustomScroll(
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
                    // getDaysList[index]!.selectTime =
                    // !getDaysList[index]!.selectTime;
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
                            color:
                                Colors.grey.withOpacity(0.4), //color of shadow
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
                    print(
                        "Selected Time := ${getTimeSlotList[index]!.dTSTIME}");
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
                            color:
                                Colors.grey.withOpacity(0.4), //color of shadow
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
                              color: getTimeSlotList[index]!.selectTime == true
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
          // Row(
          //   children: [
          //     ValueListenableBuilder(
          //       valueListenable: startTime,
          //       builder:
          //           (BuildContext context, TimeOfDay? value, Widget? child) {
          //         return Flexible(
          //             child: PrimaryTextField(
          //           controller: startTimeController,
          //           validator: startTimeValidation,
          //           hintText: startTime.value == null
          //               ? "Start Time"
          //               : startTimeController.text,
          //           readOnly: true,
          //           onTap: () async {
          //             startTime.value = await FileUtils.pickTime(context);
          //
          //             startTimeController.text =
          //                 startTime.value!.format(context);
          //           },
          //         ));
          //       },
          //     ),
          //     SizedBox(
          //       width: Sizes.s8.w,
          //     ),
          //     ValueListenableBuilder(
          //       valueListenable: endTime,
          //       builder:
          //           (BuildContext context, TimeOfDay? value, Widget? child) {
          //         return Flexible(
          //             child: PrimaryTextField(
          //           controller: endTimeController,
          //           validator: endTimeValidation,
          //           hintText: endTime.value == null
          //               ? "End Time"
          //               : endTimeController.text,
          //           readOnly: true,
          //           onTap: () async {
          //             endTime.value = await FileUtils.pickTime(context);
          //
          //             endTimeController.text = endTime.value!.format(context);
          //           },
          //         ));
          //       },
          //     ),
          //   ],
          // ),
          SizedBoxH20(),
          Row(
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
          PrimaryButton(
            lable: "Schedule Meeting",
            onPressed: () {},
          )
        ],
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
