import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../models/about_us_model.dart';
import '../../services/api_services.dart';
import '../../widget/primary_appbar.dart';
import '../../widget/scrollview.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  AboutUsModel? _aboutUsModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiService().aboutUs(context).then((value) {
      setState(() {
        _aboutUsModel = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScroll(
          children: [
            Html(
              data: _aboutUsModel != null && _aboutUsModel!.message != null
                  ? _aboutUsModel!.message.aboutUs
                  : "",
            ),
          ],
        ),
        appBar: const SecondaryAppBar(
          title: "About Us",
          isLeading: true,
        ));
  }
}
