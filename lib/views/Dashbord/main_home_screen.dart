import 'dart:developer';

import 'package:doctor_on_call/views/Dashbord/home_screen.dart';
import 'package:doctor_on_call/views/Dashbord/my_appointment_screen.dart';
import 'package:doctor_on_call/views/Dashbord/my_order_screen.dart';
import 'package:doctor_on_call/views/Dashbord/services_screen.dart';
import 'package:flutter/material.dart';

import '../../utils/app_color.dart';
import '../../utils/app_sizes.dart';
import '../../utils/app_text_style.dart';
import '../../utils/screen_utils.dart';
import '../../widget/drawer_widget.dart';
import '../../widget/primary_bottom_navigation_bar.dart';

import 'doctor_services/doctor_profile__list_screen.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  final ValueNotifier<int> _currentIndexNotifier = ValueNotifier(0);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // void openDrawer() {
  //   _scaffoldKey.currentState?.openDrawer();
  // }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: _currentIndexNotifier,
      builder: (context, currentIndex, child) {
        return Scaffold(
          key: _scaffoldKey,
          body: _buildBody(currentIndex),
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

  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const MyAppointmentScreen();
      case 2:
        return const MyOrderScreen();
      case 3:
        return const ServicesScreen();
      default:
    }
    return Container();
  }
}
