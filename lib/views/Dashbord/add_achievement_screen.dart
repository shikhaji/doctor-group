import 'dart:io';

import 'package:dio/dio.dart';
import 'package:doctor_on_call/utils/app_asset.dart';
import 'package:doctor_on_call/utils/app_color.dart';
import 'package:doctor_on_call/widget/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import 'dart:typed_data';
import '../../Dialogs/upload_image_dailog.dart';
import '../../models/get_doctor_achievement_model.dart';
import '../../services/api_services.dart';
import '../../services/shared_referances.dart';
import '../../utils/app_sizes.dart';
import '../../utils/screen_utils.dart';
import '../../widget/primary_appbar.dart';
import '../../widget/primary_botton.dart';
import '../../widget/scrollview.dart';

class AddAchievementScreen extends StatefulWidget {
  const AddAchievementScreen({Key? key}) : super(key: key);

  @override
  State<AddAchievementScreen> createState() => _AddAchievementScreenState();
}

class _AddAchievementScreenState extends State<AddAchievementScreen> {
  List<AchievementList> achievementList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAchievement();
  }

  Future<void> getAchievement() async {
    String? id = await Preferances.getString("userId");
    ApiService()
        .getDoctorAchievementList(
            "${id!.replaceAll('"', '').replaceAll('"', '').toString()}")
        .then((value) {
      if (value != null) {
        setState(() {
          achievementList = value.achievement;
        });
        print("achievementList :=${achievementList.length}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: achievementList != []
          ? Padding(
              padding: EdgeInsets.all(30),
              child: FloatingActionButton(
                child: Icon(
                  Icons.add,
                  color: AppColor.white,
                ),
                backgroundColor: AppColor.primaryColor,
                onPressed: () async {
                  String? id = await Preferances.getString("userId");
                  UploadImagePickerDailog.show(
                          context,
                          "${id!.replaceAll('"', '').replaceAll('"', '').toString()}",
                          2)
                      .then((value) {
                    getAchievement();
                  });
                },
              ),
            )
          : SizedBox.shrink(),
      body: achievementList.length < 0
          ? Center(
              child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAsset.addAchievement,
                    height: Sizes.s150.h,
                    color: AppColor.grey,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Sizes.s100, vertical: Sizes.s30),
                    child: PrimaryButton(
                        lable: "Add Achievement",
                        onPressed: () async {
                          String? id = await Preferances.getString("userId");
                          UploadImagePickerDailog.show(
                                  context,
                                  "${id!.replaceAll('"', '').replaceAll('"', '').toString()}",
                                  2)
                              .then((value) {
                            getAchievement();
                          });
                        }),
                  )
                ],
              ),
            ))
          : CustomScroll(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBoxH34(),
                GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    cacheExtent: 30,
                    physics: const ClampingScrollPhysics(),
                    itemCount: achievementList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 8 / 8,
                      crossAxisSpacing: Sizes.s20.h,
                      mainAxisSpacing: Sizes.s20.h,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          "https://appointment.doctoroncalls.in/uploads/${achievementList[index].daFileName}",
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        // child: Image.file(File(achievementList[index].daFileName),
                        //     width: double.infinity, fit: BoxFit.cover)
                      );
                    }),
              ],
            ),
      appBar: SecondaryAppBar(
        title: "Add Achievement",
        isLeading: true,
        leadingIcon: Icons.arrow_back_ios,
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  // List<XFile>? imageFileList = [];
  // final ImagePicker imagePicker = ImagePicker();
  // void selectImages() async {
  //   final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
  //   if (selectedImages!.isNotEmpty) {
  //     imageFileList!.addAll(selectedImages);
  //   }
  //   print("Image List Length:" + imageFileList!.length.toString());
  //   print("Image List Length:" + imageFileList!.length.toString());
  //   setState(() {});
  // }

  // Widget uploadBox(String title, String image) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(16),
  //       color: Theme.of(context).cardColor,
  //       border: RDottedLineBorder.all(
  //         color: Colors.grey,
  //         width: 1,
  //       ),
  //     ),
  //     width: ScreenUtil().screenWidth,
  //     height: Sizes.s180.h,
  //     child: Center(
  //       child: image != ''
  //           ? ClipRRect(
  //               borderRadius: BorderRadius.circular(16),
  //               child: Image.file(File(image),
  //                   width: double.infinity, fit: BoxFit.cover))
  //           : Row(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: const [
  //                 Icon(Icons.upload_file),
  //                 Text("Upload Achievement")
  //               ],
  //             ),
  //     ),
  //   );
  // }

}
