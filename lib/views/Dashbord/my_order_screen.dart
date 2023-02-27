import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/app_sizes.dart';
import '../../utils/screen_utils.dart';
import '../../widget/drawer_widget.dart';
import '../../widget/primary_appbar.dart';
import '../../widget/scrollview.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondaryAppBar(
        title: "My Order",
        isLeading: false,
      ),
      body: CustomScroll(
        children: [
          const SizedBox(
            height: 100,
          ),
          ListView.builder(
            padding: EdgeInsets.symmetric(vertical: Sizes.s20.h),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, inx) {
              return orderListContainer("hina");
            },
          )
        ],
      ),
    );
  }

  Widget orderListContainer(String title) {
    return Text(title);
  }
}
