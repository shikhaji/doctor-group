import 'package:flutter/cupertino.dart';

Widget appText(
  String data, {
  TextStyle? style,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
  bool softWrap = false,
  TextAlign? textAlign,
  bool isUnderLine = false,
  int? maxLines,
  bool isTextOverflow = false,
  bool isLineThrough = false,
  TextDecoration? decoration,
}) {
  return Text(data,
      overflow: isTextOverflow ? TextOverflow.ellipsis : null,
      maxLines: maxLines,
      style: style,
      textAlign: textAlign,
      softWrap: softWrap);
}

// TextStyle defaultTextStyle(
//     {Color? color,
//     double? height,
//     double? fontSize,
//     FontWeight? fontWeight,
//     TextDecoration? decoration}) {
//   return GoogleFonts.rubik(
//     fontSize: fontSize ?? 11.sp,
//     fontWeight: fontWeight ?? FontWeight.w400,
//     color: color ?? black800,
//     decoration: decoration,
//     height: height,
//   );
// }
