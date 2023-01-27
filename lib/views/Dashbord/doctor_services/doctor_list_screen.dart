import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_sizes.dart';
import '../../../utils/app_text.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/constant.dart';
import '../../../utils/screen_utils.dart';
import '../../../widget/custom_sized_box.dart';
import '../../../widget/drawer_widget.dart';
import '../../../widget/primary_botton.dart';
import '../../../widget/scrollview.dart';

class DoctorList extends StatefulWidget {
  const DoctorList({Key? key}) : super(key: key);

  @override
  State<DoctorList> createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: CustomScroll(
        children: [
          // todo slider
          SizedBox(
            height: 20,
          ),
          ListView.builder(
            padding: EdgeInsets.symmetric(vertical: Sizes.s20.h),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, inx) {
              return orderListContainer("hina","https://www.desktopbackground.org/download/1024x768/2014/01/01/694300_daniels-statistics-analysis-name-meaning-list-of-firstnames_1920x1200_h.jpg","Cardio Specialist","3-Years","Gujarat");
            },
          )
        ],
      ),

      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Doctors",
            style: AppTextStyle.appBarTitle,
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColor.white,
              ))),
    );
  }
  Widget orderListContainer(String name,String imgpath,String experience,String address,String specialist) {
    return  Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(textFieldBorderRadius),
          border: Border.all(color: AppColor.grey)),

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    height: Sizes.s80.h,
                    width: Sizes.s80.h,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage("${imgpath}"),
                        ))),
                SizedBoxW8(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    appText("${name}", style:AppTextStyle.alertSubtitle.copyWith(fontSize: Sizes.s16.h)),
                    SizedBoxH6(),
                    appText("${specialist}", style:AppTextStyle.alertSubtitle.copyWith(fontSize: Sizes.s16.h)),
                    SizedBoxH6(),
                    appText("${experience}", style:AppTextStyle.alertSubtitle.copyWith(fontSize: Sizes.s16.h)),
                    SizedBoxH6(),
                    appText("${address}", style:AppTextStyle.alertSubtitle.copyWith(fontSize: Sizes.s16.h),)
                  ],
                ),


              ],
            ),
            SizedBoxH10(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColor.primaryColor,width: 1 )),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: appText("View Profile",style:AppTextStyle.alertSubtitle.copyWith(fontSize: Sizes.s16.h,color: AppColor.primaryColor)),
                  ),
                ),
                Container(
                 // color: AppColor.primaryColor,
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColor.primaryColor,)),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: appText("Book Appointment",style:AppTextStyle.alertSubtitle.copyWith(fontSize: Sizes.s16.h,color: AppColor.white)),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
