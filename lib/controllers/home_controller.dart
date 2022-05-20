import 'package:flutter/material.dart';
import 'package:project/models/item_category_model.dart';

class HomeController extends ChangeNotifier {
  // List<Widget> listItems = [];
  var status = StatusCategory.Init;
  final formSearchKey = GlobalKey<FormState>();
  List<ItemCategoryModel> listModel = [];

  void setAllCategory() {
    listModel = [
      for (int i = 1; i < 3; i++) ...[
        ItemCategoryModel(
            title: 'درس ریاضی مهندسی',
            date: 'assets/images/image_2.PNG',
            bgColor: Colors.orange),
      ],
      for (int i = 1; i < 3; i++) ...[
        ItemCategoryModel(
            title: 'تکلیف کامپایلر',
            date: 'assets/images/image_3.PNG',
            bgColor: Colors.green),
      ],
    for (int i = 1; i < 3; i++) ...[
      ItemCategoryModel(
          title: 'مبحث سری فوریه',
          date: 'assets/images/image_4.PNG',
          bgColor: Colors.deepPurpleAccent),
    ]
    ];


    status = StatusCategory.All;
    notifyListeners();
  }

  void setLessons() {
    listModel = [
      for (int i = 1; i < 6; i++) ...[
        ItemCategoryModel(
            title: 'درس ریاضی مهندسی',
            date: 'assets/images/image_2.PNG',
            bgColor: Colors.orange),
      ]
    ];
    status = StatusCategory.Lessons;

    notifyListeners();
  }

  void setHomeWork() {
    listModel = [
      for (int i = 1; i < 6; i++) ...[
        ItemCategoryModel(
            title: 'تکلیف کامپایلر',
            date: 'assets/images/image_3.PNG',
            bgColor: Colors.green),
      ]
    ];
    status = StatusCategory.HomeWork;

    notifyListeners();
  }

  void setLastTopics() {
    listModel = [
      for (int i = 1; i < 6; i++) ...[
        ItemCategoryModel(
            title: 'مبحث سری فوریه',
            date: 'assets/images/image_4.PNG',
            bgColor: Colors.deepPurpleAccent),
      ]
    ];
    status = StatusCategory.LastTopics;
    notifyListeners();
  }

  void setItemCategory(StatusCategory status) {
    if (status == StatusCategory.All) {
      setAllCategory();
      return;
    }
    if (status == StatusCategory.Lessons) {
      setLessons();
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
      listModel = [];
    }
  }
}

enum StatusCategory { Init,All, Lessons, HomeWork, LastTopics , BookMark }
