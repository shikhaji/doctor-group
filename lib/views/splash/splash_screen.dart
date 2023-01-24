import 'dart:async';

import 'package:doctor_on_call/utils/app_color.dart';
import 'package:doctor_on_call/utils/app_text.dart';
import 'package:doctor_on_call/views/Auth/login_screen.dart';
import 'package:flutter/material.dart';

import '../../utils/app_asset.dart';
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
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppAsset.splash), fit: BoxFit.cover)),
          child: Center(
            child: appText("Doctor on call", style: AppTextStyle.headline1),
          ),
        ),
      ),
    );
  }
}
