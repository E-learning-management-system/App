import 'package:flutter/material.dart';

class MyColors {
  static Color purpleHex = HexColor.fromHex('9100c5');
  static Color greyHex = HexColor.fromHex('b9b8bf');

  static Color blueHex = HexColor.fromHex('#2a70e2');
  static Color blueAccentHex = HexColor.fromHex('51c3fe');
  static Color bgColor = HexColor.fromHex('f5fbff');
  static Color pinkAccentHex = HexColor.fromHex('fc75b1');
  static Color orange = HexColor.fromHex('ff876c');
  static Color blueDark = HexColor.fromHex('6c5cff');
  static Color appBarColor = HexColor.fromHex('#fff');
  static Color greyHello = HexColor.fromHex('#c1c1c1');
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
