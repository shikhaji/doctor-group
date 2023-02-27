import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:doctor_on_call/models/latest_news_model.dart';
import 'package:doctor_on_call/services/api_services.dart';
import 'package:doctor_on_call/utils/app_asset.dart';
import 'package:doctor_on_call/utils/app_color.dart';
import 'package:doctor_on_call/utils/app_text.dart';
import 'package:doctor_on_call/widget/custom_sized_box.dart';
import 'package:doctor_on_call/widget/scrollview.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import '../../models/slider_model.dart';
import '../../routs/app_routs.dart';
import '../../services/shared_referances.dart';
import '../../utils/app_sizes.dart';
import '../../utils/screen_utils.dart';
import '../../widget/custom_container_box.dart';
import '../../widget/dailogs/location_dailog.dart';
import '../../widget/drawer_widget.dart';
import '../../widget/primary_appbar.dart';

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
  String userTypeValue = "";

  @override
  void initState() {
    super.initState();

    callApi();
  }

  Future<void> callApi() async {
    String userType = await Preferances.prefGetString("userType", '');

    print("userType:=${userType}");

    setState(() {
      userTypeValue =
          userType.replaceAll('"', '').replaceAll('"', '').toString();
    });

    print("userTypeValue:=${userTypeValue}");
    state = await Preferances.getString("stateName");
    city = await Preferances.getString("cityName");
    stateId = await Preferances.getString("stateId");
    if (stateId == null) {
      stateId = "0";
    }
    FormData data() {
      return FormData.fromMap({
        "districtid": stateId?.replaceAll('"', '').toString(),
      });
    }

    ApiService().slider(context, data: data()).then((value) {
      setState(() {
        sliderImageList = value.message!;
      });
    });

    ApiService().latestNews(context).then((value) {
      setState(() {
        latestNewsList = value.message!.notice!;
      });
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
            Container(
                height: 50,
                padding: const EdgeInsets.only(top: 1, bottom: 1),
                decoration: BoxDecoration(
                  color: AppColor.textFieldColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: latestNewsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 30,
                        child: Marquee(
                          scrollAxis: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          blankSpace: 20.0,
                          startPadding: 10.0,
                          accelerationDuration: const Duration(seconds: 1),
                          accelerationCurve: Curves.linear,
                          textDirection: TextDirection.ltr,
                          text:
                              '${latestNewsList[index].newsDesc}  ${latestNewsList[index].newsLink}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    })),
            SizedBoxH18(),
            SizedBox(
              width: double.infinity,
              child: CarouselSlider.builder(
                  carouselController: buttonCarouselController,
                  itemCount: sliderImageList.length ?? 0,
                  itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                      Padding(
                          padding: const EdgeInsets.only(right: 3, left: 3),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      'https://appointment.doctoroncalls.in/uploads/${sliderImageList[itemIndex].sliderImage}',
                                    ),
                                    fit: BoxFit.cover)),
                          )),
                  options: CarouselOptions(
                    onPageChanged: (index, _) {
                      setState(() {
                        _selectedSliderIndex = index;
                      });
                    },
                    aspectRatio: 15 / 8,
                    viewportFraction: 1,
                    initialPage: 0,
                    autoPlay: true,
                    enableInfiniteScroll: false,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
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
              itemCount: userTypeValue == "1"
                  ? _homeDataDoctor.length
                  : userTypeValue == "2"
                      ? _homeDataPatient.length
                      : _homeData.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 12 / 9,
                crossAxisSpacing: Sizes.s20.h,
                mainAxisSpacing: Sizes.s20.h,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    userTypeValue == "1"
                        ? Navigator.pushNamed(
                            context,
                            _homeDataDoctor[index].onPressed.toString(),
                          )
                        : userTypeValue == "2"
                            ? Navigator.pushNamed(
                                context,
                                _homeDataPatient[index].onPressed.toString(),
                              )
                            : Navigator.pushNamed(
                                context,
                                _homeData[index].onPressed.toString(),
                              );
                  },
                  child: CustomContainerBox(
                      title: userTypeValue == "1"
                          ? _homeDataDoctor[index].name.toString()
                          : userTypeValue == "2"
                              ? _homeDataPatient[index].name.toString()
                              : _homeData[index].name.toString(),
                      icon: userTypeValue == "1"
                          ? _homeDataDoctor[index].icon.toString()
                          : userTypeValue == "2"
                              ? _homeDataPatient[index].icon.toString()
                              : _homeData[index].icon.toString()),
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
                        setState(() async {
                          state = value.state;
                          city = value.city;
                          stateId = value.stateId;
                          FormData data() {
                            return FormData.fromMap({
                              "districtid":
                                  stateId?.replaceAll('"', '').toString(),
                            });
                          }

                          ApiService()
                              .slider(context, data: data())
                              .then((value) {
                            setState(() {
                              sliderImageList = value.message!;
                            });
                          });
                          await callApi();
                        });
                      });
                    },
                    icon: const Icon(
                      Icons.location_on_rounded,
                      color: AppColor.orange,
                    )),
                state != null && city != null
                    ? appText("${city!.replaceAll('"', '').toString()}")
                    : SizedBox.shrink()
              ],
            )));
  }

  final List<HomeData> _homeDataDoctor = [
    HomeData(
        name: 'Meeting Schedule',
        icon: AppAsset.meetingSchedule,
        onPressed: Routs.meetingSchedule),
    HomeData(name: 'Wallets', icon: AppAsset.wallets, onPressed: Routs.wallet),
    HomeData(
        name: 'Patient Appointment',
        icon: AppAsset.myAppointmentIcon,
        onPressed: Routs.myAppointment),
    HomeData(
        name: 'My Appointment',
        icon: AppAsset.myAppointmentIcon,
        onPressed: Routs.myAppointment),
  ];
  final List<HomeData> _homeData = [
    HomeData(name: 'Wallets', icon: AppAsset.wallets, onPressed: Routs.wallet),
    HomeData(
        name: 'Patient Appointment',
        icon: AppAsset.myAppointmentIcon,
        onPressed: Routs.myAppointment),
    HomeData(
        name: 'My Appointment',
        icon: AppAsset.myAppointmentIcon,
        onPressed: Routs.myAppointment),
  ];
  final List<HomeData> _homeDataPatient = [
    HomeData(name: 'Wallets', icon: AppAsset.wallets, onPressed: Routs.wallet),
    HomeData(
        name: 'My Appointment',
        icon: AppAsset.myAppointmentIcon,
        onPressed: Routs.myAppointment),
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
