import 'package:doctor_on_call/routs/arguments.dart';
import 'package:doctor_on_call/views/Dashbord/doctor_services/sub_category_doctor.dart';
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
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<GetAllServicesList> allServicesList = [];
  List<GetAllServicesList> allServicesListRes = [];
  bool _isSearching = false;

  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> _onSearchHandler(String qurey) async {
    if (qurey.isNotEmpty) {
      _isSearching = true;
      allServicesList = _isSearching ? searchDoctor(qurey) : allServicesList;
    } else {
      allServicesList.clear();
      allServicesList = allServicesListRes;
      _isSearching = false;
    }
    setState(() {});
  }

  List<GetAllServicesList> searchDoctor(String qurey) {
    return allServicesListRes
        .where((e) => e.ptName.toLowerCase().contains(qurey.toLowerCase()))
        .toList();
  }

  Future<void> fetchCategories() async {
    GetAllServicesModel? response = await ApiService().getServicesList();
    if (response != null) {
      allServicesList = response.message
          .map((e) => GetAllServicesList.fromJson(e.toJson()))
          .toList();
      allServicesListRes = response.message
          .map((e) => GetAllServicesList.fromJson(e.toJson()))
          .toList();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: CustomScroll(
          children: [
            const SizedBox(
              height: 20,
            ),
            PrimaryTextField(
              controller: _searchController,
              onChanged: _onSearchHandler,
              hintText: 'Search Doctor',
              color: AppColor.textFieldColor,
              suffix: _isSearching
                  ? InkWell(
                      onTap: () {
                        _searchController.clear();
                        _isSearching = false;
                        allServicesList.clear();
                        allServicesList = allServicesListRes;
                        setState(() {});
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.clear,
                          color: Colors.black,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(
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
                    if (allServicesList[index].ptSubCatAvailable == "1") {
                      Navigator.pushNamed(context, Routs.specialistDoctor,
                          arguments:
                              OtpArguments(ptId: allServicesList[index].ptId));
                    } else {
                      Navigator.pushNamed(context, Routs.doctorList,
                          arguments: OtpArguments(
                            ptId: allServicesList[index].ptId,
                            catId: "0",
                          ));
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
}
