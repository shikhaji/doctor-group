import 'package:doctor_on_call/utils/app_color.dart';
import 'package:doctor_on_call/widget/custom_sized_box.dart';
import 'package:doctor_on_call/widget/primary_appbar.dart';
import 'package:doctor_on_call/widget/scrollview.dart';
import 'package:flutter/material.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.white,
        body: SafeArea(
            child: CustomScroll(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBoxH28(),
          ],
        )),
        appBar: SecondaryAppBar(
          title: "Transaction History",
          isLeading: true,
          onBackPressed: () {
            Navigator.pop(context);
          },
        ));
  }
}
