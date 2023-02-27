import 'dart:io';

import 'package:dio/dio.dart';
import 'package:doctor_on_call/services/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/city_model.dart';
import '../../models/gender_model.dart';
import '../../models/get_profile_model.dart';
import '../../models/state_model.dart';
import '../../services/shared_referances.dart';
import '../../utils/app_asset.dart';
import '../../utils/app_color.dart';
import '../../utils/app_sizes.dart';
import '../../utils/app_text.dart';
import '../../utils/app_text_style.dart';
import '../../utils/screen_utils.dart';
import '../../utils/theme_utils.dart';
import '../../utils/validation_mixin.dart';
import '../../widget/custom_sized_box.dart';
import '../../widget/dailogs/city_picker.dart';
import '../../widget/dailogs/gender_picker.dart';
import '../../widget/dailogs/state_picker.dart';
import '../../widget/drawer_widget.dart';
import '../../widget/primary_appbar.dart';
import '../../widget/primary_botton.dart';
import '../../widget/primary_textfield.dart';
import '../../widget/scrollview.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen>
    with ValidationMixin {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _role = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  var genderValue = "Male";
  String genderInitialValue = 'Male';
  var gender = ["Male", "Female"];

  StateModel stateModel = StateModel();
  CityModel cityModel = CityModel();
  GenderModel genderModel = GenderModel();
  GetProfileData? getProfileData;

  XFile? selectedDocument;
  var url;

  @override
  void initState() {
    // TODO: implement initState
    ApiService().getProfileData().then((value) {
      if (value != null) {
        getProfileData = value.profile;
        print("image url get:=${getProfileData!.patientPhoto}");
        _name.text = getProfileData!.branchName;
        _role.text = getProfileData!.branchCategory;
        _email.text = getProfileData!.branchEmail;
        _phoneNumber.text = getProfileData!.branchContact;
        _gender.text = getProfileData!.branchGender;
        _address.text = getProfileData!.branchAddress;
        _state.text = getProfileData!.stateName;
        _city.text = getProfileData!.districtName;
        url = getProfileData!.patientPhoto;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondaryAppBar(
        title: "My Profile",
        isLeading: false,
      ),
      body: Form(
        key: _formKey,
        child: CustomScroll(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildProfileImageWidget(
                  context,
                ),
              ],
            ),
            const SizedBox(height: 50),
            _buildPersonalData(),
            const SizedBox(height: 30),
            PrimaryButton(
                lable: "Save",
                onPressed: () async {
                  String? id = await Preferances.getString("userId");

                  print(
                      "loginid${id!.replaceAll('"', '').replaceAll('"', '').toString()}");
                  print("name:=${_name.text.trim()}");
                  print("email:=${_email.text.trim()}");
                  print("district:=${cityModel.districtId}");
                  print("state:=${stateModel.stateId}");
                  print("gender:=${_gender.text.trim()}");
                  print("address:=${_address.text.trim()}");
                  print("file to upload:=${url}");
//////////////////////////////////////////////////////////////////
                  if (_formKey.currentState!.validate()) {
                    if (selectedDocument?.path == null) {
                      Fluttertoast.showToast(
                        msg: 'Please Upload Profile',
                        backgroundColor: Colors.grey,
                      );
                    } else {
                      var file =
                          await MultipartFile.fromFile(selectedDocument!.path);
                      Map<String, dynamic> data = {
                        "loginid": id
                            .replaceAll('"', '')
                            .replaceAll('"', '')
                            .toString(),
                        "name": _name.text.trim(),
                        "email": _email.text.trim(),
                        "district": cityModel.districtId,
                        "state": stateModel.stateId,
                        "gender": _gender.text.trim(),
                        "address": _address.text.trim(),
                        "fileToUpload": selectedDocument!.path,
                      };

                      ApiService().updateMyProfile(context, data: data);
                    }
                  }
                }),
            SizedBoxH18(),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appText("Name", style: AppTextStyle.lable),
        SizedBoxH8(),
        PrimaryTextField(
          controller: _name,
          prefix: const Icon(Icons.perm_identity),
          hintText: "Enter your name",
        ),
        SizedBoxH10(),
        appText("Your Role", style: AppTextStyle.lable),
        SizedBoxH8(),
        PrimaryTextField(
          controller: _role,
          prefix: const Icon(Icons.perm_identity),
          hintText: "Enter your role",
        ),
        SizedBoxH10(),
        appText("Email address", style: AppTextStyle.lable),
        SizedBoxH8(),
        PrimaryTextField(
          readOnly: true,
          controller: _email,
          validator: emailValidator,
          prefix: const Icon(Icons.email),
          hintText: "Enter email address",
        ),
        SizedBoxH10(),
        appText("Phone number", style: AppTextStyle.lable),
        SizedBoxH8(),
        PrimaryTextField(
          controller: _phoneNumber,
          keyboardInputType: TextInputType.phone,
          //validator: mobileNumberValidator,
          readOnly: true,
          prefix: const Icon(Icons.phone),
          hintText: "Enter Phone Number",
        ),
        SizedBoxH10(),
        appText("Select gender", style: AppTextStyle.lable),
        SizedBoxH8(),
        PrimaryTextField(
          controller: _gender,
          readOnly: true,
          hintText: "Select gender",
          suffix: Icon(
            Icons.arrow_drop_down,
            size: Sizes.s30.h,
          ),
          onTap: () async {
            GenderPickerDailog.show(context).then((value) {
              if (value != null) {
                _gender.text = value;
              }
            });

            setState(() {});
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please select state';
            } else {
              return null;
            }
          },
        ),
        SizedBoxH10(),
        appText("Enter address", style: AppTextStyle.lable),
        SizedBoxH8(),
        PrimaryTextField(
          hintText: "Enter address",
          controller: _address,
          prefix: const Icon(Icons.home),
          validator: addressValidation,
        ),
        SizedBoxH10(),
        SizedBoxH10(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appText("Select state", style: AppTextStyle.lable),
                  SizedBoxH8(),
                  PrimaryTextField(
                    controller: _state,
                    readOnly: true,
                    hintText: "Select State",
                    suffix: Icon(
                      Icons.arrow_drop_down,
                      size: Sizes.s30.h,
                    ),
                    onTap: () async {
                      stateModel = await StatePickerDailog.show(context);
                      _state.text = stateModel.stateName ?? '';
                      _city.clear();
                      setState(() {});
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please select state';
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBoxW10(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appText("Select city", style: AppTextStyle.lable),
                  SizedBoxH8(),
                  PrimaryTextField(
                    controller: _city,
                    hintText: "Select City",
                    readOnly: true,
                    suffix: Icon(
                      Icons.arrow_drop_down,
                      size: Sizes.s30.h,
                    ),
                    onTap: () async {
                      cityModel = await CityPickerDailog.show(
                          context, "${stateModel.stateId}");
                      _city.text = cityModel.districtName ?? '';
                      setState(() {});
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please select city';
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget buildProfileImageWidget(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: 75,
          child: ClipOval(
            child: selectedDocument != null
                ? Image.file(File(selectedDocument!.path),
                    height: 160, width: 160, fit: BoxFit.cover)
                : url != ''
                    ? Image.network(
                        'https://appointment.doctoroncalls.in/uploads/${url}',
                        height: 160,
                        width: 160,
                        fit: BoxFit.cover)
                    : Image.asset(AppAsset.dummyAvatar,
                        height: 160, width: 160, fit: BoxFit.cover),
          ),
        ),
        Positioned.fill(
          bottom: -12,
          child: Align(
            alignment: Alignment.bottomCenter,
            //  child: showDialogForUserImage(1),
            child: InkWell(
              onTap: () => showDialogForUserImage(1),
              child: CircleAvatar(
                backgroundColor: AppColor.white,
                radius: Sizes.s20.r,
                child: CircleAvatar(
                  radius: Sizes.s18.r,
                  backgroundColor: AppColor.orange,
                  child: SvgPicture.asset(
                    AppAsset.camera,
                    height: Sizes.s20.h,
                    width: Sizes.s20.w,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
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
