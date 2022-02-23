import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.fromHex('FFFFFF');
  static Color red = HexColor.fromHex('E92E2E');
  static Color myProposed = HexColor.fromHex('FFF8EA');
  static Color yellow = HexColor.fromHex('FCE3B2');
  static Color sendBackground = HexColor.fromHex('FFF8EA');
  static Color confirm = HexColor.fromHex('f3a541');
  static Color textBackground = HexColor.fromHex('FFF8EA');
  static Color whiteWithOpecity1 = HexColor.fromHex('F6F6F6');
  static Color whiteWithOpecity2 = HexColor.fromHex('FAFAFA');
  static Color grey = HexColor.fromHex('C4C4C4');
  static Color black = HexColor.fromHex('000000');
  static Color blue = HexColor.fromHex('243f6f');
  static Color itemBorder = HexColor.fromHex('E4FCB2');
  static Color well = HexColor.fromHex('B2FCC7');
  static Color green = HexColor.fromHex('42A314');
  static Color acceptedColor = HexColor.fromHex('F0F5F4');
  static Color starColor = HexColor.fromHex('F76868');
  static Color filterItemColor = HexColor.fromHex('#FFFDFD');
  static Color lightBlue = HexColor.fromHex('#6096A1');
  static Color ratingColor = HexColor.fromHex('#FFBA34');
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = 'FF' + hexColorString;
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
