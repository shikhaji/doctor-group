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
  final ValueNotifier<int> _currentIndexNotifier = ValueNotifier(0);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _currentIndexNotifier,
      builder: (context, currentIndex, child) {
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
                  childAspectRatio: 16 / 9,
                  crossAxisSpacing: Sizes.s10.h,
                  mainAxisSpacing: Sizes.s10.h,
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
                      //icon:  Icon(_homeData[index].icon.toString()),
                    ),
                  );
                },
              ),
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
              title: Text(
                "Home",
                style: AppTextStyle.appBarTitle,
              ),
              leading: IconButton(
                  onPressed: () {
                    // _scaffoldKey.currentState!.isDrawerOpen;
                    openDrawer();
                  },
                  icon: Icon(
                    Icons.menu_sharp,
                    color: AppColor.white,
                  ))),
          bottomNavigationBar: PrimaryBottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              _currentIndexNotifier.value = index;
            },
          ),
        );
      },
    );
  }

  final List<HomeData> _homeData = [
    HomeData(
        name: 'Meeting Schedule',
        icon: FontAwesomeIcons.handshake,
        onPressed: ""),
    HomeData(name: 'Wallets', icon: FontAwesomeIcons.wallet, onPressed: ""),
    HomeData(
        name: 'My Appoinments', icon: FontAwesomeIcons.calendar, onPressed: ""),
  ];
}

class HomeData {
  String? name;
  IconData? icon;
  String? onPressed;

  HomeData({this.name, this.icon, this.onPressed});
}
