import 'package:dio/dio.dart';
import 'package:doctor_on_call/utils/app_sizes.dart';
import 'package:doctor_on_call/utils/validation_mixin.dart';
import 'package:doctor_on_call/views/Auth/forgot_password_screen.dart';
import 'package:doctor_on_call/views/Auth/mobile_verification_screen.dart';
import 'package:doctor_on_call/views/Auth/signup_screen.dart';
import 'package:doctor_on_call/views/Dashbord/main_home_screen.dart';
import 'package:doctor_on_call/widget/primary_botton.dart';
import 'package:doctor_on_call/widget/primary_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../services/api_services.dart';
import '../../utils/app_asset.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text.dart';
import '../../utils/app_text_style.dart';
import '../../widget/custom_sized_box.dart';
import '../../widget/scrollview.dart';
import '../Dashbord/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ValidationMixin {
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool obscurePassword = true;
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
            appText("Login", style: AppTextStyle.title),
            SizedBoxH6(),
            appText("Please login with phone number and password",
                style: AppTextStyle.subTitle),
            SizedBoxH28(),
            appText("Phone number", style: AppTextStyle.lable),
            SizedBoxH8(),
            PrimaryTextField(
              controller: _phone,
              hintText: "Enter phone number",
              validator: mobileNumberValidator,
              prefix: const Icon(Icons.phone),
              keyboardInputType: TextInputType.phone,
            ),
            SizedBoxH10(),
            appText("Password", style: AppTextStyle.lable),
            SizedBoxH8(),
            PrimaryTextField(
              controller: _password,
              hintText: "Enter password",
              validator: passwordValidator,
              prefix: const Icon(Icons.password),
              suffix: GestureDetector(
                  onTap: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                  child: obscurePassword
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility)),
              obscureText: obscurePassword,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword()));
                    },
                    child:
                        appText("Forgot password?", style: AppTextStyle.lable))
              ],
            ),
            SizedBoxH8(),
            PrimaryButton(
                lable: "Login",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    FormData data() {
                      return FormData.fromMap({
                        "user_id": _phone.text.trim(),
                        "password": _password.text.trim(),
                      });
                    }

                    ApiService().login(context, data: data());
                  }
                }),
            SizedBoxH8(),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  appText(
                    "You don’t have an account? ",
                    style: AppTextStyle.subTitle,
                  ),
                  appText(
                    "Sign Up",
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
