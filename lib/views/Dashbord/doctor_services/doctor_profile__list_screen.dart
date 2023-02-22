import 'package:doctor_on_call/routs/app_routs.dart';
import 'package:doctor_on_call/services/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../models/get_all_profile_model.dart';
import '../../../routs/arguments.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_sizes.dart';
import '../../../utils/app_text.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/constant.dart';
import '../../../widget/custom_sized_box.dart';
import '../../../widget/primary_appbar.dart';
import '../../../widget/primary_botton.dart';
import '../../../widget/scrollview.dart';

class DoctorProfileList extends StatefulWidget {
  final SendArguments? arguments;

  const DoctorProfileList({Key? key, this.arguments}) : super(key: key);

  @override
  State<DoctorProfileList> createState() => _DoctorProfileListState();
}

class _DoctorProfileListState extends State<DoctorProfileList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<GetAllProfileList> _getAllProfileList = [];
  @override
  void initState() {
    super.initState();
    print("PTID:=${widget.arguments?.ptId}");
    print("CTID:=${widget.arguments?.catId}");
    ApiService()
        .getAllProfileList(
            "${widget.arguments?.ptId}", "${widget.arguments?.catId}")
        .then((value) {
      if (value != null) {
        setState(() {
          _getAllProfileList = value.message!;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _getAllProfileList.isNotEmpty
          ? CustomScroll(
              children: [
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: Sizes.s20.h),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _getAllProfileList.length,
                  itemBuilder: (context, inx) {
                    return orderListContainer(
                        name: _getAllProfileList[inx].branchName ?? '',
                        imgPath:
                            'https://www.desktopbackground.org/download/1024x768/2014/01/01/694300_daniels-statistics-analysis-name-meaning-list-of-firstnames_1920x1200_h.jpg',
                        experience: '3-Years',
                        address: _getAllProfileList[inx].branchAddress ?? "",
                        specialist: '${_getAllProfileList[inx].speciality}',
                        viewProfileCallBack: () {},
                        bookAppointmentCallBack: () {
                          if (_getAllProfileList[inx].pTSCREEN == "1") {
                            Navigator.pushNamed(context, Routs.bookAppointment,
                                arguments: SendArguments(
                                    doctorId:
                                        _getAllProfileList[inx].branchId));
                          } else if (_getAllProfileList[inx].pTSCREEN == "2") {
                            Navigator.pushNamed(
                                context, Routs.pathologyAndChemistForm);
                          } else {
                            Fluttertoast.showToast(
                              msg: 'Call Ambulance',
                              backgroundColor: Colors.grey,
                            );
                          }
                        });
                  },
                )
              ],
            )
          : Center(
              child: appText("No Doctor", style: AppTextStyle.blackSubTitle),
            ),
      appBar: const SecondaryAppBar(
        title: "Doctors",
        isLeading: true,
      ),
    );
  }

  Widget orderListContainer(
      {required String name,
      required String imgPath,
      required String experience,
      required String address,
      required String specialist,
      required VoidCallback viewProfileCallBack,
      required VoidCallback bookAppointmentCallBack}) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: Sizes.s9),
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
                          image: NetworkImage(imgPath),
                        ))),
                SizedBoxW8(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    appText(name,
                        style: AppTextStyle.alertSubtitle
                            .copyWith(fontSize: Sizes.s16.h)),
                    SizedBoxH6(),
                    appText(specialist,
                        style: AppTextStyle.alertSubtitle
                            .copyWith(fontSize: Sizes.s16.h)),
                    SizedBoxH6(),
                    appText(experience,
                        style: AppTextStyle.alertSubtitle
                            .copyWith(fontSize: Sizes.s16.h)),
                    SizedBoxH6(),
                    appText(
                      address,
                      style: AppTextStyle.alertSubtitle
                          .copyWith(fontSize: Sizes.s16.h),
                    )
                  ],
                ),
              ],
            ),
            SizedBoxH10(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  lable: "View profile",
                  color: AppColor.primaryColor,
                  onPressed: viewProfileCallBack,
                ),
                SizedBoxW10(),
                Expanded(
                  child: CustomButton(
                    lable: "Book Appointment",
                    color: AppColor.white,
                    bgColor: AppColor.primaryColor,
                    onPressed: bookAppointmentCallBack,
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
