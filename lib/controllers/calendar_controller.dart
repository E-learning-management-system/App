

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jalali_table_calendar/jalali_table_calendar.dart';
import 'package:project/helpers/sharedPreferences.dart';
import 'package:project/models/exercise_item_model.dart';
import 'package:project/models/item_calendar_model.dart';
import 'package:project/models/item_category_model.dart';

class CalendarController extends ChangeNotifier
{

  List<ExerciseItemModel> listModel = [];

  getCalendar()async{
    listModel=await sharedPreferences.getE();
  }


}