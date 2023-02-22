import 'package:doctor_on_call/models/get_transation_model.dart';
import 'package:doctor_on_call/services/api_services.dart';
import 'package:doctor_on_call/utils/app_color.dart';
import 'package:doctor_on_call/utils/app_text_style.dart';
import 'package:doctor_on_call/widget/custom_sized_box.dart';
import 'package:doctor_on_call/widget/primary_appbar.dart';
import 'package:doctor_on_call/widget/scrollview.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  List<TransactionHistoryList> transactionHistoryList = [];

  @override
  void initState() {
    ApiService().getTransactionHistoryApi().then((value) {
      setState(() {
        transactionHistoryList = value!.history;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.white,
        body: SafeArea(
            child: CustomScroll(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBoxH28(),
            ListView.builder(
                itemCount: transactionHistoryList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: const Icon(Icons.wallet_giftcard_outlined),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transactionHistoryList[index].branchName,
                          style: AppTextStyle.textFieldFont,
                        ),
                        Text(
                          transactionHistoryList[index].cwtDate != ""
                              ? "Payment on ${DateFormat('MMM dd, hh:mma').format(DateTime.parse(transactionHistoryList[index].cwtTt.toString())).toString()}"
                              : "",
                          style: AppTextStyle.subTitle2,
                        ),
                      ],
                    ),
                    trailing: Text(
                        "+ ${transactionHistoryList[index].cwtAmount}",
                        style: AppTextStyle.greySubTitle
                            .copyWith(color: Colors.green)),
                  );
                })
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
