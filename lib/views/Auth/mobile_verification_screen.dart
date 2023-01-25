import 'package:doctor_on_call/views/Auth/otp_verification_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  State<MobileVerificationScreen> createState() => _MobileVerificationScreenState();
}

class _MobileVerificationScreenState extends State<MobileVerificationScreen> with ValidationMixin {
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
                SizedBoxH34(),  SizedBoxH34(),
                Center(
                  child: appText("Doctor on call", style: AppTextStyle.appName.copyWith(color: AppColor.primaryColor)),
                ),
                SizedBoxH28(), SizedBoxH28(),
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
                  prefix: Icon(Icons.phone),
                ),
                SizedBoxH8(),
                PrimaryButton(lable: "Send OTP", onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>OtpVerificationScreen()));
                  if(_formKey.currentState!.validate()){
                  }
                }),
                SizedBoxH8(),
              ],
            ),
          )),
    );
  }
}
