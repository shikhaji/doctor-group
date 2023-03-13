import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../routs/app_routs.dart';
import '../../routs/arguments.dart';
import '../../services/api_services.dart';
import '../../utils/app_asset.dart';
import '../../utils/app_color.dart';
import '../../utils/app_sizes.dart';
import '../../utils/app_text.dart';
import '../../utils/app_text_style.dart';
import '../../utils/validation_mixin.dart';
import '../../widget/custom_sized_box.dart';
import '../../widget/primary_botton.dart';
import '../../widget/primary_textfield.dart';
import '../../widget/scrollview.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> with ValidationMixin {
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
              child: Image.asset(
                AppAsset.logo,
                height: Sizes.s150,
              ),
            ),
            SizedBoxH28(),
            SizedBoxH28(),
            appText("Forgot Password", style: AppTextStyle.title),
            SizedBoxH6(),
            appText(
                "Enter registered phone number and we will send you an otp to your phone number.",
                style: AppTextStyle.subTitle),
            SizedBoxH28(),
            appText("Phone number", style: AppTextStyle.lable),
            SizedBoxH8(),
            PrimaryTextField(
              controller: _phone,
              validator: mobileNumberValidator,
              prefix: Icon(Icons.phone),
              keyboardInputType: TextInputType.phone,
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
                        if (value.count == 1) {
                          Navigator.pushNamed(
                            context,
                            Routs.otp,
                            arguments: SendArguments(
                                phoneNumber: _phone.text.trim(), otpStatus: 1),
                          );
                        } else if (value.count == 0) {
                          Fluttertoast.showToast(
                            msg: 'Your number is not registered',
                            backgroundColor: Colors.grey,
                          );
                        }
                      }
                    });
                  }
                }),
            SizedBoxH8(),
          ],
        ),
      )),
    );
  }
}
