


import 'package:flutter/material.dart';
import 'package:project/helpers/constants.dart';
import 'package:project/models/lessons_item_model.dart';

class LessonsController extends ChangeNotifier
{

  final List<LessonsItemModel> data = [
    LessonsItemModel(
        url: '$baseUrlImage/img_dummy',
        name: 'مدارهای منطقی',
        date: '۱۴۰۰/۰۵/۲۲',
      bgColor: Colors.blue.shade300
    ),
    LessonsItemModel(
        url: '$baseUrlImage/img_dummy',
        name: 'سیگنال و سیستم',
        date: '۱۴۰۰/۰۵/۲۲',
      bgColor: Colors.deepPurple
    ),
    LessonsItemModel(
        url: '$baseUrlImage/img_dummy',
        name: 'ریاضی 2',
        date: '۱۴۰۰/۰۵/۲۲',
      bgColor: Colors.deepOrangeAccent
    ),



  ];
}
