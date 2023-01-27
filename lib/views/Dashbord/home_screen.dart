import 'package:doctor_on_call/utils/app_asset.dart';
import 'package:doctor_on_call/utils/app_color.dart';
import 'package:doctor_on_call/utils/app_text_style.dart';
import 'package:doctor_on_call/widget/scrollview.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utils/app_sizes.dart';
import '../../utils/screen_utils.dart';
import '../../widget/custom_container_box.dart';
import '../../widget/drawer_widget.dart';
import '../../widget/primary_bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: CustomScroll(
        children: [
          // todo slider
          SizedBox(
            height: 100,
          ),

          GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            cacheExtent: 30,
            physics: const ClampingScrollPhysics(),
            itemCount: _homeData.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 12 / 9,
              crossAxisSpacing: Sizes.s20.h,
              mainAxisSpacing: Sizes.s20.h,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    _homeData[index].onPressed.toString(),
                  );
                },
                child: CustomContainerBox(
                  title: _homeData[index].name.toString(),
                  icon: _homeData[index].icon.toString(),
                ),
              );
            },
          ),
        ],
      ),
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Home",
            style: AppTextStyle.appBarTitle,
          ),
          leading: IconButton(
              onPressed: () {
                openDrawer();
              },
              icon: Icon(
                Icons.menu_sharp,
                color: AppColor.white,
              ))),
    );
  }

  final List<HomeData> _homeData = [
    HomeData(
        name: 'Meeting Schedule',
        icon: AppAsset.meetingSchedule,
        //onPressed: ""
    ),
    HomeData(name: 'Wallets', icon: AppAsset.wallets,
        //onPressed: ""
    ),
    HomeData(
        name: 'My Appoinments',
        icon: AppAsset.myAppointmentIcon,
        ),
  ];
}

class HomeData {
  String? name;
  String? icon;
  String? onPressed;

  HomeData({this.name, this.icon, this.onPressed});
}
