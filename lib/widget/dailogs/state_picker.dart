import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/get_state_list_model.dart';
import '../../models/state_model.dart';
import '../../services/api_services.dart';
import '../../utils/app_color.dart';
import '../../utils/app_sizes.dart';
import '../../utils/theme_utils.dart';
import '../custom_sized_box.dart';
import '../primary_textfield.dart';

class StatePickerDailog extends StatefulWidget {
  const StatePickerDailog({super.key});

  static Future<StateModel> show(BuildContext context) async {
    return await showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const StatePickerDailog(),
    );
  }

  @override
  State<StatePickerDailog> createState() => _StatePickerDailogState();
}

class _StatePickerDailogState extends State<StatePickerDailog> {
  final TextEditingController _searchController = TextEditingController();

  bool _isSearching = false;
  List<StateModel> _stateResponse = [];
  List<StateModel> _state = [];

  @override
  void initState() {
    super.initState();
    fetchState();
  }

  Future<void> fetchState() async {
    GetStateListModel? response = await ApiService().getStateList();
    if (response != null) {
      print("state response:=${response.message}");
      _state =
          response.message.map((e) => StateModel.fromJson(e.toJson())).toList();
      _stateResponse =
          response.message.map((e) => StateModel.fromJson(e.toJson())).toList();
      setState(() {});
    }
  }

  Future<void> _onSearchHandler(String qurey) async {
    if (qurey.isNotEmpty) {
      _isSearching = true;
      _state = _isSearching ? serachCountry(qurey) : _state;
    } else {
      _state.clear();
      _state = _stateResponse;
      _isSearching = false;
    }
    setState(() {});
  }

  List<StateModel> serachCountry(String qurey) {
    return _stateResponse
        .where((e) => e.stateName!.toLowerCase().contains(qurey.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Dialog(
        insetPadding: EdgeInsets.all(Sizes.s20.h),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.s12.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.s14.w,
            vertical: Sizes.s20.h,
          ),
          child: Column(
            children: [
              PrimaryTextField(
                controller: _searchController,
                onChanged: _onSearchHandler,
                hintText: 'Search State',
                color: AppColor.textFieldColor,
                suffix: _isSearching
                    ? InkWell(
                        onTap: () {
                          _searchController.clear();
                          _isSearching = false;
                          _state.clear();
                          _state = _stateResponse;
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
              Expanded(
                child: ListView.builder(
                  itemCount: _state.length,
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.s16.w,
                    vertical: Sizes.s20.h,
                  ),
                  itemBuilder: (context, index) {
                    StateModel state = _state[index];
                    return _CountryListTile(
                      stateModel: state,
                      onTap: () {
                        Navigator.pop(context, state);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CountryListTile extends StatelessWidget {
  final StateModel stateModel;
  final VoidCallback onTap;
  const _CountryListTile({
    required this.stateModel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBoxH8(),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  horizontal: Sizes.s12.h, vertical: Sizes.s18.h),
              decoration: BoxDecoration(
                  color: AppColor.textFieldColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                stateModel.stateName ?? '',
                style: TextStyle(
                  fontSize: Sizes.s16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ));
  }
}
