// Html(
// data: getAboutUsData != null && getAboutUsData!.aboutUs != null
// ? getAboutUsData!.aboutUs.toString()
// : "",
// ),

import 'package:doctor_on_call/models/privacy_policy_model.dart';
import 'package:doctor_on_call/services/api_services.dart';
import 'package:flutter/material.dart';
import '../../utils/app_color.dart';
import '../../widget/primary_appbar.dart';
import '../../widget/scrollview.dart';
import 'package:flutter_html/flutter_html.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  PrivacyPolicyModel? _privacyPolicyModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiService().privacyPolicy(context).then((value) {
      setState(() {
        _privacyPolicyModel = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScroll(
          children: [
            Html(
              data: _privacyPolicyModel != null &&
                      _privacyPolicyModel!.message != null
                  ? _privacyPolicyModel!.message!.orgPrivacyPolicy.toString()
                  : "",
            ),
          ],
        ),
        appBar: const SecondaryAppBar(
          title: "Privacy Policy",
          isLeading: true,
        ));
  }
}
