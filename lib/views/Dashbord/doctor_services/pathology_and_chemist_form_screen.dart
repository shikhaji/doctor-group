import 'dart:io';

import 'package:date_picker_timeline/extra/color.dart';
import 'package:dio/dio.dart';
import 'package:doctor_on_call/widget/primary_botton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import '../../../services/api_services.dart';
import '../../../services/shared_referances.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_sizes.dart';
import '../../../utils/app_text.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/screen_utils.dart';
import '../../../utils/theme_utils.dart';
import '../../../widget/custom_sized_box.dart';
import '../../../widget/primary_appbar.dart';
import '../../../widget/primary_textfield.dart';
import '../../../widget/scrollview.dart';

class PathologyAndChemistFormScreen extends StatefulWidget {
  const PathologyAndChemistFormScreen({Key? key}) : super(key: key);

  @override
  State<PathologyAndChemistFormScreen> createState() =>
      _PathologyAndChemistFormScreenState();
}

class _PathologyAndChemistFormScreenState
    extends State<PathologyAndChemistFormScreen> {
  final TextEditingController _referredBy = TextEditingController();
  final TextEditingController _description = TextEditingController();
  XFile? selectedDocument;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const SecondaryAppBar(
          title: "Fill Form",
          isLeading: true,
        ),
        bottomNavigationBar: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Sizes.s16.h, vertical: Sizes.s28.h),
          child: PrimaryButton(
              lable: "Done",
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  print("selectedDocument here${selectedDocument!.name}");
                  if (selectedDocument!.path == null) {
                    Fluttertoast.showToast(
                      msg: 'Please Upload Prescription',
                      backgroundColor: Colors.grey,
                    );
                  } else {
                    String? id = await Preferances.getString("userId");

                    print("selectedDocument${selectedDocument!.name}");

                    print(
                        "loginid${id!.replaceAll('"', '').replaceAll('"', '').toString()}");

                    var file =
                        await MultipartFile.fromFile(selectedDocument!.path);

                    FormData data() {
                      return FormData.fromMap({
                        "loginid": id
                            .replaceAll('"', '')
                            .replaceAll('"', '')
                            .toString(),
                        "referby": _referredBy.text.trim(),
                        "desc": _description.text.trim(),
                        "fileToUpload": file,
                      });
                    }

                    ApiService()
                        .uploadPrescriptionByPatient(context, data: data());
                  }
                }
              }),
        )),
        body: Form(
          key: _formKey,
          child: CustomScroll(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              appText("Referred By", style: AppTextStyle.lable),
              SizedBoxH8(),
              PrimaryTextField(
                controller: _referredBy,
                hintText: "Referred By",
                // validator: mobileNumberValidator,
                prefix: const Icon(Icons.verified_user_sharp),
              ),
              SizedBoxH10(),
              appText("Description", style: AppTextStyle.lable),
              SizedBoxH8(),
              PrimaryTextField(
                controller: _description,
                hintText: "Description",

                // validator: patientNameValidation,
                prefix: const Icon(Icons.person),
              ),
              appText("Upload Prescription", style: AppTextStyle.lable),
              SizedBoxH8(),
              InkWell(
                onTap: () => showDialogForUserImage(1),
                child: uploadBox(
                  'Upload Image',
                  selectedDocument != null ? selectedDocument!.path : '',
                ),
              ),
              SizedBoxH34(),
              SizedBoxH34(),
            ],
          ),
        ));
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

  selectImage(ImageSource source, int imgIndex) async {
    final ImagePicker imagePicker = ImagePicker();
    if (imgIndex == 1) {
      selectedDocument = await imagePicker.pickImage(source: source);
      setState(() {});
    }
  }
}
