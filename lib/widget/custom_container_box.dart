import 'package:doctor_on_call/utils/app_text.dart';
import 'package:doctor_on_call/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/app_color.dart';
import '../utils/app_sizes.dart';
import '../utils/constant.dart';
import 'custom_sized_box.dart';

class CustomContainerBox extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;
  final TextStyle? titleStyle;
  final EdgeInsetsGeometry? padding;
  final String? icon;
  final bool? iconBool;
  const CustomContainerBox(
      {Key? key,
      this.title,
      this.onPressed,
      this.titleStyle,
      this.padding,
      this.iconBool = false,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(textFieldBorderRadius),
            border: Border.all(color: AppColor.grey)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconBool == true
                ? Image.network(
                    "${icon}",
                    height: Sizes.s50.h,
                    width: Sizes.s50.w,
                  )
                : Image.asset(
                    "${icon}",
                    height: Sizes.s50.h,
                    width: Sizes.s50.w,
                  ),
            SizedBoxH10(),
            appText(
              "${title}",
              style: titleStyle ??
                  AppTextStyle.alertSubtitle.copyWith(fontSize: Sizes.s18.h),
            )
          ],
        ),
      ),
      // child: Container(
      //   width: 200,
      //   padding: padding ??
      //       EdgeInsets.symmetric(
      //           horizontal: Sizes.s14.h, vertical: Sizes.s20.w),
      //   decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(textFieldBorderRadius),
      //       border: Border.all(color: AppColor.primaryColor)),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       const Icon(Icons.add),
      //       Center(
      //         child: appText(
      //           textAlign: TextAlign.center,
      //           "${title}",
      //           style: titleStyle ??
      //               AppTextStyle.alertSubtitle.copyWith(fontSize: Sizes.s18.h),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
