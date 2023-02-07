import 'package:doctor_on_call/utils/app_sizes.dart';
import 'package:doctor_on_call/utils/app_text_style.dart';
import 'package:doctor_on_call/widget/custom_sized_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/app_color.dart';
import '../../utils/constant.dart';
import '../../widget/primary_appbar.dart';
import '../../widget/primary_botton.dart';
import '../../widget/primary_textfield.dart';
import '../../widget/scrollview.dart';

class WalletMainScreen extends StatefulWidget {
  const WalletMainScreen({Key? key}) : super(key: key);

  @override
  State<WalletMainScreen> createState() => _WalletMainScreenState();
}

class _WalletMainScreenState extends State<WalletMainScreen> {
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
          child: CustomScroll(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                  SizedBoxH28(),
                  orderListContainer("850"),
                  SizedBoxH28(),

                   Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              padding: EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black12)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBoxH10(),
                  Text(
                    "Add Amount",
                    style: AppTextStyle.appBarTextTitle,
                  ),
                  SizedBoxH20(),

                     PrimaryTextField(
                      controller: _amountController,
                      hintText: "Enter Amount",
                      prefix: const Icon(Icons.currency_rupee),
                       textInputAction: TextInputAction.next,

                    ),
                    // TextFormField(
                    //     obscureText: true,
                    //     style: TextStyle(fontSize: 16),
                    //     controller: _amountController,
                    //     textInputAction: TextInputAction.next,
                    //     decoration: InputDecoration(
                    //       hintText: "Enter amount",
                    //
                    //       isDense: true,
                    //       enabledBorder: OutlineInputBorder(
                    //           borderRadius:
                    //           BorderRadius.circular(12.0),
                    //           borderSide: BorderSide(
                    //               width: 0.8, color: Colors.black12)),
                    //       focusedBorder: OutlineInputBorder(
                    //           borderRadius:
                    //           BorderRadius.circular(8.0),
                    //           borderSide: BorderSide(
                    //               width: 1.5, color: Colors.black12)),
                    //
                    //       //  hintStyle: CustomTextstyleTheme.inputFieldHintStyle,
                    //     )),

                  SizedBoxH20(),
                  Text(
                    "Quick ammount",
                    style: AppTextStyle.appBarTextTitle,
                  ),
                  SizedBoxH28(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border:
                            Border.all(color: Colors.black12)),
                        child: FittedBox(
                          child: Text("500"),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border:
                            Border.all(color: Colors.black12)),
                        child: FittedBox(
                          child: Text("1000"),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border:
                            Border.all(color: Colors.black12)),
                        child: FittedBox(
                          child: Text("2000"),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border:
                            Border.all(color: Colors.black12)),
                        child: FittedBox(
                          child: Text("2500"),
                        ),
                      )
                    ],
                  ),
                  SizedBoxH28(),
                  PrimaryButton(
                    lable: 'continue',
                    onPressed: () {  },
                  ),
                ],
              ),
            ),),
            ],

          )),
      appBar: SecondaryAppBar(
          title: "Wallet",
          isLeading: true,
          onBackPressed: () {
            Navigator.pop(context);
          },
    )
    );

  }
  Widget orderListContainer(String? balance,) {
    return Container(
     width: double.infinity,
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(textFieldBorderRadius),
          border: Border.all(color: AppColor.primaryColor)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:  [
            SizedBoxH10(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Balance available",style: AppTextStyle.appBarTextTitle.copyWith(color: AppColor.white)),
                      Icon(Icons.account_balance_wallet_outlined,color: AppColor.white,)
                    ],
                  ),

            SizedBoxH20(),
            Align(alignment: Alignment.topLeft,
                child: Text("₹${balance}",style: AppTextStyle.bigTextTile.copyWith(color: AppColor.white),)),
            SizedBoxH10(),
          ],
        ),
      ),
    );
  }
}
