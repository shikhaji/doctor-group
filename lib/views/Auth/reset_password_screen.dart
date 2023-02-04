import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../routs/arguments.dart';
import '../../services/api_services.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text.dart';
import '../../utils/app_text_style.dart';
import '../../utils/validation_mixin.dart';
import '../../widget/custom_sized_box.dart';
import '../../widget/primary_botton.dart';
import '../../widget/primary_textfield.dart';
import '../../widget/scrollview.dart';

class ResetPasswordScreen extends StatefulWidget {
  final OtpArguments? arguments;
  const ResetPasswordScreen({Key? key, this.arguments}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with ValidationMixin {

  final TextEditingController _password = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
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
            appText("Enter new password here", style: AppTextStyle.subTitle),
            SizedBoxH28(),

            appText("New Password", style: AppTextStyle.lable),
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
            SizedBoxH10(),
            appText("Confirm Password", style: AppTextStyle.lable),
            SizedBoxH8(),
            PrimaryTextField(
              controller: _confirmPassword,
              hintText: "Enter confirm password",
              validator: (value) {
                return confirmPasswordValidator(value!, _password.text.trim());
              },
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
                  if (_formKey.currentState!.validate()) {
                    debugPrint("${widget.arguments?.phoneNumber}");
                    debugPrint("password ${_password.text.trim()}");
                    FormData data() {
                      return FormData.fromMap({
                        "phone": widget.arguments?.phoneNumber,
                        "password": _password.text.trim(),
                      });
                    }


                    ApiService().updatePassword(context, data: data());
                  }
                }),
          ],
        ),
      )),
    );
  }
}
