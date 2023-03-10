import 'package:doctor_on_call/utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app_sizes.dart';
import '../utils/app_text.dart';
import '../utils/app_text_style.dart';

class PrimaryTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final bool readOnly;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final TextInputType keyboardInputType;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffix;
  final Widget? prefix;
  final String? counterText;
  final Color? textColor;
  final int? maxLength;

  final Color? color;
  final TextStyle? hintStyle;
  final String? instructionsText;
  final bool instructions;
  final EdgeInsets? contentPadding;
  final BoxConstraints? suffixIconConstraints;

  const PrimaryTextField({
    Key? key,
    this.controller,
    this.counterText,
    this.hintText,
    this.textInputAction,
    this.onChanged,
    this.maxLength,
    this.inputFormatters,
    this.readOnly = false,
    this.obscureText = false,
    this.validator,
    this.onTap,
    this.suffix,
    this.prefix,
    this.textColor,
    this.color,
    this.instructionsText,
    this.instructions = false,
    this.hintStyle,
    this.contentPadding,
    this.suffixIconConstraints,
    // const TextStyle(
    //     fontWeight: FontWeight.w700, color: AppColor.hintTextColor),
    this.keyboardInputType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          obscuringCharacter: "*",
          autocorrect: false,
          controller: controller,
          readOnly: readOnly,
          textInputAction: textInputAction ?? TextInputAction.next,
          inputFormatters: inputFormatters,
          keyboardType: keyboardInputType,
          onChanged: onChanged,
          onTap: onTap,
          obscureText: obscureText,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: AppTextStyle.textFieldFont,
          maxLength: maxLength,
          decoration: InputDecoration(
            isDense: true,
            hintStyle: AppTextStyle.alertSubtitle.copyWith(
                color: const Color(0x4d1d2125), fontWeight: FontWeight.w400),
            fillColor: color ?? AppColor.textFieldColor,
            filled: true,
            hintText: hintText,
            counterText: counterText,
            suffixIconConstraints: suffixIconConstraints ??
                BoxConstraints(
                  minHeight: Sizes.s30.h,
                  minWidth: Sizes.s30.w,
                ),
            suffixIcon: suffix,
            prefixIcon: prefix,
            contentPadding: contentPadding ?? EdgeInsets.all(Sizes.s16.h),
            border: _outlineInputBorder(Theme.of(context).cardColor),
            enabledBorder: _outlineInputBorder(Theme.of(context).cardColor),
            focusedBorder: _outlineInputBorder(Theme.of(context).cardColor),
            errorBorder: _outlineInputBorder(Colors.red),
            focusedErrorBorder: _outlineInputBorder(Colors.red),
          ),
          validator: validator,
        ),
        !instructions
            ? const SizedBox.shrink()
            : Column(children: [
                const SizedBox(height: Sizes.s2),
                appText(
                  instructionsText ?? "",
                  style: AppTextStyle.greySubTitle.copyWith(
                    fontSize: 12,
                  ),
                ),
              ]),
        SizedBox(height: Sizes.s10.h)
      ],
    );
  }

  OutlineInputBorder _outlineInputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(Sizes.s12.r),
      borderSide: BorderSide(width: 0.2, color: color),
    );
  }
}
