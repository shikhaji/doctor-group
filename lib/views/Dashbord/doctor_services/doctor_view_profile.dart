import 'package:doctor_on_call/routs/arguments.dart';
import 'package:doctor_on_call/utils/app_sizes.dart';
import 'package:doctor_on_call/utils/screen_utils.dart';
import 'package:doctor_on_call/widget/custom_sized_box.dart';
import 'package:doctor_on_call/widget/primary_botton.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/get_doctor_achievement_model.dart';
import '../../../models/get_profile_model.dart';
import '../../../routs/app_routs.dart';
import '../../../services/api_services.dart';
import '../../../services/shared_referances.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_text.dart';
import '../../../utils/app_text_style.dart';
import '../../../widget/primary_appbar.dart';
import '../../../widget/scrollview.dart';

class DoctorViewProfileScreen extends StatefulWidget {
  final SendArguments? arguments;
  const DoctorViewProfileScreen({Key? key, this.arguments}) : super(key: key);

  @override
  State<DoctorViewProfileScreen> createState() =>
      _DoctorViewProfileScreenState();
}

class _DoctorViewProfileScreenState extends State<DoctorViewProfileScreen> {
  GetProfileData? getProfileData;
  List<AchievementList> achievementList = [];

  @override
  void initState() {
    super.initState();
    ApiService()
        .getDoctorAchievementList("${widget.arguments!.doctorId}")
        .then((value) {
      if (value != null) {
        setState(() {
          achievementList = value.achievement;
        });
        print("achievementList :=${achievementList.length}");
      }
    });
    ApiService().getProfileData(widget.arguments!.doctorId).then((value) {
      if (value != null) {
        setState(() {
          getProfileData = value.profile;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: const SecondaryAppBar(
        title: "Doctor Profile",
        isLeading: true,
      ),
      body: CustomScroll(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBoxH18(),
          Container(
            height: 320,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizes.s14),
                image: getProfileData != null &&
                        getProfileData!.patientPhoto != ""
                    ? DecorationImage(
                        image: NetworkImage(
                            'https://appointment.doctoroncalls.in/uploads/${getProfileData!.patientPhoto}'),
                        fit: BoxFit.cover)
                    : DecorationImage(
                        image: NetworkImage(
                            'https://cdn-icons-png.flaticon.com/512/387/387561.png'),
                        fit: BoxFit.contain)),
          ),
          SizedBoxH18(),
          Text(
            "${getProfileData?.branchCategory == "1" ? "Dr. " : ""}${getProfileData?.branchName ?? ""}",
            style: AppTextStyle.appBarTextTitle,
          ),
          Text(
            "specialist for ${getProfileData?.categoryName ?? ""}",
            style: AppTextStyle.alertSubtitle,
          ),
          SizedBoxH18(),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                horizontal: Sizes.s12, vertical: Sizes.s18),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizes.s12),
                color: AppColor.textFieldColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Personal Details",
                  style: AppTextStyle.body1.copyWith(fontSize: Sizes.s14.sp),
                ),
                SizedBoxH10(),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColor.lightOrange, shape: BoxShape.circle),
                      child: Center(
                        child: Icon(Icons.location_on_rounded),
                      ),
                    ),
                    SizedBoxW6(),
                    Expanded(
                        child: Text(
                            "${getProfileData?.branchAddress ?? ""} ${getProfileData?.stateName ?? ""} ${getProfileData?.districtName ?? ""}",
                            style: AppTextStyle.subTitle))
                  ],
                ),
                SizedBoxH8(),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColor.lightOrange, shape: BoxShape.circle),
                      child: Center(
                        child: Icon(Icons.email_outlined),
                      ),
                    ),
                    SizedBoxW6(),
                    Expanded(
                        child: Text(getProfileData?.branchEmail ?? "",
                            style: AppTextStyle.subTitle))
                  ],
                ),
                SizedBoxH8(),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColor.lightOrange, shape: BoxShape.circle),
                      child: Center(
                        child: Icon(Icons.call),
                      ),
                    ),
                    SizedBoxW6(),
                    Expanded(
                        child: Text(getProfileData?.branchContact ?? "",
                            style: AppTextStyle.subTitle))
                  ],
                ),
              ],
            ),
          ),
          SizedBoxH18(),
          const Text(
            "My Achievement",
            style: AppTextStyle.appBarTextTitle,
          ),
          SizedBoxH18(),
          achievementList.length > 0
              ? GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  cacheExtent: 30,
                  physics: const ClampingScrollPhysics(),
                  itemCount: achievementList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 8 / 9,
                    crossAxisSpacing: Sizes.s20.h,
                    mainAxisSpacing: Sizes.s20.h,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizes.s14),
                          border: Border.all(color: AppColor.textFieldColor),
                          image: DecorationImage(
                              image: NetworkImage(
                                "https://appointment.doctoroncalls.in/uploads/${achievementList[index].daFileName}",
                              ),
                              fit: BoxFit.cover)),
                    );
                  },
                )
              : const Text(
                  "No Achievement",
                  style: AppTextStyle.body2,
                ),
          SizedBoxH34(),
          PrimaryButton(
              lable: "Book Appointment",
              onPressed: () {
                if (getProfileData!.ptScreen == "1") {
                  Navigator.pushNamed(context, Routs.bookAppointment,
                      arguments: SendArguments(
                          doctorId: getProfileData!.branchId,
                          doctorName: getProfileData!.branchName));
                } else if (getProfileData!.ptScreen == "2") {
                  Navigator.pushNamed(context, Routs.pathologyAndChemistForm);
                } else {
                  _makingPhoneCall("${getProfileData!.branchContact}");
                }
              }),
          SizedBoxH34(),
        ],
      ),
    );
  }

  _makingPhoneCall(String number) async {
    var url = Uri.parse('tel:$number');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
