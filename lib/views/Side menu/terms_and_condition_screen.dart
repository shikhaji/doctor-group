import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widget/primary_appbar.dart';
import '../../widget/scrollview.dart';

class TermsAndConditionScreen extends StatefulWidget {
  const TermsAndConditionScreen({Key? key}) : super(key: key);

  @override
  State<TermsAndConditionScreen> createState() => _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


        body: CustomScroll(
          children: [



          ],
        ),
        appBar: SecondaryAppBar(
          title: "Terms And Condition",
          isLeading: true,
          leadingIcon: Icons.menu,
          onBackPressed: () {
            Navigator.pop(context);
          },
        ));
  }
}
