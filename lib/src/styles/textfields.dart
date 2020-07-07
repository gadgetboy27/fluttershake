import 'package:flutter/material.dart';
import 'package:fluttershake/src/styles/colors.dart';
import 'package:fluttershake/src/styles/text.dart';
import 'package:fluttershake/src/styles/base.dart';

abstract class TextFieldStyles {
  static double get textBoxHorizontal => BaseStyles.listFieldHorizontal;

  static double get textBoxVertical => BaseStyles.listFieldVertical;

  static TextStyle get text => TextStyles.body;

  static TextStyle get placeholder => TextStyles.suggestion;

  static Color get cursorColor => AppColors.red;

  static Widget iconPrefix(IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Icon(
        icon,
        size: 35.0,
        color: AppColors.darkgray,
      ),
    );
  }

  static TextAlign get textAlign => TextAlign.center;

  static BoxDecoration get cupertinoDecoration {
    return BoxDecoration(
        border: Border.all(
            color: AppColors.darkblue, width: BaseStyles.borderWidth),
        borderRadius: BorderRadius.circular(BaseStyles.borderRadius));
  }

  static InputDecoration materialDecoration(
    String hintText, IconData icon, String errorText) {
    return InputDecoration(
      contentPadding: EdgeInsets.all(8.0),
      hintText: hintText,
      hintStyle: TextFieldStyles.placeholder,
        border: InputBorder.none,
        errorText: errorText,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: AppColors.darkblue, width: BaseStyles.borderWidth),
        borderRadius: BorderRadius.circular(BaseStyles.borderRadius),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: AppColors.darkblue, width: BaseStyles.borderWidth),
        borderRadius: BorderRadius.circular(BaseStyles.borderRadius)),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: AppColors.darkblue, width: BaseStyles.borderWidth),
        borderRadius: BorderRadius.circular(BaseStyles.borderRadius)),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: AppColors.red, width: BaseStyles.borderWidth),
        borderRadius: BorderRadius.circular(BaseStyles.borderRadius)),
      prefixIcon: iconPrefix(icon),
    );
  }
}
