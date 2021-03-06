import 'package:flutter/material.dart';

class MyColors {
  static Color purpleHex = HexColor.fromHex('9100c5');
  static Color greyHex = HexColor.fromHex('b9b8bf');
  static Color darkBlue = HexColor.fromHex('#0464fc');
  static Color blueHex = HexColor.fromHex('#2a70e2');
  static Color blueAccentHex = HexColor.fromHex('51c3fe');
  static Color bgColor = HexColor.fromHex('f5fbff');
  static Color pinkAccentHex = HexColor.fromHex('fc75b1');
  static Color orange = HexColor.fromHex('ff876c');
  static Color blueDark = HexColor.fromHex('6c5cff');
  static Color appBarColor = HexColor.fromHex('#fff');
  static Color greyHello = HexColor.fromHex('#c1c1c1');
  static Color iconColor = HexColor.fromHex('#707070');
  static Color drawerColor = HexColor.fromHex('#636363');
  static Color drawerRed = HexColor.fromHex('#ff0000');
  static Color lightGreen = HexColor.fromHex('#28fa66');
  static Color hintColor = HexColor.fromHex('#838383');
  static Color inpBorderColor = HexColor.fromHex('#dbeff9');
  static Color darkButtonColor = HexColor.fromHex('#4c4ffa');
  static Color redButtonColor = HexColor.fromHex('#fe7062');
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

final listOfColors = [
  MyColors.redButtonColor,
  MyColors.darkButtonColor,
  MyColors.inpBorderColor,
  MyColors.hintColor,
  MyColors.darkBlue,
  MyColors.lightGreen,
  MyColors.orange,
  MyColors.blueDark,
  MyColors.greyHex,
  MyColors.purpleHex,
  MyColors.blueHex,
  MyColors.pinkAccentHex,
  MyColors.appBarColor,
  MyColors.blueAccentHex,
  MyColors.drawerColor,
  MyColors.iconColor,
  MyColors.drawerRed
];
