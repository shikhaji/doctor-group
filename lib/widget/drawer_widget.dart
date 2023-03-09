import 'package:doctor_on_call/routs/arguments.dart';
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
import '../models/get_profile_model.dart';
import '../routs/app_routs.dart';
import '../services/api_services.dart';
import '../services/shared_referances.dart';
import '../utils/app_sizes.dart';
import '../utils/screen_utils.dart';
import '../views/Auth/login_screen.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  GetProfileData? getProfileData;
  @override
  void initState() {
    getProfile();
  }

  Future<void> getProfile() async {
    String? id = await Preferances.getString("userId");
    ApiService()
        .getProfileData(id!.replaceAll('"', '').replaceAll('"', '').toString())
        .then((value) {
      if (value != null) {
        setState(() {
          getProfileData = value.profile;
        });
      }
    });
  }

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
                      onTap: () {
                        Navigator.pushNamed(context, Routs.myProfile,
                            arguments: SendArguments(backIcon: true));
                      },
                      child: const Icon(FontAwesomeIcons.user),
                    ),
                    _DrawerMenuListTile.asset(
                      title: 'Order List',
                      onTap: () {
                        Navigator.pushNamed(context, Routs.myOrder,
                            arguments: SendArguments(backIcon: true));
                      },
                      child: const Icon(Icons.format_list_bulleted_sharp),
                    ),
                    _DrawerMenuListTile.asset(
                      title: 'Terms & Conditions',
                      onTap: () {
                        Navigator.pushNamed(context, Routs.termsAndCondition);
                      },
                      child: const Icon(Icons.local_police_outlined),
                    ),
                    _DrawerMenuListTile.asset(
                      title: 'Privacy Policy',
                      onTap: () {
                        Navigator.pushNamed(context, Routs.privacyPolicy);
                      },
                      child: const Icon(Icons.policy),
                    ),
                    _DrawerMenuListTile.asset(
                      title: 'About Us',
                      onTap: () {
                        Navigator.pushNamed(context, Routs.aboutUs);
                      },
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
                            builder: (ctx) => AlertDialog(
                              title: const Text(
                                "Logout",
                                style: AppTextStyle.alertSubtitle,
                              ),
                              content: const Text(
                                "Are You Sure ?",
                                style: AppTextStyle.subTitle,
                              ),
                              actions: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      onPressed: () async {
                                        SharedPreferences sharedPreferences =
                                            await SharedPreferences
                                                .getInstance();
                                        sharedPreferences.clear();
                                        Navigator.of(
                                                context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const LoginScreen()),
                                                (Route<dynamic> route) =>
                                                    false);
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
                          image: getProfileData?.patientPhoto != ""
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      "https://appointment.doctoroncalls.in/uploads/${getProfileData?.patientPhoto}" ??
                                          ""),
                                )
                              : DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(AppAsset.dummyAvatar),
                                ))),
                  ScreenUtil().setVerticalSpacing(10),
                  Text(
                    getProfileData?.branchName ?? "",
                    style: AppTextStyle.appBarTextTitle
                        .copyWith(color: AppColor.white),
                  ),
                  Text(
                    getProfileData?.branchEmail ?? "",
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
