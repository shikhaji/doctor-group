import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/get_sub_categories_model.dart';
import '../../../models/sub_categories_model.dart';
import '../../../routs/app_routs.dart';
import '../../../routs/arguments.dart';
import '../../../services/api_services.dart';
import '../../../utils/app_asset.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_sizes.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/screen_utils.dart';
import '../../../widget/custom_container_box.dart';
import '../../../widget/drawer_widget.dart';
import '../../../widget/primary_appbar.dart';
import '../../../widget/primary_textfield.dart';
import '../../../widget/scrollview.dart';
import '../home_screen.dart';

class SpecialistDoctor extends StatefulWidget {
  final OtpArguments? arguments;
  const SpecialistDoctor({Key? key, this.arguments}) : super(key: key);

  @override
  State<SpecialistDoctor> createState() => _SpecialistDoctorState();
}

class _SpecialistDoctorState extends State<SpecialistDoctor> {
  final TextEditingController _search = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<GetSubCategoryList> _getSubCategoryList = [];

  @override
  void initState() {
    super.initState();
    print("sub category id here${widget.arguments?.ptId}");
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    ApiService()
        .getSubCategoriesList("${widget.arguments?.ptId}")
        .then((value) {
      if (value != null) {
        setState(() {
          _getSubCategoryList = value.message;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: const SecondaryAppBar(
        title: "Specialist Doctor",
        isLeading: true,
      ),
      body: CustomScroll(
        children: [
          // todo slider
          const SizedBox(
            height: 20,
          ),
          PrimaryTextField(
            controller: _search,
            hintText: "Search Here",
            suffix: const Icon(CupertinoIcons.search),
          ),
          const SizedBox(
            height: 15,
          ),
          GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            cacheExtent: 30,
            physics: const ClampingScrollPhysics(),
            itemCount: _getSubCategoryList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 12 / 9,
              crossAxisSpacing: Sizes.s20.h,
              mainAxisSpacing: Sizes.s20.h,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Navigator.pushNamed(
                  //   context,
                  //   _getSubCategoryList[index].onPressed.toString(),
                  // );
                },
                child: CustomContainerBox(
                  title: _getSubCategoryList[index].categoryName.toString(),
                  icon:
                      "https://appointment.doctoroncalls.in/uploads/${_getSubCategoryList[index].catImage.toString()}",
                  iconBool: true,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // final List<HomeData> _specialistDoctor = [
  //   HomeData(
  //       name: 'Cardio Specialist',
  //       icon: AppAsset.doctorIcon,
  //       onPressed: Routs.doctorList),
  //   HomeData(
  //       name: 'Dental Specialist',
  //       icon: AppAsset.doctorIcon,
  //       onPressed: Routs.doctorList),
  //   HomeData(
  //       name: 'Brain Specialist',
  //       icon: AppAsset.doctorIcon,
  //       onPressed: Routs.doctorList),
  //   HomeData(
  //       name: 'Eye Specialist',
  //       icon: AppAsset.doctorIcon,
  //       onPressed: Routs.doctorList),
  //   HomeData(
  //       name: 'Child Specialist',
  //       icon: AppAsset.doctorIcon,
  //       onPressed: Routs.doctorList),
  // ];
}
