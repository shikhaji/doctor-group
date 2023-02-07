import 'package:doctor_on_call/views/Dashbord/doctor_services/specialist_doctor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/categories_model.dart';
import '../../models/get_all_service_model.dart';
import '../../models/get_categories_list_model.dart';
import '../../routs/app_routs.dart';
import '../../services/api_services.dart';
import '../../utils/app_asset.dart';
import '../../utils/app_color.dart';
import '../../utils/app_sizes.dart';
import '../../utils/app_text_style.dart';
import '../../utils/screen_utils.dart';
import '../../widget/custom_container_box.dart';
import '../../widget/drawer_widget.dart';
import '../../widget/primary_appbar.dart';
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

  List<GetAllServicesList> allServicesList = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    ApiService().getServicesList().then((value) {
      if (value != null) {
        setState(() {
          allServicesList = value.message;
        });
      }
    });
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
              itemCount: allServicesList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 12 / 9,
                crossAxisSpacing: Sizes.s20.h,
                mainAxisSpacing: Sizes.s20.h,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    print(
                        "allServicesList[index].ptSubCatAvailable:=${allServicesList[index].ptSubCatAvailable}");
                    if (allServicesList[index].ptSubCatAvailable == "1") {
                      Navigator.pushNamed(
                        context,
                        Routs.specialistDoctor,
                      );
                    } else {
                      Navigator.pushNamed(context, Routs.doctorList);
                    }
                  },
                  child: CustomContainerBox(
                    title: allServicesList[index].ptName,
                    iconBool: true,
                    icon:
                        "https://appointment.doctoroncalls.in/uploads/${allServicesList[index].ptImage.toString()}",
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
        appBar: SecondaryAppBar(
          title: "Services",
          isLeading: true,
          leadingIcon: Icons.menu,
          onBackPressed: () {
            openDrawer();
          },
        ));
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
