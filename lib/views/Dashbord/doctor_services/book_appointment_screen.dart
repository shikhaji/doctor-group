import 'package:dio/dio.dart';
import 'package:doctor_on_call/models/get_time_slot_model.dart';
import 'package:doctor_on_call/services/api_services.dart';
import 'package:doctor_on_call/utils/file_utils.dart';
import 'package:doctor_on_call/utils/validation_mixin.dart';
import 'package:doctor_on_call/widget/primary_botton.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../models/get_days_model.dart';
import '../../../models/get_time_slot_by_doctor_model.dart';
import '../../../models/state_model.dart';
import '../../../routs/arguments.dart';
import '../../../services/shared_referances.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_sizes.dart';
import '../../../utils/app_text.dart';
import '../../../utils/app_text_style.dart';
import '../../../widget/custom_sized_box.dart';
import '../../../widget/dailogs/state_picker.dart';
import '../../../widget/primary_appbar.dart';
import '../../../widget/primary_textfield.dart';
import '../../../widget/scrollview.dart';

class BookAppointmentScreen extends StatefulWidget {
  final SendArguments? arguments;
  const BookAppointmentScreen({Key? key, this.arguments}) : super(key: key);

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen>
    with ValidationMixin {
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _patientName = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _des = TextEditingController();
  final TextEditingController _state = TextEditingController();
  List<GetDaysList?> getDaysList = [];
  List<TimeSlotByDoctorList?> timeSlotByDoctorList = [];
  var selectDay = "1";
  var selectTime = "";
  final _formKey = GlobalKey<FormState>();
  StateModel stateModel = StateModel();
  @override
  void initState() {
    super.initState();
    ApiService().getDaysList().then((value) {
      getDaysList = value!.data;
      setState(() {});
    });
    ApiService()
        .getTimeSlotByDoctor(context,
            data: FormData.fromMap({
              "doctorid": widget.arguments!.doctorId,
              "dayid": 1,
            }))
        .then((value) {
      setState(() {
        print("index 1 data:=${value!.data.length}");
        timeSlotByDoctorList = value.data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const SecondaryAppBar(
          title: "Book Appointment",
          isLeading: true,
        ),
        body: Form(
            key: _formKey,
            child: CustomScroll(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        appText("Doctor Name",
                            style: AppTextStyle.alertSubtitle),
                        appText("Dr.Hina  Patel",
                            style: AppTextStyle.appBarTextTitle)
                      ],
                    )),
                    appText("rs.300/-",
                        style: AppTextStyle.redTextStyle
                            .copyWith(fontSize: Sizes.s20)),
                  ],
                ),
                SizedBoxH34(),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined),
                    SizedBoxW6(),
                    appText("Select Date", style: AppTextStyle.lable),
                  ],
                ),
                SizedBoxH10(),
                _buildDateView(),
                SizedBoxH34(),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined),
                    SizedBoxW6(),
                    appText("Select Time", style: AppTextStyle.lable),
                  ],
                ),
                SizedBoxH10(),
                _buildTimeView(),
                SizedBoxH34(),
                _buildFormView(),
                SizedBoxH34(),
                PrimaryButton(
                    lable: "Confirm Appointment",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (selectDay == "") {
                          Fluttertoast.showToast(
                            msg: 'Please Select Date',
                            backgroundColor: Colors.grey,
                          );
                        } else if (selectTime == "") {
                          Fluttertoast.showToast(
                            msg: 'Please Select Time',
                            backgroundColor: Colors.grey,
                          );
                        } else {
                          String? id = await Preferances.getString("userId");
                          print("doctorid${widget.arguments!.doctorId}");
                          print("patient_name${_patientName.text.trim()}");
                          print("patient_mobile${_phoneNumber.text.trim()}");
                          print("desc${_des.text.trim()}");
                          print("patient_address${_address.text.trim()}");
                          print("appointment_slot${selectTime}");
                          print("district_id${stateModel.stateId}");
                          print("appointment_date${selectDay}");
                          print(
                              "loginid${id!.replaceAll('"', '').replaceAll('"', '').toString()}");

                          FormData data() {
                            return FormData.fromMap({
                              "doctorid": widget.arguments!.doctorId,
                              "patient_name": _patientName.text.trim(),
                              "patient_mobile": _phoneNumber.text.trim(),
                              "patient_address": _address.text.trim(),
                              "appointment_slot": selectTime,
                              "appointment_type": 1,
                              "loginid": id
                                  .replaceAll('"', '')
                                  .replaceAll('"', '')
                                  .toString(),
                              "desc": _des.text.trim(),
                              "district_id": stateModel.stateId,
                              "appointment_date": selectDay,
                            });
                          }

                          ApiService().addDoctorBooking(context, data: data());
                        }
                      }
                    })
              ],
            )));
  }

  Widget _buildDateView() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(getDaysList.length, (index) {
          return GestureDetector(
            onTap: () {
              selectDay = getDaysList[index]!.dlId;
              setState(() {});
              ApiService()
                  .getTimeSlotByDoctor(context,
                      data: FormData.fromMap({
                        "doctorid": widget.arguments!.doctorId,
                        "dayid": getDaysList[index]!.dlId,
                      }))
                  .then((value) {
                setState(() {
                  timeSlotByDoctorList = value!.data;
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
    );
  }

  Widget _buildTimeView() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(timeSlotByDoctorList.length, (index) {
          print("timeSlotByDoctorList.length:-${timeSlotByDoctorList.length}");
          return GestureDetector(
            onTap: () {
              selectTime = timeSlotByDoctorList[index]!.dmsId;
              setState(() {});

              print("Selected selectTime := ${selectTime}");
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
                      offset: const Offset(0, 2),
                    )
                  ],
                  color: timeSlotByDoctorList[index]!.dmsId == selectTime
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
                        color: timeSlotByDoctorList[index]!.dmsId == selectTime
                            ? AppColor.white
                            : AppColor.white,
                      )
                    ],
                  ),
                  Text(
                    "${timeSlotByDoctorList[index]!.dtsTime}",
                    style: timeSlotByDoctorList[index]!.dmsId == selectTime
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
    );
  }

  Widget _buildFormView() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.s12),
          color: AppColor.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), //color of shadow
              spreadRadius: 3, //spread radius
              blurRadius: 5, // blur radius
              offset: const Offset(0, 3),
            )
          ],
        ),
        padding: const EdgeInsets.only(
            top: Sizes.s24,
            bottom: Sizes.s24,
            left: Sizes.s12,
            right: Sizes.s12),
        child: Column(
          children: [
            PrimaryTextField(
              controller: _phoneNumber,
              hintText: "Enter Mobile No.",
              validator: mobileNumberValidator,
              prefix: const Icon(Icons.phone),
              keyboardInputType: TextInputType.phone,
            ),
            PrimaryTextField(
              controller: _patientName,
              hintText: "Enter Patient Name",
              validator: patientNameValidation,
              prefix: const Icon(Icons.person),
            ),
            PrimaryTextField(
              controller: _address,
              hintText: "Enter Address",
              validator: addressValidation,
              prefix: const Icon(Icons.home),
            ),
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
            PrimaryTextField(
              controller: _des,
              maxLines: 5,
              hintText: "Enter Description",
              validator: descriptionValidation,
              // prefix: const Icon(Icons.note),
            ),
          ],
        ),
      ),
    );
  }
}
