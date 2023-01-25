import 'package:doctor_on_call/utils/app_color.dart';
import 'package:doctor_on_call/utils/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_asset.dart';
import '../utils/screen_utils.dart';

class PrimaryBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const PrimaryBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      onTap: onTap,
      showSelectedLabels: true,
      selectedLabelStyle:
          AppTextStyle.body1.copyWith(color: AppColor.primaryColor),
      unselectedLabelStyle: AppTextStyle.body1,
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(
          label: 'Home',
          icon: _buildImageIcon(AppAsset.homeFill),
          activeIcon: _buildImageIcon(AppAsset.home),
        ),
        BottomNavigationBarItem(
          label: 'Agreement',
          icon: _buildImageIcon(AppAsset.home),
          activeIcon: _buildImageIcon(AppAsset.homeFill),
        ),
        BottomNavigationBarItem(
          label: 'Messages',
          icon: _buildImageIcon(AppAsset.home),
          activeIcon: _buildImageIcon(AppAsset.homeFill),
        ),
        BottomNavigationBarItem(
          label: 'Profile',
          icon: _buildImageIcon(AppAsset.home),
          activeIcon: _buildImageIcon(AppAsset.homeFill),
        ),
      ],
    );
  }

  Widget _buildImageIcon(String imagePath, {double size = 22}) {
    return Image.asset(
      imagePath,
      height: ScreenUtil().setHeight(size),
      width: ScreenUtil().setHeight(size),
    );
  }
}
