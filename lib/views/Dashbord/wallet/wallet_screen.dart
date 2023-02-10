import 'package:doctor_on_call/utils/app_sizes.dart';
import 'package:doctor_on_call/utils/app_text.dart';
import 'package:doctor_on_call/utils/app_text_style.dart';
import 'package:doctor_on_call/widget/custom_sized_box.dart';
import 'package:doctor_on_call/widget/primary_appbar.dart';
import 'package:doctor_on_call/widget/scrollview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../routs/app_routs.dart';
import '../../../utils/app_color.dart';
import '../../../utils/constant.dart';
import '../../../widget/primary_botton.dart';
import '../../../widget/primary_textfield.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
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
            balanceContainer("850"),
            SizedBoxH28(),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routs.transactionHistory);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Show All Transaction History",
                    style: AppTextStyle.lable.copyWith(
                        color: AppColor.orange,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
            SizedBoxH28(),
            Container(
              padding: const EdgeInsets.only(
                  top: 12, left: 12, right: 12, bottom: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black12)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBoxH10(),
                  const Text(
                    "Add Amount",
                    style: AppTextStyle.appBarTextTitle,
                  ),
                  SizedBoxH20(),
                  PrimaryTextField(
                    controller: _amountController,
                    hintText: "Enter Amount",
                    prefix: const Icon(Icons.currency_rupee),
                    keyboardInputType: TextInputType.number,
                  ),
                  SizedBoxH20(),
                  const Text(
                    "Quick amount",
                    style: AppTextStyle.appBarTextTitle,
                  ),
                  SizedBoxH28(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.black12)),
                        child: const FittedBox(
                          child: Text("500"),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.black12)),
                        child: const FittedBox(
                          child: Text("1000"),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.black12)),
                        child: const FittedBox(
                          child: Text("2000"),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.black12)),
                        child: const FittedBox(
                          child: Text("2500"),
                        ),
                      )
                    ],
                  ),
                  SizedBoxH28(),
                  PrimaryButton(
                    lable: 'continue',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        )),
        appBar: SecondaryAppBar(
          title: "Wallet",
          isLeading: true,
          onBackPressed: () {
            Navigator.pop(context);
          },
        ));
  }

  Widget balanceContainer(
    String? balance,
  ) {
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
          children: [
            SizedBoxH10(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Balance available",
                    style: AppTextStyle.appBarTextTitle
                        .copyWith(color: AppColor.white)),
                const Icon(
                  Icons.account_balance_wallet_outlined,
                  color: AppColor.white,
                )
              ],
            ),
            SizedBoxH20(),
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "₹${balance}",
                  style:
                      AppTextStyle.bigTextTile.copyWith(color: AppColor.white),
                )),
            SizedBoxH10(),
          ],
        ),
      ),
    );
  }
}
