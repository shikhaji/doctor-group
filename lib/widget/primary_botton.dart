import 'package:flutter/material.dart';

import '../utils/app_color.dart';
import '../utils/app_sizes.dart';
import '../utils/app_text.dart';
import '../utils/app_text_style.dart';
import '../utils/screen_utils.dart';

class PrimaryButton extends StatelessWidget {
  final String lable;
  final VoidCallback onPressed;
  final double? height;
  final Color? color;
  final bool? isStyle;
  const PrimaryButton(
      {Key? key,
      required this.lable,
      this.color,
      this.isStyle = false,
      required this.onPressed,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        height: height ?? ScreenUtil().setHeight(50),
        minWidth: double.infinity,
        shape: const StadiumBorder(),

        // RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(primaryButtonRadius)),
        //
        color: color ?? AppColor.primaryColor,
        highlightColor: Colors.transparent,
        elevation: 3,
        onPressed: onPressed,
        child: appText(lable,
            style: isStyle == false
                ? AppTextStyle.buttonTextStyle
                : AppTextStyle.buttonTextStyle
                    .copyWith(color: color ?? AppColor.primaryColor)));
  }
}

class CustomButton extends StatelessWidget {
  final String lable;
  final VoidCallback onPressed;
  final double? height;
  final Color? color;
  final bool? isStyle;
  final Color? bgColor;
  const CustomButton(
      {Key? key,
      required this.lable,
      this.color,
      this.bgColor,
      this.isStyle = false,
      required this.onPressed,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            color: bgColor ?? AppColor.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.primaryColor, width: 1)),
        child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: Center(
              child: appText(lable,
                  style: AppTextStyle.alertSubtitle.copyWith(
                      fontSize: Sizes.s16.h,
                      color: color ?? AppColor.primaryColor)),
            )),
      ),
    );
    // MaterialButton(
    //   height: height ?? ScreenUtil().setHeight(50),
    //   minWidth: double.infinity,
    //   shape: const StadiumBorder(),
    //   color: color ?? AppColor.primaryColor,
    //   highlightColor: Colors.transparent,
    //   elevation: 3,
    //   onPressed: onPressed,
    //   child: appText(lable,
    //       style: isStyle == false
    //           ? AppTextStyle.buttonTextStyle
    //           : AppTextStyle.buttonTextStyle
    //               .copyWith(color: color ?? AppColor.primaryColor)));
  }
}
