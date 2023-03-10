import 'package:dio/dio.dart';
import 'package:doctor_on_call/services/api_services.dart';
import 'package:doctor_on_call/utils/validation_mixin.dart';
import 'package:doctor_on_call/widget/primary_botton.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../../../models/get_days_model.dart';
import '../../../models/get_profile_model.dart';
import '../../../models/get_time_slot_by_doctor_model.dart';
import '../../../routs/arguments.dart';
import '../../../services/shared_referances.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_sizes.dart';
import '../../../utils/app_text.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/file_utils.dart';
import '../../../widget/custom_sized_box.dart';
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
  final ValueNotifier<DateTime?> selectDate = ValueNotifier(null);
  final TextEditingController selectDateController = TextEditingController();

  List<GetDaysList?> getDaysList = [];
  List<TimeSlotByDoctorList?> timeSlotByDoctorList = [];
  var selectDay = "0";
  String appointmentDate = "";
  var selectTime = "";
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getProfile();
    ApiService().getDaysList().then((value) {
      getDaysList = value!.data;
      setState(() {});
    });
  }

  GetProfileData? getProfileData;

  Future<void> getProfile() async {
    String? id = await Preferances.getString("userId");
    ApiService()
        .getProfileData(id!.replaceAll('"', '').replaceAll('"', '').toString())
        .then((value) {
      if (value != null) {
        setState(() {
          getProfileData = value.profile;
        });
      }
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
                        appText("Dr. ${widget.arguments?.doctorName}",
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
                Row(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: selectDate,
                      builder: (BuildContext context, DateTime? value,
                          Widget? child) {
                        return Flexible(
                            child: PrimaryTextField(
                          validator: pickupDateValidation,
                          readOnly: true,
                          controller: selectDateController,
                          hintText: selectDate.value == null
                              ? "Please select date"
                              : selectDateController.text,
                          onTap: () async {
                            selectDate.value =
                                await FileUtils.pickDate(context);
                            selectDateController.text = FileUtils.getFormatDate(
                                selectDate.value
                                    .toString()); //   debugPrint(pickedDate.value);
                          },
                        ));
                      },
                      //  child:
                    ),
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
                          print("selectDay:=${selectDay}");
                          print(
                              "district_id:=${getProfileData?.branchDistrictId}");
                          print("doctorid:=${widget.arguments!.doctorId}");
                          print("appointment_slot:=${selectTime}");
                          print("loginid:=${id}");
                          FormData data() {
                            return FormData.fromMap({
                              "doctorid": widget.arguments!.doctorId,
                              "patient_name": _patientName.text.trim(),
                              "patient_mobile": _phoneNumber.text.trim(),
                              "patient_address": _address.text.trim(),
                              "appointment_slot": selectTime,
                              "appointment_type": 1,
                              "loginid": id!
                                  .replaceAll('"', '')
                                  .replaceAll('"', '')
                                  .toString(),
                              "desc": _des.text.trim(),
                              "district_id": getProfileData?.branchDistrictId,
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
              print("selectedDate here:=${selectDate.value}");

              if (selectDate.value != null) {
                selectDay = getDaysList[index]!.dlId;
                setState(() {});
                print("doctorid here:=${widget.arguments!.doctorId}");
                print("day id here:=${getDaysList[index]!.dlId}");
                print(
                    "selectedDate here:=${DateFormat('yyyy-MM-dd').format(DateTime.parse(selectDate.value.toString())).toString()}");
                print(
                    "branchdistrickId here:=${getProfileData?.branchDistrictId}");
                ApiService()
                    .getTimeSlotByDoctor(context,
                        data: FormData.fromMap({
                          "doctorid": widget.arguments!.doctorId,
                          "dayid": getDaysList[index]!.dlId,
                          "date": DateFormat('yyyy-MM-dd')
                              .format(
                                  DateTime.parse(selectDate.value.toString()))
                              .toString(),
                          "cityid": getProfileData?.branchDistrictId,
                        }))
                    .then((value) {
                  setState(() {
                    timeSlotByDoctorList = value!.data;
                  });
                });
              } else {
                Fluttertoast.showToast(
                  msg: 'First select date',
                  backgroundColor: Colors.grey,
                );
              }
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
    return timeSlotByDoctorList.isEmpty
        ? Center(
            child: Text(
              "Not Available",
              style: AppTextStyle.redTextStyle.copyWith(color: Colors.red),
            ),
          )
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(timeSlotByDoctorList.length, (index) {
                return GestureDetector(
                  onTap: () {
                    selectTime = timeSlotByDoctorList[index]!.dmsId;
                    setState(() {});
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
                              color: timeSlotByDoctorList[index]!.dmsId ==
                                      selectTime
                                  ? AppColor.white
                                  : AppColor.white,
                            )
                          ],
                        ),
                        Text(
                          "${timeSlotByDoctorList[index]!.dtsTime}",
                          style:
                              timeSlotByDoctorList[index]!.dmsId == selectTime
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
