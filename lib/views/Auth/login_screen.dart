import 'package:doctor_on_call/utils/app_sizes.dart';
import 'package:doctor_on_call/utils/validation_mixin.dart';
import 'package:doctor_on_call/views/Auth/forgot_password.dart';
import 'package:doctor_on_call/widget/primary_botton.dart';
import 'package:doctor_on_call/widget/primary_textfield.dart';
import 'package:flutter/material.dart';

import '../../utils/app_asset.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text.dart';
import '../../utils/app_text_style.dart';
import '../../widget/custom_sized_box.dart';
import '../../widget/scrollview.dart';

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
              validator: mobileNumberValidator,
              prefix: Icon(Icons.phone),
            ),
            SizedBoxH10(),
            appText("Password", style: AppTextStyle.lable),
            SizedBoxH8(),
            PrimaryTextField(
              controller: _password,
              validator: passwordValidator,
              prefix: Icon(Icons.password),
              suffix: GestureDetector(
                  onTap: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                  child: obscurePassword
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility)),
              obscureText: obscurePassword,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword()));
                    },
                    child:
                        appText("Forgot password?", style: AppTextStyle.lable))
              ],
            ),
            SizedBoxH8(),
            PrimaryButton(
                lable: "Login",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                }),
            SizedBoxH8(),
            GestureDetector(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  appText(
                    "You don’t have an account?",
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
