// import 'package:flutter/cupertino.dart';
//
// import '../../models/get_state_list_model.dart';
// import '../../models/state_model.dart';
// import '../../services/api_services.dart';
//
// class StatePickerDailog extends StatefulWidget {
//   const StatePickerDailog({super.key});
//
//   static Future<StateModel> show(BuildContext context) async {
//     return await showCupertinoDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (context) => const StatePickerDailog(),
//     );
//   }
//
//   @override
//   State<StatePickerDailog> createState() => _StatePickerDailogState();
// }
//
// class _StatePickerDailogState extends State<StatePickerDailog> {
//   final TextEditingController _searchController = TextEditingController();
//
//   bool _isSearching = false;
//
//   // List<StateModel> _state = [];
//   List<StateModel> _stateResponse = [];
//   GetStateListModel? _state;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchState();
//   }
//
//   Future<void> fetchState() async {
//     GetStateListModel? response = await ApiService().getStateList();
//     if (response != null) {
//       _state = response;
//       // _countryResponse =
//       //     response.data!.map((e) => Country.fromJson(e)).toList();
//       setState(() {});
//     }
//   }
//
//   Future<void> _onSearchHandler(String qurey) async {
//     if (qurey.isNotEmpty) {
//       _isSearching = true;
//       _state = _isSearching ? serachCountry(qurey) : _countrys;
//     } else {
//       _countrys.clear();
//       _countrys = _countryResponse;
//       _isSearching = false;
//     }
//     setState(() {});
//   }
//
//   List<Country> serachCountry(String qurey) {
//     return _countryResponse
//         .where((e) => e.name!.toLowerCase().contains(qurey.toLowerCase()))
//         .toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Dialog(
//         insetPadding: EdgeInsets.all(Sizes.s20.h),
//         elevation: 0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(Sizes.s12.r),
//         ),
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: Sizes.s14.w,
//             vertical: Sizes.s20.h,
//           ),
//           child: Column(
//             children: [
//               PrimaryTextField(
//                 controller: _searchController,
//                 onChanged: _onSearchHandler,
//                 hintText: 'Search Country',
//                 color: Theme.of(context).brightness ==
//                         ThemeUtils.darkTheme.brightness
//                     ? AppColor.darkThemeScaffoldBackground
//                     : AppColor.lightGrey,
//                 suffix: _isSearching
//                     ? InkWell(
//                         onTap: () {
//                           _searchController.clear();
//                           _isSearching = false;
//                           _countrys.clear();
//                           _countrys = _countryResponse;
//                           setState(() {});
//                         },
//                         child: const Padding(
//                           padding: EdgeInsets.only(right: 10),
//                           child: Icon(
//                             Icons.clear,
//                             color: Colors.black,
//                           ),
//                         ),
//                       )
//                     : null,
//               ),
//               Expanded(
//                 child: ListView.separated(
//                   itemCount: _countrys.length,
//                   padding: EdgeInsets.symmetric(
//                     horizontal: Sizes.s16.w,
//                     vertical: Sizes.s20.h,
//                   ),
//                   itemBuilder: (context, index) {
//                     Country country = _countrys[index];
//                     return _CountryListTile(
//                       country: country,
//                       onTap: () {
//                         Navigator.pop(context, country);
//                       },
//                     );
//                   },
//                   separatorBuilder: (context, index) {
//                     return Divider(height: Sizes.s10.h);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _CountryListTile extends StatelessWidget {
//   final Country country;
//   final VoidCallback onTap;
//   const _CountryListTile({
//     required this.country,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Row(
//         children: [
//           if (country.emoji != null) ...[
//             Text(
//               country.emoji!,
//               style: TextStyle(
//                 fontSize: Sizes.s24.sp,
//               ),
//             ),
//             SizedBoxW10(),
//           ],
//           Expanded(
//             child: Text(
//               country.name!,
//               style: TextStyle(
//                 fontSize: Sizes.s16.sp,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
