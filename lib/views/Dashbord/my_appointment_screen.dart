import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/app_color.dart';
import '../../utils/app_sizes.dart';
import '../../utils/app_text_style.dart';
import '../../utils/screen_utils.dart';
import '../../widget/drawer_widget.dart';
import '../../widget/primary_appbar.dart';
import '../../widget/primary_bottom_navigation_bar.dart';
import '../../widget/scrollview.dart';

class MyAppointmentScreen extends StatefulWidget {
  const MyAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<MyAppointmentScreen> createState() => _MyAppointmentScreenState();
}

class _MyAppointmentScreenState extends State<MyAppointmentScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController? tabController;
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController =
        TabController(length: 3, vsync: this, animationDuration: Duration.zero);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [
            pendingList(context),
            upComingList(context),
            completedList(context)
          ]),
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
      appBar: TabAppBar(
        onTap: () {},
        title: "My Appointment",
        action: const SizedBox.shrink(),
        leading: Container(

          child: IconButton(
              onPressed: () {
                openDrawer();
              },
              icon: const Icon(
                Icons.menu_sharp,
                color: AppColor.orange,
              )),
        ),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: Sizes.s20.w, left: Sizes.s10.w, right: Sizes.s10.w),
              child: Container(
                //alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                  horizontal: Sizes.s5.w,
                  vertical: Sizes.s5.h,
                ),
                width: ScreenUtil().screenWidth,
                height: 60,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TabBar(
                  controller: tabController,
                  onTap: (index) {},
                  indicatorPadding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.zero,


                  padding: EdgeInsets.zero,

                  tabs: const [
                    Tab(text: "Pending"),
                    Tab(text: "Upcoming"),
                    Tab(text: "Completed"),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget pendingList(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: Sizes.s20.h),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, inx) {
        return const Text("Open");
      },
    );
  }

  Widget upComingList(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: Sizes.s20.h),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, inx) {
        return const Text("up coming");
      },
    );
  }

  Widget completedList(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: Sizes.s20.h),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, inx) {
        return const Text("completed");
      },
    );
  }
}
