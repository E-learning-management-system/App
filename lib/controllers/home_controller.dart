import 'package:flutter/material.dart';
import 'package:project/models/item_category_model.dart';

import 'package:project/helpers/sharedPreferences.dart';

class HomeController extends ChangeNotifier {
  var status = StatusCategory.Init;
  final formSearchKey = GlobalKey<FormState>();
  List<ItemCategoryModel> listModel = [];

  void setAllCategory() {
    List<String>? lesson= sharedPreferences.getLessons();
    List<String>? exercise= sharedPreferences.getExercises();
    List<String>? subject= sharedPreferences.getSubjects();
    if(lesson != null){
      for (var i in lesson){
        listModel.add(ItemCategoryModel(title: i, category: 'Lesson'));
      }
    }
   if(exercise != null){
     for (var i in exercise){
       listModel.add(ItemCategoryModel(title: i, category: 'Exercise'));
     }
   }
    if(subject!= null){
      for (var i in subject){
        listModel.add(ItemCategoryModel(title: i, category: 'Subject'));
      }
    }

    if(listModel.isNotEmpty){
      listModel.shuffle();
    }
    status = StatusCategory.All;
    notifyListeners();
  }

  void setLessons() {
   List<String> myList= sharedPreferences.getLessons();
    listModel = [
      for (String i in myList) ...[
        ItemCategoryModel(
            title: i,
            category: 'Lesson'),
      ]
    ];
    status = StatusCategory.Lessons;

    notifyListeners();
  }

  void setHomeWork() {
    List<String> myList= sharedPreferences.getExercises();
    listModel = [
      for (String i in myList) ...[
        ItemCategoryModel(
            title: i,
            category: 'Exercise'),
      ]
    ];
    status = StatusCategory.HomeWork;
    notifyListeners();
  }

  void setLastTopics() {
    List<String> myList= sharedPreferences.getSubjects();
    listModel = [
      for (String i in myList) ...[
        ItemCategoryModel(
            title: i,
            category: 'Subject'),
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

enum StatusCategory { Init,All, Lessons, HomeWork, LastTopics }
