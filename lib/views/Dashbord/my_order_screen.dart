import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/app_sizes.dart';
import '../../utils/screen_utils.dart';
import '../../widget/drawer_widget.dart';
import '../../widget/primary_appbar.dart';
import '../../widget/scrollview.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
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
            const SizedBox(
              height: 100,
            ),
            ListView.builder(
              padding: EdgeInsets.symmetric(vertical: Sizes.s20.h),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, inx) {
                return orderListContainer("hina");
              },
            )
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
        appBar: SecondaryAppBar(
          title: "My Order",
          isLeading: true,
          onBackPressed: () {
            openDrawer();
          },
          leadingIcon: Icons.menu,
        ));
  }

  Widget orderListContainer(String title) {
    return Text(title);
  }
}
