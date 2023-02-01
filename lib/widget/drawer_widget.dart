import 'package:doctor_on_call/utils/app_asset.dart';
import 'package:doctor_on_call/utils/app_color.dart';
import 'package:doctor_on_call/utils/app_text_style.dart';
import 'package:doctor_on_call/widget/primary_botton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/app_sizes.dart';
import '../utils/screen_utils.dart';
import '../views/Auth/login_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Column(
        children: [
          _buildDrawerHeader(),
          Expanded(
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ScreenUtil().setVerticalSpacing(20),
                    _DrawerMenuListTile.asset(
                      title: 'Profile',
                      onTap: () {},
                      child: Icon(FontAwesomeIcons.user),
                    ),
                    _DrawerMenuListTile.asset(
                      title: 'Order List',
                      onTap: () {},
                      child: Icon(Icons.format_list_bulleted_sharp),
                    ),
                    // _DrawerMenuListTile.asset(
                    //   title: 'Share',
                    //   onTap: () {},
                    //   child: Icon(Icons.share),
                    // ),
                    // _DrawerMenuListTile.asset(
                    //   title: 'Rate Us',
                    //   onTap: () {},
                    //   child: Icon(Icons.rate_review),
                    // ),
                    // _DrawerMenuListTile.asset(
                    //   title: 'Feedback',
                    //   onTap: () {},
                    //   child: Icon(Icons.favorite_outline),
                    // ),
                    _DrawerMenuListTile.asset(
                      title: 'Terms & Conditions',
                      onTap: () {},
                      child: Icon(Icons.local_police_outlined),
                    ),
                    _DrawerMenuListTile.asset(
                      title: 'Privacy Policy',
                      onTap: () {},
                      child: Icon(Icons.policy),
                    ),
                    _DrawerMenuListTile.asset(
                      title: 'About Us',
                      onTap: () {},
                      child: const Icon(Icons.account_box),
                    ),
                    ScreenUtil().setVerticalSpacing(30),
                    SizedBox(
                      height: Sizes.s40.h,
                      width: ScreenUtil().screenWidth - 200,
                      child: PrimaryButton(
                        lable: 'Logout',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) =>
                                AlertDialog(
                                  title: const Text("Logout",style: AppTextStyle.alertSubtitle,),
                                  content: const Text("Are You Sure ?",style: AppTextStyle.subTitle,),
                                  actions: <Widget>[

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                          child: Container(
                                            color: Colors.white,
                                            padding: const EdgeInsets.all(14),
                                            child: const Text("Cancel"),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: ()async {
                                            SharedPreferences sharedPreferences =
                                            await SharedPreferences.getInstance();
                                            sharedPreferences.clear();
                                            Navigator.of(context).pushAndRemoveUntil(
                                                MaterialPageRoute(builder: (context) =>
                                                const LoginScreen()), (
                                                Route<dynamic> route) => false);
                                          },
                                          child: Container(
                                            color: Colors.white,
                                            padding: const EdgeInsets.all(14),
                                            child: const Text("okay"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                          );
                        },
                      ),
                    ),
                    ScreenUtil().setVerticalSpacing(5),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return SizedBox(
      height: Sizes.s240.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            AppAsset.drawerBackground,
            fit: BoxFit.fill,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.s20.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: Sizes.s80.h,
                      width: Sizes.s80.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://www.desktopbackground.org/download/1024x768/2014/01/01/694300_daniels-statistics-analysis-name-meaning-list-of-firstnames_1920x1200_h.jpg"),
                          ))),
                  ScreenUtil().setVerticalSpacing(10),
                  Text(
                    "Hina patel",
                    style: AppTextStyle.appBarTextTitle
                        .copyWith(color: AppColor.white),
                  ),
                  Text(
                    "hinaPatel2201@gmail.com",
                    style: AppTextStyle.lable.copyWith(color: AppColor.white),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerMenuListTile extends StatelessWidget {
  final Widget child;
  final String title;
  final VoidCallback onTap;

  _DrawerMenuListTile.asset({
    required this.onTap,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: child,
      title: Text(
        title,
        style: AppTextStyle.lable,
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.black,
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }
}
