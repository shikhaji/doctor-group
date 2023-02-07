import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:doctor_on_call/models/latest_news_model.dart';
import 'package:doctor_on_call/services/api_services.dart';
import 'package:doctor_on_call/utils/app_asset.dart';
import 'package:doctor_on_call/utils/app_color.dart';
import 'package:doctor_on_call/utils/app_text_style.dart';
import 'package:doctor_on_call/widget/custom_sized_box.dart';
import 'package:doctor_on_call/widget/scrollview.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../models/slider_model.dart';
import '../../routs/app_routs.dart';
import '../../services/shared_referances.dart';
import '../../utils/app_sizes.dart';
import '../../utils/screen_utils.dart';
import '../../widget/custom_container_box.dart';
import '../../widget/dailogs/location_dailog.dart';
import '../../widget/drawer_widget.dart';
import '../../widget/primary_appbar.dart';
import '../../widget/primary_bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CarouselController buttonCarouselController = CarouselController();
  CarouselController newsController = CarouselController();
  ScrollController controller = ScrollController();
  int _selectedSliderIndex = 0;
  List<SliderImageList> sliderImageList = [];
  List<LatestNewsList> latestNewsList = [];
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  String? state, city, stateId;

  @override
  void initState() {
    super.initState();
    controller.animateTo(100,
        duration: Duration(milliseconds: 500), curve: Curves.linear);

    callApi();
  }

  void callApi() {
    FormData data() {
      return FormData.fromMap({
        "districtid": 0,
      });
    }

    ApiService().slider(context, data: data()).then((value) {
      setState(() {
        sliderImageList = value.message!;
      });
      print("slider images ;=${sliderImageList[0].sliderImage}");
    });

    ApiService().latestNews(context).then((value) {
      setState(() {
        latestNewsList = value.message!.notice!;
      });
      print("news ;=${latestNewsList[0].newsDesc}");
      print("news link ;=${latestNewsList[0].newsLink}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
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
        body: CustomScroll(
          children: [
            SizedBoxH18(),
            // Container(
            //   padding: EdgeInsets.all(10),
            //   decoration: BoxDecoration(
            //     color: AppColor.textFieldColor,
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   child: Center(
            //       child: SingleChildScrollView(
            //     controller: controller,
            //     scrollDirection: Axis.horizontal,
            //     child: Row(
            //       children: [
            //         Text(
            //           "latestNewsList[itemIndex].newsDesclatestNewsList[itemIndex].newsDesc",
            //           style: AppTextStyle.blackSubTitle,
            //         ),
            //         SizedBoxW10(),
            //         Text(
            //           "latestNewsList[itemIndex].newsDesclatestNewsList[itemIndex].newsDesc",
            //           style: AppTextStyle.blackSubTitle
            //               .copyWith(color: AppColor.red),
            //         ),
            //       ],
            //     ),
            //   )),
            // ),
            // SizedBox(
            //   width: double.infinity,
            //   child: CarouselSlider.builder(
            //       carouselController: newsController,
            //       itemCount:
            //           latestNewsList.length != null ? latestNewsList.length : 0,
            //       itemBuilder: (BuildContext context, int itemIndex,
            //               int pageViewIndex) =>
            //           Container(
            //             padding: EdgeInsets.all(10),
            //             decoration: BoxDecoration(
            //               color: AppColor.textFieldColor,
            //               borderRadius: BorderRadius.circular(12),
            //             ),
            //             child: Center(
            //                 child: SingleChildScrollView(
            //               scrollDirection: Axis.horizontal,
            //               child: Row(
            //                 children: [
            //                   Text(
            //                     "${latestNewsList[itemIndex].newsDesc}",
            //                     style: AppTextStyle.blackSubTitle,
            //                   ),
            //                   SizedBoxW10(),
            //                   Text(
            //                     "${latestNewsList[itemIndex].newsLink}",
            //                     style: AppTextStyle.blackSubTitle
            //                         .copyWith(color: AppColor.red),
            //                   ),
            //                 ],
            //               ),
            //             )),
            //           ),
            //       options: CarouselOptions(
            //         // onPageChanged: (index, _) {
            //         //   setState(() {
            //         //     latestNewsList.length = index;
            //         //   });
            //         // },
            //         aspectRatio: 70 / 8,
            //         viewportFraction: 1,
            //         initialPage: 0,
            //         autoPlay: true,
            //         reverse: true,
            //         enableInfiniteScroll: false,
            //         autoPlayInterval: const Duration(seconds: 3),
            //         autoPlayAnimationDuration:
            //             const Duration(milliseconds: 800),
            //         autoPlayCurve: Curves.fastOutSlowIn,
            //         enlargeCenterPage: true,
            //
            //         scrollDirection: Axis.horizontal,
            //       )),
            // ),
            SizedBoxH18(),
            SizedBox(
              width: double.infinity,
              child: CarouselSlider.builder(
                  carouselController: buttonCarouselController,
                  itemCount: sliderImageList.length != null
                      ? sliderImageList.length
                      : 0,
                  itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                      Padding(
                          padding: EdgeInsets.only(right: 3, left: 3),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.grey
                                //         .withOpacity(0.5), //color of shadow
                                //     spreadRadius: 3, //spread radius
                                //     blurRadius: 5, // blur radius
                                //     offset: Offset(0, 3),
                                //   )
                                // ],
                                image: DecorationImage(
                                    image: NetworkImage(
                                      'https://appointment.doctoroncalls.in/uploads/' +
                                          sliderImageList[itemIndex]
                                              .sliderImage,
                                    ),
                                    fit: BoxFit.cover)),
                          )),
                  options: CarouselOptions(
                    onPageChanged: (index, _) {
                      setState(() {
                        _selectedSliderIndex = index;
                      });
                    },
                    aspectRatio: 12 / 8,
                    viewportFraction: 1,
                    initialPage: 0,
                    autoPlay: true,
                    enableInfiniteScroll: false,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  )),
            ),
            SizedBoxH18(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  sliderImageList.length,
                  (index) => Indicator(
                      isActive: _selectedSliderIndex == index ? true : false),
                )
              ],
            ),
            SizedBoxH18(),
            GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              cacheExtent: 30,
              physics: const ClampingScrollPhysics(),
              itemCount: _homeData.length,
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
                      _homeData[index].onPressed.toString(),
                    );
                  },
                  child: CustomContainerBox(
                    title: _homeData[index].name.toString(),
                    icon: _homeData[index].icon.toString(),
                  ),
                );
              },
            ),
          ],
        ),
        appBar: SecondaryAppBar(
            title: "Home",
            isLeading: true,
            leadingIcon: Icons.menu,
            onBackPressed: () {
              openDrawer();
            },
            action: Row(
              children: [
                IconButton(
                    onPressed: () {
                      LocationDailog.show(context).then((value) {
                        setState(() {
                          state = value.state;
                          city = value.city;
                        });
                      });
                    },
                    icon: const Icon(
                      Icons.location_on_rounded,
                      color: AppColor.orange,
                    )),
                state != null && city != null
                    ? Text("${state} ${city}")
                    : SizedBox.shrink()
              ],
            )));
  }

  final List<HomeData> _homeData = [
    HomeData(
        name: 'Meeting Schedule',
        icon: AppAsset.meetingSchedule,
        onPressed: Routs.meetingSchedule),
    HomeData(
      name: 'Wallets', icon: AppAsset.wallets,
        onPressed: Routs.walletMainScreen
    ),
    HomeData(
      name: 'Clients',
      icon: AppAsset.myAppointmentIcon,
    ),
  ];
}

class Indicator extends StatelessWidget {
  final bool isActive;
  const Indicator({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      height: 10.0,
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      width: isActive ? 10.0 : 10.0,
      decoration: BoxDecoration(
          color: isActive ? Colors.black : Colors.black,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.black, width: 2.0)),
    );
  }
}

class HomeData {
  String? name;
  String? icon;
  String? onPressed;

  HomeData({this.name, this.icon, this.onPressed});
}
