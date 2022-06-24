

import 'package:flutter/material.dart';
import 'package:project/models/item_category_model.dart';

import 'package:project/helpers/sharedPreferences.dart';

class HomeController extends ChangeNotifier {
  // List<Widget> listItems = [];
  var status = StatusCategory.Init;
  final formSearchKey = GlobalKey<FormState>();
  List<ItemCategoryModel> listModel = [];
  List<ItemCategoryModel> lessonProfessor=[];
  List<ItemCategoryModel> subjectProfessor=[];

 setAllCategory() async{

    List<String>? lesson=await  sharedPreferences.getLessons();
    List<String>? exercise=await sharedPreferences.getExercises();
    List<String>? subject=await sharedPreferences.getSubjects();
    listModel.clear();
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
    // notifyListeners();
  }

 setLessons()async {
   List<String>? myList=await sharedPreferences.getLessons();
   if(sharedPreferences.getType()=='t'){
     lessonProfessor = [
      for (String i in myList!) ...[
        ItemCategoryModel(
            title: i,
            category: 'Lesson'),
      ]
    ];}
   else{
     listModel.clear();
       for (String i in myList!) {
           listModel.add(ItemCategoryModel(title: i, category: 'Lesson'));
       }

   }
    status = StatusCategory.Lessons;

    notifyListeners();
  }

 setHomeWork()async {
    List<String> myList=await sharedPreferences.getExercises();
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

 setLastTopics()async {
    List<String> myList=await sharedPreferences.getSubjects();
    if(sharedPreferences.getType() == 't'){
      subjectProfessor=[
        for (String i in myList) ...[
          ItemCategoryModel(
              title: i,
              category: 'Subject'),
        ]
      ];
    }else{
    listModel = [
      for (String i in myList) ...[
        ItemCategoryModel(
            title: i,
            category: 'Subject'),
      ]
    ];}
    status = StatusCategory.LastTopics;
    notifyListeners();
  }

 setItemCategory(StatusCategory status) async{
    if (status == StatusCategory.All) {
      await setAllCategory();
      return;
    }
    if (status == StatusCategory.Lessons) {
      await setLessons();
      return;
    }
    if (status == StatusCategory.HomeWork) {
      await setHomeWork();
      return;
    }
    if (status == StatusCategory.LastTopics) {
      await setLastTopics();
      return;
    } else {
      listModel = [];
    }
  }
}

enum StatusCategory { Init,All, Lessons, HomeWork, LastTopics , BookMark ,
Sp}
