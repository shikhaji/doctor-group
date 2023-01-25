import 'package:doctor_on_call/views/Auth/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import '../../utils/app_color.dart';
import '../../utils/app_text.dart';
import '../../utils/app_text_style.dart';
import '../../utils/validation_mixin.dart';
import '../../widget/custom_sized_box.dart';
import '../../widget/primary_botton.dart';
import '../../widget/primary_textfield.dart';
import '../../widget/scrollview.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> with ValidationMixin{

  TextEditingController _controller = TextEditingController(text: "");
  int pinLength = 6;
  int _seconds = -1;

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
                appText("OTP Verification", style: AppTextStyle.title),
                SizedBoxH6(),
                appText("Enter 6 digit code sent to your phone number",
                    style: AppTextStyle.subTitle),
                SizedBoxH28(),
                appText("Enter OTP", style: AppTextStyle.lable),
                SizedBoxH8(),
                PinCodeTextField(
                  autofocus: false,
                  controller: _controller,
                  hideCharacter: false,
                  highlight: false,
                  highlightColor: Theme.of(context).cardColor,
                  defaultBorderColor: Theme.of(context).cardColor,
                  hasTextBorderColor: Theme.of(context).cardColor,
                  highlightPinBoxColor: Theme.of(context).cardColor,
                  pinBoxColor: AppColor.textFieldColor,
                  maxLength: pinLength,
                  onDone: (text) {
                    _controller.text = text;
                  },
                  pinBoxWidth: 45,
                  pinBoxHeight: 55,
                  hasUnderline: false,
                  pinBoxRadius: 10,
                  wrapAlignment: WrapAlignment.spaceAround,

                  pinBoxDecoration:
                  ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                  pinTextStyle: TextStyle(fontSize: 22.0),
                  pinTextAnimatedSwitcherTransition:
                  ProvidedPinBoxTextAnimation.scalingTransition,
                  pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
                  highlightAnimationBeginColor: Theme.of(context).cardColor,
                  highlightAnimationEndColor: Theme.of(context).cardColor,
                  keyboardType: TextInputType.number,
                ),
                SizedBoxH20(),
                PrimaryButton(lable: "Verify OTP", onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>SignUpScreen()));
                  if(_formKey.currentState!.validate()){
                  }
                }),
              ],
            ),
          )),
    );
  }
}
