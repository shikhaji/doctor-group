import 'package:doctor_on_call/routs/app_routs.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
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

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen>
    with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _state = TextEditingController();
  var genderValue = "Male";
  String genderInitialValue = 'Male';
  var gender = ["Male", "Female"];

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
            appText("Update profile", style: AppTextStyle.title),
            SizedBoxH6(),
            appText("Update your profile and continue",
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
              controller: _email,
              keyboardInputType: TextInputType.emailAddress,
              validator: emailValidator,
              prefix: const Icon(Icons.phone),
              hintText: "Enter email address",
            ),
            SizedBoxH10(),
            appText("Enter address", style: AppTextStyle.lable),
            SizedBoxH8(),
            PrimaryTextField(
              hintText: "Enter address",
              controller: _address,
              validator: addressValidation,
            ),
            appText("Select gender", style: AppTextStyle.lable),
            SizedBoxH8(),
            genderList(),
            SizedBoxH10(),
            SizedBoxH10(),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      appText("Select state", style: AppTextStyle.lable),
                      SizedBoxH8(),
                      PrimaryTextField(
                        controller: _state,
                        hintText: "Select State",
                        suffix: Icon(
                          Icons.arrow_drop_down,
                          size: Sizes.s30.h,
                        ),
                        onTap: () async {
                          // categoriesModel = await CategoriesPickerDailog.show(context);
                          // _categories.text = categoriesModel.ptName ?? '';
                          setState(() {});
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please select state';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBoxW10(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      appText("Select city", style: AppTextStyle.lable),
                      SizedBoxH8(),
                      PrimaryTextField(
                        controller: _city,
                        hintText: "Select Categories",
                        suffix: Icon(
                          Icons.arrow_drop_down,
                          size: Sizes.s30.h,
                        ),
                        onTap: () async {
                          // categoriesModel = await CategoriesPickerDailog.show(context);
                          // _categories.text = categoriesModel.ptName ?? '';
                          setState(() {});
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please select city';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBoxH8(),
            PrimaryButton(
                lable: "Save",
                onPressed: () {
                  Navigator.pushNamed(context, Routs.mainHome);
                  if (_formKey.currentState!.validate()) {
                    // FormData data() {
                    //   return FormData.fromMap({
                    //     "name": _name.text.trim(),
                    //     "email": _email.text.trim(),
                    //     "loginid": "",
                    //     "gender": genderValue.trim(),
                    //     "address": _address.text.trim(),
                    //     "city": "",
                    //     "state": "",
                    //   });
                    // }

                    //ApiService().signUp(context, data: data());
                  }
                }),
          ],
        ),
      )),
    );
  }

  Widget genderList() {
    return Container(
      width: double.infinity,
      height: Sizes.s60.h,
      padding: EdgeInsets.all(Sizes.s16.h),
      decoration: BoxDecoration(
        color: AppColor.textFieldColor,
        borderRadius: BorderRadius.circular(Sizes.s12.r),
      ),
      child: DropdownButton(
        iconEnabledColor: AppColor.grey,
        style: AppTextStyle.textFieldFont,
        dropdownColor: AppColor.textFieldColor,
        focusColor: AppColor.grey,
        elevation: 0,
        underline: const SizedBox(),
        value: genderInitialValue,
        isExpanded: true,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: gender.map((String items) {
          return DropdownMenuItem(
            child: Text(
              '${items}',
              style: AppTextStyle.textFieldFont,
            ),
            value: items != null ? items : "",
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            genderInitialValue = value!;
            print(value);
            genderValue = value;
          });
        },
      ),
    );
  }
}
