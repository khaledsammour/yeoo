import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yeeo/pressentation/resource/fontsManager.dart';
import 'package:yeeo/pressentation/resource/valuesManager.dart';

TextStyle _getTextStyle(
    double fontSize, String fontFamily, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontSize.sp,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      color: color,
      decoration: TextDecoration.none);
}

TextStyle getMPlus1cStyle(
    {double fontSize = FontSize.s14, required Color color}) {
  return _getTextStyle(fontSize, FontConstrants.fontFamilyRobot,
      FontWeightManager.mplus1c, color);
}

TextStyle getMPlusStyle(
    {double fontSize = FontSize.s14, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstrants.fontFamilyRobot, FontWeightManager.mplus, color);
}

TextStyle getMeduimStyle(
    {double fontSize = FontSize.s14, required Color color}) {
  return _getTextStyle(fontSize, FontConstrants.fontFamilyRobot,
      FontWeightManager.normal, color);
}

TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(fontSize, FontConstrants.fontFamilyRobot,
      FontWeightManager.semiBold, color);
}

TextStyle getBoldStyle({double fontSize = FontSize.s18, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstrants.fontFamilyRobot, FontWeightManager.bold, color);
}

TextStyle getRegularSalsaStyle(
    {double fontSize = FontSize.s14, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstrants.fontFamilySalsa, FontWeightManager.mplus, color);
}
