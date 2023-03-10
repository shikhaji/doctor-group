import 'package:dio/dio.dart';
import 'package:doctor_on_call/models/get_wallet_model.dart';
import 'package:doctor_on_call/services/api_services.dart';
import 'package:doctor_on_call/services/shared_referances.dart';
import 'package:doctor_on_call/utils/app_sizes.dart';
import 'package:doctor_on_call/utils/app_text.dart';
import 'package:doctor_on_call/utils/app_text_style.dart';
import 'package:doctor_on_call/utils/validation_mixin.dart';
import 'package:doctor_on_call/widget/custom_sized_box.dart';
import 'package:doctor_on_call/widget/primary_appbar.dart';
import 'package:doctor_on_call/widget/scrollview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../routs/app_routs.dart';
import '../../../utils/app_color.dart';
import '../../../utils/constant.dart';
import '../../../widget/primary_botton.dart';
import '../../../widget/primary_textfield.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> with ValidationMixin {
  final TextEditingController _amountController = TextEditingController();
  late var _razorpay;
  String? paymentId;
  final _formKey = GlobalKey<FormState>();
  GetWalletModel? getWalletModel;
  String? loginId;
  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    getLoginId();
    ApiService().getWalletBalance().then((value) {
      setState(() {
        getWalletModel = value;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _amountController.clear();
  }

  Future<void> getLoginId() async {
    String? id = await Preferances.getString("userId");
    setState(() {
      loginId = id;
    });
  }

  List<AmountModel?> amountList = [
    AmountModel(amount: "50", selected: false),
    AmountModel(amount: "100", selected: false),
    AmountModel(amount: "500", selected: false),
    AmountModel(amount: "1000", selected: false),
    AmountModel(amount: "2000", selected: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.white,
        body: SafeArea(
            child: Form(
                key: _formKey,
                child: CustomScroll(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBoxH28(),
                    balanceContainer(
                        "${getWalletModel != null && getWalletModel!.balance != null ? getWalletModel!.balance : " 0"}"),
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
                            validator: amountValidator,
                            prefix: const Icon(Icons.currency_rupee),
                            keyboardInputType: TextInputType.number,
                          ),
                          SizedBoxH20(),
                          const Text(
                            "Quick amount",
                            style: AppTextStyle.appBarTextTitle,
                          ),
                          SizedBoxH28(),
                          amountContainer(),
                          SizedBoxH28(),
                          PrimaryButton(
                            lable: 'continue',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                var options = {
                                  'key': 'rzp_test_YoriHE0YT6XVEs',
                                  'amount':
                                      int.parse(_amountController.text) * 100,
                                  'name': 'Doctor On Call',
                                  'description': 'Payment',
                                  'send_sms_hash': true,
                                  'prefill': {
                                    'contact': 'Hina Patel',
                                    'email': 'hp@mailinator.com',
                                    'phone': '8320591633',
                                  },
                                };
                                _razorpay.open(options);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ))),
        appBar: SecondaryAppBar(
          title: "Wallet",
          isLeading: true,
          onBackPressed: () {
            Navigator.pop(context);
          },
        ));
  }

  Widget amountContainer() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: List.generate(amountList.length, (index) {
        return GestureDetector(
            onTap: () {
              setState(() {
                _amountController.text = "${amountList[index]!.amount}";
              });
            },
            child: Container(
              margin: const EdgeInsets.all(6),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black12)),
              child: Text("${amountList[index]!.amount}"),
            ));
      })),
    );
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

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    paymentId = response.paymentId;
    _amountController.clear();

    try {
      ApiService()
          .addWallet(context,
              data: FormData.fromMap({
                "loginid":
                    loginId!.replaceAll('"', '').replaceAll('"', '').toString(),
                "amount": _amountController.text.trim(),
                "payment_type": "1",
                "transactionid": paymentId,
              }))
          .then((value) {
        print("api call done");

        Navigator.pushNamed(context, Routs.transactionHistory);
        ApiService().getWalletBalance().then((value) {
          setState(() {
            getWalletModel = value;
          });
        });
      });
    } catch (e) {
      debugPrint("errror here:=${e.toString()}");
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
      msg: 'Payment Failed',
      backgroundColor: Colors.grey,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }
}

class AmountModel {
  String? amount;
  bool? selected;
  AmountModel({this.amount, this.selected});
}
