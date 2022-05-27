

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jalali_table_calendar/jalali_table_calendar.dart';
import 'package:project/models/item_category_model.dart';

class CalendarController extends ChangeNotifier
{

  List<ItemCategoryModel> listModel = [
    for (int i = 0; i < 3; i++) ...[
      ItemCategoryModel(
          title: 'تمرین سری اول کامپایلر',
      category: 'Exercise',)
      //     date: '1400/11/25',
      //     bgColor:  i==0? Colors.cyan.withOpacity(0.2) : i==1? Colors.blue.withOpacity(0.2) :
      // Colors.pinkAccent.withOpacity(0.2)),
    ]
  ];

 String convertToPersian(String dateGr)
 {
   final x = PersianDate.pDate(
       gregorian: dateGr,
       defualtFormat: 'yyyy/dd/mm');
   return '${x.year}/${x.month}/${x.day}';
 }
}