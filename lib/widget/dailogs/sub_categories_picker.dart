import 'package:doctor_on_call/models/get_sub_categories_model.dart';
import 'package:doctor_on_call/utils/app_color.dart';
import 'package:doctor_on_call/widget/custom_sized_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/sub_categories_model.dart';
import '../../services/api_services.dart';
import '../../utils/app_sizes.dart';
import '../../utils/screen_utils.dart';

class SubCategoriesPickerDailog extends StatefulWidget {
  final String ptId;
  const SubCategoriesPickerDailog({
    super.key,
    required this.ptId,
  });

  static Future<SubCategoriesModel> show(
      BuildContext context, String ptId) async {
    return await showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => SubCategoriesPickerDailog(ptId: ptId),
    );
  }

  @override
  State<SubCategoriesPickerDailog> createState() =>
      _SubCategoriesPickerDailogState();
}

class _SubCategoriesPickerDailogState extends State<SubCategoriesPickerDailog> {
  List<SubCategoriesModel> _subCategoriesModel = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    GetSubCategoryModel? response =
        await ApiService().getSubCategoriesList("${widget.ptId}");
    if (response != null) {
      if (response.status == 200) {
        _subCategoriesModel = response.message
            .map((e) => SubCategoriesModel.fromJson(e.toJson()))
            .toList();
        setState(() {});
      }
    }
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
                itemCount: _subCategoriesModel.length,
                padding: EdgeInsets.symmetric(
                  horizontal: Sizes.s16.w,
                  vertical: Sizes.s20.h,
                ),
                itemBuilder: (context, index) {
                  SubCategoriesModel subCategoriesData =
                      _subCategoriesModel[index];
                  return _CategoriesListTile(
                    subCategoriesModel: subCategoriesData,
                    onTap: () {
                      Navigator.pop(context, subCategoriesData);
                    },
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
  final SubCategoriesModel subCategoriesModel;
  final VoidCallback onTap;
  const _CategoriesListTile({
    required this.subCategoriesModel,
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
                subCategoriesModel.categoryName ?? '',
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
