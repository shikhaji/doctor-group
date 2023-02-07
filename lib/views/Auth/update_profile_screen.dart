import 'package:doctor_on_call/models/gender_model.dart';
import 'package:doctor_on_call/models/state_model.dart';
import 'package:doctor_on_call/routs/app_routs.dart';
import 'package:doctor_on_call/widget/dailogs/city_picker.dart';
import 'package:doctor_on_call/widget/dailogs/gender_picker.dart';
import 'package:doctor_on_call/widget/dailogs/state_picker.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import '../../models/city_model.dart';
import '../../models/sub_categories_model.dart';
import '../../routs/arguments.dart';
import '../../services/api_services.dart';
import '../../utils/app_color.dart';
import '../../utils/app_sizes.dart';
import '../../utils/app_text.dart';
import '../../utils/app_text_style.dart';
import '../../utils/validation_mixin.dart';
import '../../widget/custom_sized_box.dart';
import '../../widget/dailogs/sub_categories_picker.dart';
import '../../widget/primary_botton.dart';
import '../../widget/primary_textfield.dart';
import '../../widget/scrollview.dart';

class UpdateProfileScreen extends StatefulWidget {
  final OtpArguments? arguments;
  const UpdateProfileScreen({Key? key, this.arguments}) : super(key: key);

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
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _subCategoriesType = TextEditingController();
  var genderValue = "Male";
  String genderInitialValue = 'Male';
  var gender = ["Male", "Female"];
  StateModel stateModel = StateModel();
  CityModel cityModel = CityModel();
  GenderModel genderModel = GenderModel();
  SubCategoriesModel subCategoriesModel = SubCategoriesModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("phone number otp screen${widget.arguments?.phoneNumber}");
    print("phone number otp screen${widget.arguments?.category_type}");
  }

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
              controller: _phoneNumber,
              keyboardInputType: TextInputType.number,
              readOnly: true,
              validator: mobileNumberValidator,
              prefix: const Icon(Icons.phone),
              hintText: "Enter phone number",
            ),
            SizedBoxH10(),
            appText("Enter address", style: AppTextStyle.lable),
            SizedBoxH8(),
            PrimaryTextField(
              hintText: "Enter address",
              controller: _address,
              prefix: const Icon(Icons.email),
              validator: addressValidation,
            ),
            appText("Select gender", style: AppTextStyle.lable),
            SizedBoxH8(),
            PrimaryTextField(
              controller: _gender,
              readOnly: true,
              hintText: "Select gender",
              suffix: Icon(
                Icons.arrow_drop_down,
                size: Sizes.s30.h,
              ),
              onTap: () async {
                GenderPickerDailog.show(context).then((value) {
                  if (value != null) {
                    _gender.text = value;
                  }
                });

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
                        readOnly: true,
                        hintText: "Select State",
                        suffix: Icon(
                          Icons.arrow_drop_down,
                          size: Sizes.s30.h,
                        ),
                        onTap: () async {
                          stateModel = await StatePickerDailog.show(context);
                          _state.text = stateModel.stateName ?? '';
                          _city.clear();
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
                        hintText: "Select City",
                        readOnly: true,
                        suffix: Icon(
                          Icons.arrow_drop_down,
                          size: Sizes.s30.h,
                        ),
                        onTap: () async {
                          cityModel = await CityPickerDailog.show(
                              context, "${stateModel.stateId}");
                          _city.text = cityModel.districtName ?? '';
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
            widget.arguments?.category_type == 1
                ? PrimaryTextField(
                    controller: _subCategoriesType,
                    readOnly: true,
                    hintText: "Select sub categories",
                    suffix: Icon(
                      Icons.arrow_drop_down,
                      size: Sizes.s30.h,
                    ),
                    onTap: () async {
                      subCategoriesModel =
                          await SubCategoriesPickerDailog.show(context);
                      _subCategoriesType.text =
                          subCategoriesModel.categoryName ?? '';
                      setState(() {});
                      setState(() {});
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please select state';
                      } else {
                        return null;
                      }
                    },
                  )
                : SizedBox.shrink(),
            PrimaryButton(
                lable: "Save",
                onPressed: () {
                  print("state:=${stateModel.stateId}");
                  print("city:=${cityModel.districtId}");
                  print("name:=${_name.text}");
                  print("email:=${_email.text}");
                  print("address:=${_address.text}");
                  print("gender:=${_gender.text}");
                  print("login id:=${widget.arguments?.userId}");
                  // Navigator.pushNamed(context, Routs.mainHome);
                  if (_formKey.currentState!.validate()) {
                    FormData data() {
                      return FormData.fromMap({
                        "name": _name.text.trim(),
                        "email": _email.text.trim(),
                        "loginid": "${widget.arguments?.userId}",
                        "gender": genderValue.trim(),
                        "address": _address.text.trim(),
                        "city": cityModel.districtId,
                        "state": stateModel.stateId,
                        "subcategoryid": _subCategoriesType.text,
                      });
                    }

                    ApiService().updateProfile(context, data: data());
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
        //focusColor: AppColor.grey,
        elevation: 0,
        underline: const SizedBox(),
        value: genderInitialValue,
        isExpanded: true,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: gender.map((String items) {
          return DropdownMenuItem(
            value: items != null ? items : "",
            child: Text(
              '${items}',
              style: AppTextStyle.textFieldFont,
            ),
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
