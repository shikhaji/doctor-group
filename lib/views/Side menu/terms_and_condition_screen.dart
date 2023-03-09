import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../models/terms_and_condition_model.dart';
import '../../services/api_services.dart';
import '../../widget/primary_appbar.dart';
import '../../widget/scrollview.dart';

class TermsAndConditionScreen extends StatefulWidget {
  const TermsAndConditionScreen({Key? key}) : super(key: key);

  @override
  State<TermsAndConditionScreen> createState() =>
      _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
  TermsAndConditionModel? _termsAndConditionModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiService().termsAndCondition(context).then((value) {
      setState(() {
        _termsAndConditionModel = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScroll(
          children: [
            Html(
              data: _termsAndConditionModel != null &&
                      _termsAndConditionModel!.message != null
                  ? _termsAndConditionModel!.message.orgTermsConditions
                  : "",
            ),
          ],
        ),
        appBar: const SecondaryAppBar(
          title: "Terms and condition",
          isLeading: true,
        ));
  }
}
