import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_sizes.dart';
import 'create_material_color.dart';

class AppTextStyle {
  AppTextStyle._();

  static ThemeData lightTheme = ThemeData(
      primaryColor: AppColor.primaryColor,
      tabBarTheme: lightTabBarTheme,
      primarySwatch: createMaterialColor(const Color(0xff33cc99)),
      fontFamily: "Nunito_Sans");




  static TabBarTheme get lightTabBarTheme {
    return TabBarTheme(
      labelColor: AppColor.orange,
      labelStyle: AppTextStyle.redTextStyle,
      unselectedLabelColor: AppColor.unSelectedTabBarColor,
      unselectedLabelStyle: AppTextStyle.greySubTitle,
      indicator: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(50)),
    );
  }

  static const TextStyle headline1 = TextStyle(
    fontSize: Sizes.s28,
    fontWeight: FontWeight.w900,
    color: AppColor.white,
  );

  static const TextStyle title = TextStyle(
      fontSize: Sizes.s26, fontWeight: FontWeight.w700, color: AppColor.black);
  static const TextStyle lable = TextStyle(
      fontSize: Sizes.s16, fontWeight: FontWeight.w500, color: AppColor.black);
  static const TextStyle appName = TextStyle(
      fontSize: Sizes.s34, fontWeight: FontWeight.w700, color: AppColor.black);
  static const TextStyle subTitle = TextStyle(
      fontSize: Sizes.s14, fontWeight: FontWeight.w900, color: AppColor.grey);

  static const TextStyle subTitle2 =
      TextStyle(fontSize: Sizes.s14, fontWeight: FontWeight.w400);
  static const TextStyle body1 =
      TextStyle(fontSize: Sizes.s12, fontWeight: FontWeight.w900);
  static const TextStyle body2 =
      TextStyle(fontSize: Sizes.s12, fontWeight: FontWeight.w400);

  static const TextStyle greySubTitle = TextStyle(
      color: AppColor.grey, fontSize: Sizes.s16, fontWeight: FontWeight.w400);
  //static TextStyle body3 = const TextStyle(fontSize: 18);

  static const TextStyle buttonTextStyle = TextStyle(
      fontSize: Sizes.s16, fontWeight: FontWeight.bold, color: AppColor.white);
  static const TextStyle appBarTitle = TextStyle(
      fontSize: Sizes.s24, fontWeight: FontWeight.bold, color: AppColor.white);
  static const TextStyle redTextStyle = TextStyle(
    fontSize: Sizes.s16,
    fontWeight: FontWeight.bold,
    color: AppColor.orange,
  );
  static const TextStyle blackSubTitle =
      TextStyle(fontSize: Sizes.s16, fontWeight: FontWeight.w400);
  static const TextStyle appBarTextTitle =
      TextStyle(fontSize: Sizes.s20, fontWeight: FontWeight.w900);

  static const TextStyle headingTextTile =
      TextStyle(fontSize: Sizes.s18, fontWeight: FontWeight.w900);

  static const TextStyle headingTextTile2 =
      TextStyle(fontSize: Sizes.s20, fontWeight: FontWeight.w900);

  static const TextStyle alertSubtitle = TextStyle(
      color: Color(0xff616467),
      fontSize: Sizes.s14,
      fontWeight: FontWeight.w900);
}
