import 'package:dio/dio.dart';
import 'package:doctor_on_call/utils/app_asset.dart';
import 'package:doctor_on_call/utils/screen_utils.dart';
import 'package:doctor_on_call/widget/primary_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../models/get_profile_model.dart';
import '../../routs/app_routs.dart';
import '../../routs/arguments.dart';
import '../../services/api_services.dart';
import '../../services/shared_referances.dart';
import '../../utils/app_color.dart';
import '../../utils/app_sizes.dart';
import '../../utils/app_text.dart';
import '../../utils/app_text_style.dart';
import '../../widget/custom_sized_box.dart';
import '../../widget/dailogs/location_dailog.dart';
import '../../widget/primary_botton.dart';
import '../../widget/scrollview.dart';

class MyLocationScreen extends StatefulWidget {
  const MyLocationScreen({Key? key}) : super(key: key);

  @override
  State<MyLocationScreen> createState() => _MyLocationScreenState();
}

class _MyLocationScreenState extends State<MyLocationScreen> {
  final TextEditingController _location = TextEditingController();
  GetProfileData? getProfileData;
  String stateId = "";
  String cityId = "";

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  Future<void> getProfile() async {
    String? id = await Preferances.getString("userId");
    ApiService()
        .getProfileData(id!.replaceAll('"', '').replaceAll('"', '').toString())
        .then((value) {
      if (value != null) {
        setState(() {
          getProfileData = value.profile;
        });
        _location.text =
            "${getProfileData!.stateName} ,${getProfileData!.districtName}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: CustomScroll(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBoxH34(),
            SizedBoxH28(),
            SizedBoxH28(),
            Center(
              child: appText("My Location", style: AppTextStyle.title),
            ),
            SizedBoxH6(),
            Center(
              child: appText("Please select your location",
                  style: AppTextStyle.subTitle),
            ),
            SizedBoxH28(),
            appText("Select Location", style: AppTextStyle.lable),
            SizedBoxH8(),
            PrimaryTextField(
              controller: _location,
              readOnly: true,
              suffix: Icon(
                Icons.arrow_drop_down,
                size: Sizes.s30.h,
              ),
              onTap: () {
                LocationDailog.show(context).then((value) {
                  _location.text = "${value.state} ,${value.city}";
                  cityId = value.cityId;
                  stateId = value.stateId;
                });
              },
            ),
            SizedBoxH8(),
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                AppAsset.mapViewImg,
                height: Sizes.s300.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBoxH20(),
            PrimaryButton(
                lable: "Save",
                onPressed: () async {
                  if (_location.text != "") {
                    String? id = await Preferances.getString("userId");
                    FormData data() {
                      return FormData.fromMap({
                        "loginid": id!
                            .replaceAll('"', '')
                            .replaceAll('"', '')
                            .toString(),
                        "name": getProfileData?.branchName,
                        "email": getProfileData?.branchEmail,
                        "district": cityId,
                        "state": stateId,
                        "gender": getProfileData?.branchGender,
                        "address": getProfileData?.branchAddress,
                        "fileToUpload": getProfileData?.patientPhoto,
                      });
                    }

                    ApiService()
                        .updateMyProfile(context, data: data())
                        .then((value) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, Routs.mainHome, (route) => false,
                          arguments: SendArguments(bottomIndex: 0));
                    });
                  } else {
                    Fluttertoast.showToast(
                      msg: 'Please select location !',
                      backgroundColor: Colors.grey,
                    );
                  }
                }),
            SizedBoxH18(),
          ],
        ),
      ),
    );
  }
}
