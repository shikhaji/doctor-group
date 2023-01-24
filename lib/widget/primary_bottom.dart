import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_color.dart';
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
