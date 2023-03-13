import 'dart:async';
import 'package:doctor_on_call/routs/arguments.dart';
import 'package:doctor_on_call/utils/app_color.dart';
import 'package:doctor_on_call/utils/app_text.dart';
import 'package:flutter/material.dart';
import '../../routs/app_routs.dart';
import '../../services/shared_referances.dart';
import '../../utils/app_asset.dart';
import '../../utils/app_sizes.dart';
import '../../utils/app_text_style.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    verify();
  }

  Future<void> verify() async {
    String userId = await Preferances.prefGetString("userId", '');
    String profileStatus = await Preferances.prefGetString("profileStatus", '');
    Future.delayed(const Duration(seconds: 3)).then(
      (value) {
        if (userId != null &&
            profileStatus.replaceAll('"', '').toString() == "1") {
          Navigator.pushNamedAndRemoveUntil(
              context, Routs.mainHome, (route) => false,
              arguments: SendArguments(bottomIndex: 0));
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, Routs.mobileVerification, (route) => false);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Center(
        child: Image.asset(
          AppAsset.logo,
          height: Sizes.s150,
        ),
      ),
      // SafeArea(
      //   child: Container(
      //     height: double.infinity,
      //     width: double.infinity,
      //     decoration: const BoxDecoration(
      //         image: DecorationImage(
      //             image: AssetImage(AppAsset.splash), fit: BoxFit.cover)),
      //     child: Center(child: Image.asset(AppAsset.logo)
      //         //child: appText("Doctor on call", style: AppTextStyle.headline1),
      //         ),
      //   ),
      // ),
    );
  }
}
