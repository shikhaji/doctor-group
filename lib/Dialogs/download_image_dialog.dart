import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:doctor_on_call/widget/custom_sized_box.dart';
import 'package:doctor_on_call/widget/primary_botton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../utils/app_sizes.dart';
import '../../utils/screen_utils.dart';
import '../utils/loder.dart';

class DownloadImagePickerDailog extends StatefulWidget {
  final String imageUrl;
  const DownloadImagePickerDailog({
    super.key,
    required this.imageUrl,
  });

  static Future<String> show(BuildContext context, String imageUrl) async {
    return await showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => DownloadImagePickerDailog(
        imageUrl: imageUrl,
      ),
    );
  }

  @override
  State<DownloadImagePickerDailog> createState() =>
      _DownloadImagePickerDailogState();
}

class _DownloadImagePickerDailogState extends State<DownloadImagePickerDailog> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("image url:=${widget.imageUrl}");
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
                  ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        'https://appointment.doctoroncalls.in/uploads/${widget.imageUrl}',
                        height: Sizes.s200.h,
                        width: double.infinity,
                      )),
                  SizedBoxH34(),
                  SizedBoxH34(),
                  PrimaryButton(
                      lable: "Download Image",
                      onPressed: () {
                        _buildDownloadImage();
                      })
                ],
              ),
            ),
          )),
    );
  }

  _buildDownloadImage() async {
    Loader.showLoader();
    var status = Permission.storage.request();
    if (await status.isGranted) {
      var response = await Dio().get(
          "https://appointment.doctoroncalls.in/uploads/${widget.imageUrl.toString()}",
          options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 60,
          name: "hello");

      print(result);
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: 'Download Successfully...',
        backgroundColor: Colors.grey,
      );
      Loader.hideLoader();
    }
  }
}
