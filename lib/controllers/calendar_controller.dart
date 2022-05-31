

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jalali_table_calendar/jalali_table_calendar.dart';
import 'package:project/models/item_calendar_model.dart';
import 'package:project/models/item_category_model.dart';

class CalendarController extends ChangeNotifier
{

  List<ItemCalendarModel> listModel = [
    for (int i = 0; i < 3; i++) ...[
      ItemCalendarModel(
          title: 'تمرین سری اول کامپایلر',
      date: '1400/2/8',)

    ]
  ];


}