import 'package:doctor_on_call/utils/app_text_style.dart';
import 'package:doctor_on_call/widget/custom_sized_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/app_color.dart';
import '../../widget/primary_appbar.dart';
import '../../widget/primary_botton.dart';
import '../../widget/scrollview.dart';

class MeetingSchedule extends StatefulWidget {
  const MeetingSchedule({Key? key}) : super(key: key);

  @override
  State<MeetingSchedule> createState() => _MeetingScheduleState();
}

class _MeetingScheduleState extends State<MeetingSchedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScroll(
        children: [
          SizedBox(
            height: 100,
          ),
          Container(
             alignment: Alignment.topLeft,
              child: Text("Select Date: ", style: AppTextStyle.headingTextTile,)),
          SizedBoxH8(),
          Container(
            height: 90,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                dates("Mon","21",true),
                dates("Tue","22",false),
                dates("Wed","23",false),
                dates("Thu","24",false),
                dates("Fri","25",false),
                dates("Sat","26",false),
                dates("Sun","27",false),
              ],
            ),

          ),
          SizedBoxH34(),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text("From Start",style: AppTextStyle.headingTextTile,),
                    SizedBoxH8(),
                    CustomButton(
                      lable: "Start Time",
                      color: AppColor.primaryColor,
                      onPressed: () {},
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text("To Start",style: AppTextStyle.headingTextTile,),
                    SizedBoxH8(),
                    CustomButton(
                      lable: "End Time",
                      color: AppColor.primaryColor,
                      onPressed: () {},
                    ),
                  ],
                ),



              ],
            ),

          ),
          SizedBoxH34(),
          SizedBoxH34(),
          PrimaryButton(lable: "Schedule Meeting", onPressed: (){}, )
        ],
      ),
      appBar: SecondaryAppBar(
        title: "Meeting Schedule",
        isLeading: true,
        leadingIcon: Icons.arrow_back_ios,
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
  dates(String day, String date, bool isSelected){
    return isSelected? Container(
      width: 70,
      margin: EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Text(day,style: AppTextStyle.buttonTextStyle,),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            padding: EdgeInsets.all(7),
            child: Text(date,style: AppTextStyle.buttonTextStyle,),
          )
        ],
      ),
    ) :Container(
    width: 70,
    margin: EdgeInsets.only(right: 15),
    decoration: BoxDecoration(
    color: AppColor.textFieldColor,
    borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
    Container(
    child: Text(day,style: AppTextStyle.buttonTextStyle.copyWith(color: AppColor.black),),
    ),
    Container(
    margin: EdgeInsets.only(top: 15),
    padding: EdgeInsets.all(7),
    child: Text(date,style: AppTextStyle.buttonTextStyle.copyWith(color: AppColor.black),),
    )
    ],
    ),
    );
  }
}
