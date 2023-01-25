import 'package:flutter/material.dart';

import '../../utils/app_color.dart';
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

class _ForgotPasswordState extends State<ForgotPassword> with ValidationMixin{
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();
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
                appText("Reset Password", style: AppTextStyle.title),
                SizedBoxH6(),
                appText("Enter new password here",
                    style: AppTextStyle.subTitle),
                SizedBoxH28(),
                appText("New Password", style: AppTextStyle.lable),
                SizedBoxH8(),
                PrimaryTextField(
                  controller: _password,
                  validator: mobileNumberValidator,
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
                SizedBoxH10(),
                appText("Confirm Password", style: AppTextStyle.lable),
                SizedBoxH8(),
                PrimaryTextField(
                  controller: _confirmpassword,
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

                SizedBoxH8(),
                PrimaryButton(
                    lable: "Reset",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {}
                    }),

              ],
            ),
          )),
    );
  }
}
