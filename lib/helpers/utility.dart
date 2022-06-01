


import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jalali_table_calendar/jalali_table_calendar.dart';
import 'package:project/helpers/constants.dart';

class Utility {


 static String convertToPersian(String dateGr)
  {
    final x = PersianDate.pDate(
        gregorian: dateGr,
        defualtFormat: 'yyyy/dd/mm');
    return '${x.year}/${x.month}/${x.day}';
  }
  static Color randomColor (){
   return  Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }
  static String randomImage()
  {
    var min = 1;
    var max = 4;
    final random = min + Random().nextInt(max - min);
print(random);
    return '$baseUrlImage/img_$random.png';
  }

}