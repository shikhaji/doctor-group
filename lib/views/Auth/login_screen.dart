import 'package:doctor_on_call/utils/app_sizes.dart';
import 'package:doctor_on_call/widget/primary_bottom.dart';
import 'package:doctor_on_call/widget/primary_textfield.dart';
import 'package:flutter/material.dart';

import '../../utils/app_asset.dart';
import '../../utils/app_color.dart';
import '../../utils/app_text.dart';
import '../../utils/app_text_style.dart';
import '../../widget/scrollview.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppAsset.backGround), fit: BoxFit.cover)),
          child: CustomScroll(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: Sizes.s200, horizontal: Sizes.s7),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                      bottom: Sizes.s26,
                      left: Sizes.s10,
                      right: Sizes.s10,
                      top: Sizes.s10),
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Center(
                        child: appText('Login'),
                      ),
                      PrimaryTextField(
                        color: Colors.grey,
                        label: "Phone number",
                      ),
                      PrimaryTextField(
                        label: "password",
                        color: Colors.grey,
                      ),
                      PrimaryButton(lable: "Login", onPressed: () {})
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
