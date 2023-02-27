import 'package:doctor_on_call/routs/arguments.dart';
import 'package:doctor_on_call/utils/app_sizes.dart';
import 'package:doctor_on_call/utils/screen_utils.dart';
import 'package:doctor_on_call/widget/custom_sized_box.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_text.dart';
import '../../../utils/app_text_style.dart';
import '../../../widget/primary_appbar.dart';
import '../../../widget/scrollview.dart';

class DoctorViewProfileScreen extends StatefulWidget {
  final SendArguments arguments;
  const DoctorViewProfileScreen({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<DoctorViewProfileScreen> createState() =>
      _DoctorViewProfileScreenState();
}

class _DoctorViewProfileScreenState extends State<DoctorViewProfileScreen> {
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
                image: const DecorationImage(
                    image: NetworkImage(
                        "https://www.desktopbackground.org/download/1024x768/2014/01/01/694300_daniels-statistics-analysis-name-meaning-list-of-firstnames_1920x1200_h.jpg"),
                    fit: BoxFit.cover)),
          ),
          SizedBoxH18(),
          Text(
            "Dr. Hina Patel",
            style: AppTextStyle.appBarTextTitle,
          ),
          Text(
            "specialist for alopathy",
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
                            "128, madhvbug parvat patiya surat Gujrat india 35001",
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
                        child: Text("hina2201@mailinator.com",
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
                        child: Text("8320591644", style: AppTextStyle.subTitle))
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
          GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            cacheExtent: 30,
            physics: const ClampingScrollPhysics(),
            itemCount: 5,
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
                    image: const DecorationImage(
                        image: NetworkImage(
                            "https://www.promotionalwears.com/image/cache/catalog/data/Trophies/custom-trophy/global-achievement-award-trophy-750x750.png"),
                        fit: BoxFit.cover)),
              );
            },
          ),
          SizedBoxH34(),
        ],
      ),
    );
  }
}
