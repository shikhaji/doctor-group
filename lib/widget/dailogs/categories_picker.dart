import 'package:doctor_on_call/models/categories_model.dart';
import 'package:doctor_on_call/models/get_categories_list_model.dart';
import 'package:doctor_on_call/utils/app_color.dart';
import 'package:doctor_on_call/widget/custom_sized_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../services/api_services.dart';
import '../../utils/app_asset.dart';
import '../../utils/app_sizes.dart';
import '../../utils/screen_utils.dart';
import '../primary_botton.dart';

class CategoriesPickerDailog extends StatefulWidget {
  const CategoriesPickerDailog({super.key});

  static Future<CategoriesModel> show(BuildContext context) async {
    return await showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const CategoriesPickerDailog(),
    );
  }

  @override
  State<CategoriesPickerDailog> createState() => _CategoriesPickerDailogState();
}

class _CategoriesPickerDailogState extends State<CategoriesPickerDailog> {
  List<CategoriesModel> _categoriesModel = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    GetCategoriesListModel? response = await ApiService().getCategoriesList();
    if (response != null) {
      if (response.status == 200) {
        _categoriesModel = response.message
            .map((e) => CategoriesModel.fromJson(e.toJson()))
            .toList();
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Dialog(
        insetPadding: EdgeInsets.symmetric(
          horizontal: Sizes.s26.w,
          vertical: Sizes.s20.h,
        ),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.s12.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.s18.w,
            vertical: Sizes.s20.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListView.builder(
                itemCount: _categoriesModel.length,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                  horizontal: Sizes.s16.w,
                  vertical: Sizes.s20.h,
                ),
                itemBuilder: (context, index) {
                  CategoriesModel categoriesData = _categoriesModel[index];
                  return _CategoriesListTile(
                    categoriesModel: categoriesData,
                    onTap: () {
                      Navigator.pop(context, categoriesData);
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
  final CategoriesModel categoriesModel;
  final VoidCallback onTap;
  const _CategoriesListTile({
    required this.categoriesModel,
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
                categoriesModel.ptName ?? '',
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
