
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project/controllers/home_controller.dart';
import 'package:project/models/item_category_model.dart';

class ItemLessonsController extends ChangeNotifier{

  var status = StatusCategory.LastTopics;
  List<ItemCategoryModel> listModel = [
    for (int i = 0; i < 3; i++) ...[
      ItemCategoryModel(
          title: 'مبحث اول',
          date: '1400/11/25',
          nameLesson: 'انتگرال یگانه',
          bgColor: Colors.primaries[Random().nextInt(Colors.primaries.length)]),
    ]
  ];




  void setHomeWork() {
    listModel = [
      for (int i = 0; i < 3; i++) ...[
        ItemCategoryModel(
            title: 'تکلیف اول',
            date: '1400/11/25',
            nameLesson: 'این یک موضوع است',
            bgColor: Colors.primaries[Random().nextInt(Colors.primaries.length)]),
      ]
    ];
    status = StatusCategory.HomeWork;
    notifyListeners();
  }
  void setLastTopics() {
    listModel = [
      for (int i = 0; i < 3; i++) ...[
        ItemCategoryModel(
            title: 'مبحث اول',
            date: '1400/11/25',
            nameLesson: 'انتگرال یگانه',
            bgColor: Colors.primaries[Random().nextInt(Colors.primaries.length)]),
      ]
    ];
    status = StatusCategory.LastTopics;
    notifyListeners();
  }
  void setBookMark()
  {
    listModel = [
      for (int i = 0; i < 3; i++) ...[
        ItemCategoryModel(
            title: 'زمان امتحان کی هست ؟ ',
            date: '1400/11/25',
            name: 'دانیال صابر',
            countComment: 15,
            nameLesson: 'این تنهای یک پیغام تست است یک پیام تستتستتستتستتستتستتست تست',
            bgColor: Colors.white),
      ]
    ];
    status = StatusCategory.BookMark;
    notifyListeners();
  }

  void setItemCategory(StatusCategory status) {

    if (status == StatusCategory.BookMark) {
      setBookMark();
      return;
    }
    if (status == StatusCategory.HomeWork) {
      setHomeWork();
      return;
    }
    if (status == StatusCategory.LastTopics) {
      setLastTopics();
      return;
    } else {
    }
  }


}