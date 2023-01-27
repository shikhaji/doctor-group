import 'package:doctor_on_call/views/Dashbord/doctor_services/specialist_doctor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../routs/app_routs.dart';
import '../../utils/app_asset.dart';
import '../../utils/app_color.dart';
import '../../utils/app_sizes.dart';
import '../../utils/app_text_style.dart';
import '../../utils/screen_utils.dart';
import '../../widget/custom_container_box.dart';
import '../../widget/drawer_widget.dart';
import '../../widget/primary_bottom_navigation_bar.dart';
import '../../widget/primary_textfield.dart';
import '../../widget/scrollview.dart';
import 'home_screen.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final TextEditingController _search = TextEditingController();
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
          const SizedBox(
            height: 20,
          ),
          PrimaryTextField(
            controller: _search,
            hintText: "Search Here",

            suffix: Icon(CupertinoIcons.search),

          ),
          SizedBox(
            height: 15,
          ),
          GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            cacheExtent: 30,
            physics: const ClampingScrollPhysics(),
            itemCount: _servicesData.length,
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
                    _servicesData[index].onPressed.toString(),
                  );
                },
                child: CustomContainerBox(
                  title: _servicesData[index].name.toString(),
                  icon: _servicesData[index].icon.toString(),
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
          title: const Text(
            "Services",
            style: AppTextStyle.appBarTitle,
          ),
          leading: IconButton(
              onPressed: () {
                openDrawer();
              },
              icon: const Icon(
                Icons.menu_sharp,
                color: AppColor.white,
              ))),
    );
  }
  final List<HomeData> _servicesData = [
    HomeData(
        name: 'Doctor',
        icon: AppAsset.doctorIcon,
        onPressed: Routs.specialistDoctor),
    HomeData(
        name: 'Pathology',
        icon: AppAsset.pathologyIcon,
        //onPressed: "
    ),
    HomeData(
        name: 'Ambulance',
        icon: AppAsset.ambulanceIcon,
        //onPressed: ""
    ),
    HomeData(
        name: 'Chemist',
        icon: AppAsset.chemistIcon,
       // onPressed: ""
    ),
  ];
}
