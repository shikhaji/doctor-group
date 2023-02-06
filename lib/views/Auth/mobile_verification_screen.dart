import 'package:dio/dio.dart';
import 'package:doctor_on_call/routs/arguments.dart';
import 'package:doctor_on_call/services/api_services.dart';
import 'package:doctor_on_call/views/Auth/login_screen.dart';
import 'package:doctor_on_call/views/Auth/otp_verification_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../routs/app_routs.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text.dart';
import '../../utils/app_text_style.dart';
import '../../utils/validation_mixin.dart';
import '../../widget/custom_sized_box.dart';
import '../../widget/primary_botton.dart';
import '../../widget/primary_textfield.dart';
import '../../widget/scrollview.dart';

class MobileVerificationScreen extends StatefulWidget {
  const MobileVerificationScreen({Key? key}) : super(key: key);

  @override
  State<MobileVerificationScreen> createState() =>
      _MobileVerificationScreenState();
}

class _MobileVerificationScreenState extends State<MobileVerificationScreen>
    with ValidationMixin {
  final TextEditingController _phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: CustomScroll(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBoxH34(),
            SizedBoxH34(),
            SizedBoxH34(),
            Center(
              child: appText("Doctor on call",
                  style: AppTextStyle.appName
                      .copyWith(color: AppColor.primaryColor)),
            ),
            SizedBoxH28(),
            SizedBoxH28(),
            appText("Mobile Verification", style: AppTextStyle.title),
            SizedBoxH6(),
            appText("Please verify your mobile number first",
                style: AppTextStyle.subTitle),
            SizedBoxH28(),
            appText("Phone number", style: AppTextStyle.lable),
            SizedBoxH8(),
            PrimaryTextField(
              controller: _phone,
              validator: mobileNumberValidator,
              keyboardInputType: TextInputType.phone,
              prefix: const Icon(Icons.phone),
              hintText: "Enter phone number",
            ),
            SizedBoxH8(),
            PrimaryButton(
                lable: "Send OTP",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    FormData data() {
                      return FormData.fromMap({
                        "mobile": _phone.text.trim(),
                      });
                    }

                    ApiService()
                        .mobileVerifyApi(context, data: data())
                        .then((value) {
                      if (value!.status == 200) {
                        if (value.count == 0) {
                          print("number //  7990934053");
                          Navigator.pushNamed(context, Routs.otp,
                              arguments: OtpArguments(
                                  phoneNumber: _phone.text.trim()));
                        } else if (value.count == 1) {
                          Fluttertoast.showToast(
                            msg: 'Your number is already register please login',
                            backgroundColor: Colors.grey,
                          );
                        }
                      }
                    });
                  }
                }),
            SizedBoxH18(),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routs.login);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  appText(
                    "Already have an account? ",
                    style: AppTextStyle.subTitle,
                  ),
                  appText(
                    "Login",
                    style: AppTextStyle.redTextStyle
                        .copyWith(color: AppColor.primaryLightColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
