import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../models/get_sub_categories_model.dart';
import '../../../routs/app_routs.dart';
import '../../../routs/arguments.dart';
import '../../../services/api_services.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_sizes.dart';
import '../../../widget/custom_container_box.dart';
import '../../../widget/primary_appbar.dart';
import '../../../widget/primary_textfield.dart';
import '../../../widget/scrollview.dart';

class SubCategoryDoctor extends StatefulWidget {
  final SendArguments? arguments;
  const SubCategoryDoctor({Key? key, this.arguments}) : super(key: key);

  @override
  State<SubCategoryDoctor> createState() => _SubCategoryDoctorState();
}

class _SubCategoryDoctorState extends State<SubCategoryDoctor> {
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<GetSubCategoryList> _getSubCategoryList = [];
  List<GetSubCategoryList> _getSubCategoryListRes = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> _onSearchHandler(String qurey) async {
    if (qurey.isNotEmpty) {
      _isSearching = true;
      _getSubCategoryList =
          _isSearching ? searchDoctor(qurey) : _getSubCategoryList;
    } else {
      _getSubCategoryList.clear();
      _getSubCategoryList = _getSubCategoryListRes;
      _isSearching = false;
    }
    setState(() {});
  }

  List<GetSubCategoryList> searchDoctor(String qurey) {
    return _getSubCategoryListRes
        .where(
            (e) => e.categoryName.toLowerCase().contains(qurey.toLowerCase()))
        .toList();
  }

  Future<void> fetchCategories() async {
    GetSubCategoryModel? response =
        await ApiService().getSubCategoriesList("${widget.arguments?.ptId}");
    if (response != null) {
      _getSubCategoryList = response.message
          .map((e) => GetSubCategoryList.fromJson(e.toJson()))
          .toList();
      _getSubCategoryListRes = response.message
          .map((e) => GetSubCategoryList.fromJson(e.toJson()))
          .toList();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: const SecondaryAppBar(
          title: "Doctor",
          isLeading: true,
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
                        _getSubCategoryList.clear();
                        _getSubCategoryList = _getSubCategoryListRes;
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
                    Navigator.pushNamed(context, Routs.doctorList,
                        arguments: SendArguments(
                          ptId: widget.arguments?.ptId,
                          catId: _getSubCategoryList[index].categoryId,
                          servicesTypeName:
                              _getSubCategoryList[index].categoryName,
                        ));
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
        ));
  }
}
