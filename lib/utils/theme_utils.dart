import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_text_style.dart';
import 'create_material_color.dart';

class ThemeUtils {
  static ThemeData get lightTheme {
    return ThemeData(
        primaryColor: AppColor.primaryColor,
        tabBarTheme: lightTabBarTheme,
        dialogBackgroundColor: AppColor.white,
        scaffoldBackgroundColor: AppColor.white,
        appBarTheme: lightAppBarTheme,
        brightness: Brightness.light,
        cardColor: AppColor.lightGrey,
        bottomNavigationBarTheme: lightBottomNavigationBarTheme,
        inputDecorationTheme: lightInputDecorationTheme,
        dividerColor: AppColor.darkGrey,
        //colorScheme: const ColorScheme.light(),
        primarySwatch: createMaterialColor(const Color(0xff33cc99)),
        fontFamily: "Nunito_Sans");
  }

  static BottomNavigationBarThemeData get lightBottomNavigationBarTheme {
    return BottomNavigationBarThemeData(
      elevation: 10,
      backgroundColor: AppColor.white,
      selectedItemColor: AppColor.primaryColor,
      unselectedItemColor: AppColor.grey,
      selectedLabelStyle:
          AppTextStyle.greySubTitle.copyWith(fontWeight: FontWeight.w700),
      unselectedLabelStyle:
          AppTextStyle.greySubTitle.copyWith(fontWeight: FontWeight.w700),
      type: BottomNavigationBarType.fixed,
    );
  }

  static InputDecorationTheme get lightInputDecorationTheme {
    return InputDecorationTheme(
        filled: true,
        fillColor: AppColor.lightGrey,
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ));
  }

  static TabBarTheme get lightTabBarTheme {
    return TabBarTheme(
      labelColor: AppColor.red,
      labelStyle: AppTextStyle.redTextStyle,
      unselectedLabelColor: AppColor.unSelectedTabBarColor,
      unselectedLabelStyle: AppTextStyle.greySubTitle,
      indicator: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(50)),
    );
  }

  static AppBarTheme get lightAppBarTheme {
    return const AppBarTheme(
      color: AppColor.white,
      //elevation: 2,
      shadowColor: AppColor.lightGrey,
      foregroundColor: AppColor.black,
      // titleTextStyle: AppTextStyle.lightAppBarTextTitle
    );
  }
}
