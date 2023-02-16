import 'package:doctor_on_call/utils/file_utils.dart';
import 'package:doctor_on_call/utils/validation_mixin.dart';
import 'package:doctor_on_call/widget/primary_botton.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_sizes.dart';
import '../../../utils/app_text.dart';
import '../../../utils/app_text_style.dart';
import '../../../widget/custom_sized_box.dart';
import '../../../widget/primary_appbar.dart';
import '../../../widget/primary_textfield.dart';
import '../../../widget/scrollview.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen>
    with ValidationMixin {
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _patientName = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const SecondaryAppBar(
          title: "Book Appointment",
          isLeading: true,
        ),
        body: CustomScroll(
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
                    appText("Doctor Name", style: AppTextStyle.alertSubtitle),
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
                Expanded(
                  child: appText("Select Date"),
                ),
                appText("Next Week"),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(10, (index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.all(Sizes.s10),
                      padding: EdgeInsets.only(
                          top: Sizes.s14,
                          bottom: Sizes.s14,
                          left: Sizes.s16,
                          right: Sizes.s16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColor.primaryColor),
                      child: Column(
                        children: [
                          Text(
                            "Mon",
                            style: AppTextStyle.body1
                                .copyWith(color: AppColor.white),
                          ),
                          Text(
                            "01",
                            style: AppTextStyle.appBarTitle,
                          )
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBoxH34(),
            Row(
              children: [
                const Icon(Icons.calendar_today_outlined),
                appText("Select Time"),
              ],
            ),
            SizedBoxH34(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizes.s12),
                color: AppColor.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), //color of shadow
                    spreadRadius: 3, //spread radius
                    blurRadius: 5, // blur radius
                    offset: Offset(0, 3),
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
                ],
              ),
            ),
            SizedBoxH34(),
            PrimaryButton(lable: "Confirm Appointment", onPressed: () {})
          ],
        ));
  }
}
