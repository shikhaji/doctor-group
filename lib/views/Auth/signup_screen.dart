import 'package:dio/dio.dart';
import 'package:doctor_on_call/models/get_categories_list_model.dart';
import 'package:doctor_on_call/views/Auth/login_screen.dart';
import 'package:doctor_on_call/widget/dailogs/categories_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/categories_model.dart';
import '../../routs/arguments.dart';
import '../../services/api_services.dart';
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
  final SendArguments? arguments;
  const SignUpScreen({Key? key, this.arguments}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with ValidationMixin {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _referCode = TextEditingController();
  final TextEditingController _categories = TextEditingController();
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
            appText("Name", style: AppTextStyle.lable),
            SizedBoxH8(),
            PrimaryTextField(
              controller: _name,
              prefix: const Icon(Icons.perm_identity),
              hintText: "Enter your name",
            ),
            SizedBoxH10(),
            appText("Phone number", style: AppTextStyle.lable),
            SizedBoxH8(),
            PrimaryTextField(
              controller: _phone,
              keyboardInputType: TextInputType.phone,
              //validator: mobileNumberValidator,
              readOnly: true,
              prefix: const Icon(Icons.phone),
              hintText: "${widget.arguments?.phoneNumber}",
            ),
            SizedBoxH10(),
            appText("Password", style: AppTextStyle.lable),
            SizedBoxH8(),
            PrimaryTextField(
              hintText: "Enter password",
              controller: _password,
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
                  if (_formKey.currentState!.validate()) {
                    FormData data() {
                      return FormData.fromMap({
                        "name": _name.text.trim(),
                        "phone": widget.arguments?.phoneNumber,
                        "password": _password.text.trim(),
                        "referal_code": _referCode.text.trim(),
                        "categoryid": "${categoriesModel.ptId}",
                      });
                    }

                    ApiService().signUp(context, data: data());
                  }
                }),
          ],
        ),
      )),
    );
  }
}
