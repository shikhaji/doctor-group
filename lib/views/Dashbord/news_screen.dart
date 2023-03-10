import 'package:doctor_on_call/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

import '../../models/latest_news_model.dart';
import '../../services/api_services.dart';
import '../../utils/app_color.dart';
import '../../widget/custom_sized_box.dart';
import '../../widget/primary_appbar.dart';
import '../../widget/scrollview.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<LatestNewsList> latestNewsList = [];
  @override
  void initState() {
    ApiService().latestNews(context).then((value) {
      setState(() {
        latestNewsList = value.message!.notice!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(
        title: "Latest News",
        isLeading: true,
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: CustomScroll(
        children: [
          SizedBoxH18(),
          SizedBoxH18(),
          ListView.separated(
            shrinkWrap: true,
            itemCount: latestNewsList.length,
            separatorBuilder: (BuildContext context, int inx) =>
                const Divider(),
            itemBuilder: (BuildContext context, int inx) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    latestNewsList[inx].newsDesc,
                    style: AppTextStyle.textFieldFont,
                  ),
                  Text(
                    latestNewsList[inx].newsLink,
                    style:
                        AppTextStyle.redTextStyle.copyWith(color: Colors.red),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
