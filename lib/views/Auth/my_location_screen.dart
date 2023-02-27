import 'package:doctor_on_call/utils/app_asset.dart';
import 'package:doctor_on_call/utils/screen_utils.dart';
import 'package:doctor_on_call/widget/primary_textfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../routs/app_routs.dart';
import '../../routs/arguments.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
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
            appText("My Location", style: AppTextStyle.title),
            SizedBoxH6(),
            appText("Please select your location",
                style: AppTextStyle.subTitle),
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
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routs.mainHome, (route) => false,
                        arguments: SendArguments(bottomIndex: 0));
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
