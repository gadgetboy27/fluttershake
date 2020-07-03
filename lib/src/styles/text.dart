import 'package:flutter/material.dart';
import 'package:fluttershake/src/styles/colors.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class TextStyles{

  static TextStyle get body{
    return GoogleFonts.roboto(
      textStyle: TextStyle(color: AppColors.darkgray,
      fontSize: 16.0)
      );
  }

  static TextStyle get suggestion{
    return GoogleFonts.roboto(
      textStyle: TextStyle(color: AppColors.lightgray,
      fontSize: 16.0)
      );
  }

  static TextStyle get buttonTextLight{
    return GoogleFonts.roboto(
      textStyle: TextStyle(color: Colors.white,
      fontSize: 17.0, fontWeight: FontWeight.bold)
      );
  }

  static TextStyle get buttonTextDark{
    return GoogleFonts.roboto(
      textStyle: TextStyle(color: AppColors.darkgray,
      fontSize: 17.0, fontWeight: FontWeight.bold)
      );
  }
}