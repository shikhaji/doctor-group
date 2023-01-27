import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../routs/app_routs.dart';
import '../../../utils/app_asset.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_sizes.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/screen_utils.dart';
import '../../../widget/custom_container_box.dart';
import '../../../widget/drawer_widget.dart';
import '../../../widget/primary_textfield.dart';
import '../../../widget/scrollview.dart';
import '../home_screen.dart';

class SpecialistDoctor extends StatefulWidget {
  const SpecialistDoctor({Key? key}) : super(key: key);

  @override
  State<SpecialistDoctor> createState() => _SpecialistDoctorState();
}

class _SpecialistDoctorState extends State<SpecialistDoctor> {
  final TextEditingController _search = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


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
            itemCount: _specialistDoctor.length,
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
                    _specialistDoctor[index].onPressed.toString(),
                  );
                },
                child: CustomContainerBox(
                  title: _specialistDoctor[index].name.toString(),
                  icon: _specialistDoctor[index].icon.toString(),
                ),
              );
            },
          ),
        ],
      ),

      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Specialist Doctor",
            style: AppTextStyle.appBarTitle,
          ),
          leading: IconButton(
              onPressed: () {
               Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColor.white,
              ))),
    );
  }
  final List<HomeData> _specialistDoctor = [
    HomeData(
        name: 'Cardio Specialist',
        icon: AppAsset.doctorIcon,
        onPressed: Routs.doctorList
    ),
    HomeData(
        name: 'Dental Specialist',
        icon: AppAsset.doctorIcon,
        onPressed: Routs.doctorList
    ),
    HomeData(
        name: 'Brain Specialist',
        icon: AppAsset.doctorIcon,
        onPressed: Routs.doctorList
    ),
    HomeData(
        name: 'Eye Specialist',
        icon: AppAsset.doctorIcon,
        onPressed: Routs.doctorList
    ),
    HomeData(
        name: 'Child Specialist',
        icon: AppAsset.doctorIcon,
        onPressed: Routs.doctorList
    ),

  ];
}
