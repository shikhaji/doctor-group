import 'package:doctor_on_call/models/get_categories_list_model.dart';
import 'package:doctor_on_call/views/Auth/login_screen.dart';
import 'package:doctor_on_call/widget/dailogs/categories_picker.dart';
import 'package:flutter/material.dart';

import '../../models/categories_model.dart';
import '../../utils/app_color.dart';
import '../../utils/app_sizes.dart';
import '../../utils/app_text.dart';
import '../../utils/app_text_style.dart';
import '../../utils/validation_mixin.dart';
import '../../widget/custom_sized_box.dart';
import '../../widget/primary_botton.dart';
import '../../widget/primary_textfield.dart';
import '../../widget/scrollview.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with ValidationMixin {
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _referCode = TextEditingController();
  final TextEditingController _categories = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  bool obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  CategoriesModel categoriesModel = CategoriesModel();
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
            Center(
              child: appText("Doctor on call",
                  style: AppTextStyle.appName
                      .copyWith(color: AppColor.primaryColor)),
            ),
            SizedBoxH28(),
            appText("Sign Up", style: AppTextStyle.title),
            SizedBoxH6(),
            appText("Fill your details to continue",
                style: AppTextStyle.subTitle),
            SizedBoxH28(),
            appText("Phone number", style: AppTextStyle.lable),
            SizedBoxH8(),
            PrimaryTextField(
              controller: _phone,
              validator: mobileNumberValidator,
              prefix: Icon(Icons.phone),
              hintText: "Enter phone number",
            ),
            SizedBoxH10(),
            appText("Password", style: AppTextStyle.lable),
            SizedBoxH8(),
            PrimaryTextField(
              hintText: "Enter password",
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
            SizedBoxH10(),
            appText("Confirm Password", style: AppTextStyle.lable),
            SizedBoxH8(),
            PrimaryTextField(
              controller: _confirmPassword,
              prefix: const Icon(Icons.password),
              validator: (value) {
                return confirmPasswordValidator(value!, _password.text.trim());
              },
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
              hintText: "Enter confirm password",
            ),
            SizedBoxH10(),
            appText("Select Categories", style: AppTextStyle.lable),
            SizedBoxH8(),
            PrimaryTextField(
              controller: _categories,
              hintText: "Select Categories",
              suffix: Icon(
                Icons.arrow_drop_down,
                size: Sizes.s30.h,
              ),
              keyboardInputType: TextInputType.text,
              readOnly: true,
              onTap: () async {
                categoriesModel = await CategoriesPickerDailog.show(context);
                _categories.text = categoriesModel.ptName ?? '';
                setState(() {});
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please select categories';
                } else {
                  return null;
                }
              },
            ),
            appText("Refer Code", style: AppTextStyle.lable),
            SizedBoxH8(),
            PrimaryTextField(
              controller: _referCode,
              hintText: "Enter refer code",
            ),
            SizedBoxH8(),
            PrimaryButton(
                lable: "Sign Up",
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => LoginScreen()));
                  print("_categories:=${categoriesModel.ptId}");
                  if (_formKey.currentState!.validate()) {}
                }),
          ],
        ),
      )),
    );
  }
}
