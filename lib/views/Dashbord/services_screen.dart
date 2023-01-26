import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/app_color.dart';
import '../../utils/app_sizes.dart';
import '../../utils/app_text_style.dart';
import '../../utils/screen_utils.dart';
import '../../widget/drawer_widget.dart';
import '../../widget/primary_bottom_navigation_bar.dart';
import '../../widget/scrollview.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: const CustomScroll(
        children: [
          // todo slider
          SizedBox(
            height: 100,
          ),
          Text("Services")
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        elevation: 0,
        width: ScreenUtil().screenWidth * 0.8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(Sizes.s20.r),
            bottomRight: Radius.circular(Sizes.s20.r),
          ),
        ),
        child: const DrawerWidget(),
      ),
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Services",
            style: AppTextStyle.appBarTitle,
          ),
          leading: IconButton(
              onPressed: () {
                openDrawer();
              },
              icon: const Icon(
                Icons.menu_sharp,
                color: AppColor.white,
              ))),
    );
  }
}
