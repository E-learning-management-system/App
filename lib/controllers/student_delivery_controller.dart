

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jalali_table_calendar/jalali_table_calendar.dart';
import 'package:project/models/item_calendar_model.dart';
import 'package:project/models/item_category_model.dart';
import 'package:project/models/lessons_item_model.dart';

class StudentDeliveryController extends ChangeNotifier
{

  List<LessonsItemModel> listModel = [
    for (int i = 0; i < 3; i++) ...[
      LessonsItemModel(
          description: 'انتگرال یگانه',
          title: 'دانیال صابر',
          endDate: '1400/11/25',
          examDate: '',
          id: 4,
          startDate: '',
          teacher: ''
      ),

    ]
  ];


}