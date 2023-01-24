import 'package:flutter/cupertino.dart';

import '../utils/app_sizes.dart';

class PrimaryPadding extends StatelessWidget {
  final Widget child;
  final double? verticalPadding;
  const PrimaryPadding({Key? key, required this.child, this.verticalPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Sizes.s16.h, vertical: verticalPadding ?? 0),
      child: child,
    );
  }
}
