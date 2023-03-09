import 'dart:io';
import 'package:dio/dio.dart';
import 'package:doctor_on_call/widget/custom_sized_box.dart';
import 'package:doctor_on_call/widget/primary_botton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import '../../utils/app_sizes.dart';
import '../../utils/screen_utils.dart';
import '../services/api_services.dart';
import '../utils/app_color.dart';
import '../utils/app_text_style.dart';

class UploadImagePickerDailog extends StatefulWidget {
  final String loginId;
  final int status;

  const UploadImagePickerDailog({
    super.key,
    required this.loginId,
    required this.status,
  });

  static Future<void> show(
      BuildContext context, String imageUrl, int status) async {
    return await showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => UploadImagePickerDailog(
        loginId: imageUrl,
        status: status,
      ),
    );
  }

  @override
  State<UploadImagePickerDailog> createState() =>
      _UploadImagePickerDailogState();
}

class _UploadImagePickerDailogState extends State<UploadImagePickerDailog> {
  XFile? selectedDocument;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Dialog(
          insetPadding: EdgeInsets.all(Sizes.s20.h),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.s12.r),
          ),
          child: SizedBox(
            height: ScreenUtil().screenHeight / 2,
            width: ScreenUtil().screenWidth / 1.2,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Sizes.s14.w,
                vertical: Sizes.s20.h,
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () => showDialogForUserImage(1),
                    child: uploadBox(
                      'Upload Image',
                      selectedDocument != null ? selectedDocument!.path : '',
                    ),
                  ),
                  SizedBoxH34(),
                  SizedBoxH34(),
                  widget.status == 1
                      ? PrimaryButton(
                          lable: "Upload Image",
                          onPressed: () async {
                            if (selectedDocument?.path == null) {
                              Fluttertoast.showToast(
                                msg: 'Please Upload report',
                                backgroundColor: Colors.grey,
                              );
                            } else {
                              var file = await MultipartFile.fromFile(
                                  selectedDocument!.path);

                              FormData data() {
                                return FormData.fromMap({
                                  "loginid": widget.loginId,
                                  "fileToUpload": file,
                                });
                              }

                              ApiService().uploadReportToCustomer(context,
                                  data: data());
                            }
                          })
                      : PrimaryButton(
                          lable: "Upload Image",
                          onPressed: () async {
                            if (selectedDocument?.path == null) {
                              Fluttertoast.showToast(
                                msg: 'Please Upload report',
                                backgroundColor: Colors.grey,
                              );
                            } else {
                              var file = await MultipartFile.fromFile(
                                  selectedDocument!.path);
                              print("login id:=${widget.loginId}");
                              FormData data() {
                                return FormData.fromMap({
                                  "loginid": widget.loginId,
                                  "fileToUpload": file,
                                });
                              }

                              ApiService()
                                  .uploadDoctorAchievement(context,
                                      data: data())
                                  .then((value) {});
                            }
                          })
                ],
              ),
            ),
          )),
    );
  }

  showDialogForUserImage(int imgIndex) {
    showCupertinoModalPopup(
      context: context,
      builder: (a) => ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Material(
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  color: AppColor.primaryColor,
                  child: const Center(
                    child: Text(
                      "Select Image",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColor.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(a).pop();
                        selectImage(ImageSource.gallery, 1);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.image_rounded,
                            color: AppColor.white,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Gallery",
                            style: AppTextStyle.greySubTitle
                                .copyWith(color: AppColor.white),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height / 12,
                      width: 3,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(a).pop();
                        selectImage(ImageSource.camera, 1);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.camera_alt_rounded,
                            color: AppColor.white,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Camera",
                            style: AppTextStyle.greySubTitle
                                .copyWith(color: AppColor.white),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget uploadBox(String title, String image) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).cardColor,
        border: RDottedLineBorder.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      width: ScreenUtil().screenWidth,
      height: Sizes.s180.h,
      child: Center(
        child: image != ''
            ? ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.file(File(image),
                    width: double.infinity, fit: BoxFit.cover))
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.upload_file), Text("Upload File")],
              ),
      ),
    );
  }

  selectImage(ImageSource source, int imgIndex) async {
    final ImagePicker imagePicker = ImagePicker();
    if (imgIndex == 1) {
      selectedDocument = await imagePicker.pickImage(source: source);
      setState(() {});
    }
  }
}
