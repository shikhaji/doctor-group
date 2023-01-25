import 'package:doctor_on_call/utils/app_color.dart';
import 'package:doctor_on_call/widget/primary_botton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_sizes.dart';
import '../utils/constant.dart';

 Future<bool> _showConfirmationDialog(BuildContext context,
    {required String title,
    required String message,
    required String buttonText}) async {
  return await showCupertinoDialog<bool>(
        context: context,
        builder: (context) {
          return Dialog(
            elevation: 0,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16 - 4),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(kPadding, kPadding, kPadding, 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: Sizes.s18.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: Sizes.s10.h),
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: Sizes.s14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.grey,
                    ),
                  ),
                  SizedBox(height: Sizes.s20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PrimaryButton(
                        lable: 'Cancel',
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                      ),
                      SizedBox(width: Sizes.s10.w),
                      PrimaryButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        lable: buttonText,
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ) ??
      false;
}
