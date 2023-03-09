import 'package:dio/dio.dart';
import 'package:doctor_on_call/utils/validation_mixin.dart';
import 'package:doctor_on_call/widget/dailogs/state_picker.dart';
import 'package:doctor_on_call/widget/primary_botton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/city_model.dart';
import '../../models/get_profile_model.dart';
import '../../models/state_model.dart';
import '../../services/api_services.dart';
import '../../services/shared_referances.dart';
import '../../utils/app_sizes.dart';
import '../../utils/app_text.dart';
import '../../utils/app_text_style.dart';
import '../../utils/screen_utils.dart';
import '../custom_sized_box.dart';
import '../primary_textfield.dart';
import 'city_picker.dart';

class LocationDailog extends StatefulWidget {
  LocationDailog({
    super.key,
  });

  static Future show(BuildContext context) async {
    return await showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => LocationDailog(),
    );
  }

  @override
  State<LocationDailog> createState() => _LocationDailogState();
}

class _LocationDailogState extends State<LocationDailog> with ValidationMixin {
  final TextEditingController _state = TextEditingController();
  final TextEditingController _city = TextEditingController();
  StateModel stateModel = StateModel();
  CityModel cityModel = CityModel();
  final _formKey = GlobalKey<FormState>();
  SetLocationModel setLocationModel = SetLocationModel();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Dialog(
      insetPadding: const EdgeInsets.all(20),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        height: ScreenUtil().screenHeight / 1.6,
        width: ScreenUtil().screenWidth / 1.2,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBoxH28(),
                  appText("Set location", style: AppTextStyle.appBarTextTitle),
                  SizedBoxH14(),
                  appText("Please select state and city and set your location",
                      softWrap: true,
                      textAlign: TextAlign.start,
                      style: AppTextStyle.blackSubTitle.copyWith(
                        color: const Color(0xff616467),
                      )),
                  SizedBoxH28(),
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
                  SizedBoxH14(),
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
                  SizedBoxH18(),
                  PrimaryButton(
                      lable: "Done",
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setLocationModel.state = _state.text;
                          setLocationModel.city = _city.text;
                          setLocationModel.stateId = stateModel.stateId;
                          setLocationModel.cityId = cityModel.districtId;
                          Navigator.pop(context, setLocationModel);
                        }
                      }),
                ],
              ),
            )),
      ),
    ));
  }
}

class SetLocationModel {
  SetLocationModel({
    this.state,
    this.city,
    this.stateId,
    this.cityId,
  });
  String? state;
  String? city;
  String? stateId;
  String? cityId;
}
