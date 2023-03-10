import 'package:doctor_on_call/routs/arguments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/get_all_service_model.dart';
import '../../routs/app_routs.dart';
import '../../services/api_services.dart';
import '../../utils/app_color.dart';
import '../../utils/app_sizes.dart';
import '../../utils/screen_utils.dart';
import '../../widget/custom_container_box.dart';
import '../../widget/drawer_widget.dart';
import '../../widget/primary_appbar.dart';
import '../../widget/primary_textfield.dart';
import '../../widget/scrollview.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<GetAllServicesList> allServicesList = [];
  List<GetAllServicesList> allServicesListRes = [];
  bool _isSearching = false;

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
      appBar: const SecondaryAppBar(
        title: "Services",
        isLeading: false,
      ),
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
                  if (allServicesList[index].ptScreen == "1") {
                    Navigator.pushNamed(context, Routs.specialistDoctor,
                        arguments:
                            SendArguments(ptId: allServicesList[index].ptId));
                  } else {
                    Navigator.pushNamed(context, Routs.doctorList,
                        arguments: SendArguments(
                          ptId: allServicesList[index].ptId,
                          catId: "0",
                          servicesTypeName: allServicesList[index].ptName,
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
    );
  }
}
