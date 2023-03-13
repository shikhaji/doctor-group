import 'package:doctor_on_call/utils/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Dialogs/download_image_dialog.dart';
import '../../Dialogs/upload_image_dailog.dart';
import '../../models/get_my_order_model.dart';
import '../../routs/arguments.dart';
import '../../services/api_services.dart';
import '../../services/shared_referances.dart';
import '../../utils/app_color.dart';
import '../../utils/app_sizes.dart';
import '../../utils/screen_utils.dart';
import '../../widget/custom_sized_box.dart';
import '../../widget/drawer_widget.dart';
import '../../widget/primary_appbar.dart';
import '../../widget/scrollview.dart';
import 'my_appointment_screen.dart';

class MyOrderScreen extends StatefulWidget {
  final SendArguments? arguments;
  const MyOrderScreen({Key? key, this.arguments}) : super(key: key);

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  List<GetOrderList> getOrderList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrderData();
  }

  Future<void> getOrderData() async {
    String? id = await Preferances.getString("userId");
    ApiService()
        .getMyOrder(id!.replaceAll('"', '').replaceAll('"', '').toString())
        .then((value) {
      if (value != null) {
        setState(() {
          getOrderList = value.profile;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(
        title: "My Order",
        isLeading: widget.arguments?.backIcon == false ? false : true,
      ),
      body: getOrderList.isEmpty
          ? const Center(
              child: Text("No Order", style: AppTextStyle.blackSubTitle),
            )
          : CustomScroll(
              children: [
                ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: Sizes.s20.h),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: getOrderList.length,
                  itemBuilder: (context, inx) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: Sizes.s12),
                      padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.s12, vertical: Sizes.s18),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizes.s12),
                          border: Border.all(
                              color: AppColor.textFieldColor, width: Sizes.s2)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Refer By := ",
                                style: AppTextStyle.greySubTitle,
                              ),
                              Expanded(
                                child: Text(
                                  "${getOrderList[inx].upbpReferBy}",
                                  style: AppTextStyle.textFieldFont,
                                ),
                              )
                            ],
                          ),
                          SizedBoxH10(),
                          Row(
                            children: [
                              const Text(
                                "Short Description := ",
                                style: AppTextStyle.greySubTitle,
                              ),
                              Expanded(
                                child: Text(
                                  getOrderList[inx].upbpDesc,
                                  style: AppTextStyle.textFieldFont,
                                ),
                              )
                            ],
                          ),
                          SizedBoxH18(),
                          completeAndCancel("Upload", "Download",
                              onTapComplete: () {
                            UploadImagePickerDailog.show(
                                context, getOrderList[inx].loginId, 1);
                          }, onTapCancel: () {
                            DownloadImagePickerDailog.show(
                                context, getOrderList[inx].upbpReportFile);
                          })
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
    );
  }

  Widget orderListContainer(String title) {
    return Text(title);
  }
}
