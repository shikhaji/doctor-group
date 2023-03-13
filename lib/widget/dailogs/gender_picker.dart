import 'package:doctor_on_call/utils/app_color.dart';
import 'package:doctor_on_call/widget/custom_sized_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/gender_model.dart';
import '../../utils/app_sizes.dart';
import '../../utils/screen_utils.dart';

class GenderPickerDailog extends StatefulWidget {
  const GenderPickerDailog({super.key});

  static Future<String> show(BuildContext context) async {
    return await showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => GenderPickerDailog(),
    );
  }

  @override
  State<GenderPickerDailog> createState() => _GenderPickerDailogState();
}

class _GenderPickerDailogState extends State<GenderPickerDailog> {
  List<GenderModel> _genderModel = [];
  List<GenderModel> gender = [
    GenderModel(genderName: "Male"),
    GenderModel(genderName: "Female")
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _genderModel = gender;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Dialog(
        insetPadding: EdgeInsets.all(Sizes.s20.h),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.s12.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.s14.w,
            vertical: Sizes.s20.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: _genderModel.length,
                padding: EdgeInsets.symmetric(
                  horizontal: Sizes.s16.w,
                  vertical: Sizes.s20.h,
                ),
                itemBuilder: (context, index) {
                  GenderModel gender = _genderModel[index];
                  return _CategoriesListTile(
                    onTap: () {
                      Navigator.pop(context, gender.genderName);
                    },
                    genderModel: gender,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoriesListTile extends StatelessWidget {
  final GenderModel genderModel;
  final VoidCallback onTap;
  const _CategoriesListTile({
    required this.genderModel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBoxH8(),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  horizontal: Sizes.s12.h, vertical: Sizes.s18.h),
              decoration: BoxDecoration(
                  color: AppColor.textFieldColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                genderModel.genderName ?? '',
                style: TextStyle(
                  fontSize: Sizes.s16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ));
  }
}
