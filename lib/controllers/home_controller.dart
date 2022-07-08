

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project/models/item_category_model.dart';
import 'package:project/helpers/sharedPreferences.dart';
import 'package:http/http.dart' as http;
import '../models/exercise_item_model.dart';
import '../models/lessons_item_model.dart';
import '../models/subject_item_model.dart';

class HomeController extends ChangeNotifier {
  // List<Widget> listItems = [];
  var status = StatusCategory.Init;
  final formSearchKey = GlobalKey<FormState>();
  List<ItemCategoryModel> listModel = [];
  List<ItemCategoryModel> lessonProfessor=[];
  List<ItemCategoryModel> subjectProfessor=[];

  Future getLessonById(int id)async{
    var token=await sharedPreferences.getToken('token');
    var url= 'https://api.piazza.markop.ir/soren/course-rud/$id/';
    var response= await http.get(Uri.parse(url),
      headers: { "content-type": "application/json",
        "Authorization": "Token " + token,},
    );

    print("lesson=   "+ const Utf8Decoder().convert(response.bodyBytes));
    final Map<String, dynamic> data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
    if(response.statusCode==200){
      return LessonsItemModel.fromJson(Map<String,dynamic>.from(data));
    }
    return false;
  }
  Future getExerciseById(int id)async{
    var token=await sharedPreferences.getToken('token');
    var url= 'https://api.piazza.markop.ir/soren/exercise-rud/$id/';
    var response= await http.get(Uri.parse(url),
      headers: { "content-type": "application/json",
        "Authorization": "Token " + token,},
    );

    print("exercise=   "+ const Utf8Decoder().convert(response.bodyBytes));
    final Map<String, dynamic> data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
    if(response.statusCode==200){
      return ExerciseItemModel.fromJson(Map<String,dynamic>.from(data));
    }
    return false;
  }
  Future getTopicById(int id)async{
    var token=await sharedPreferences.getToken('token');
    var url= 'https://api.piazza.markop.ir/soren/subject-rd/$id/';
    var response= await http.get(Uri.parse(url),
      headers: { "content-type": "application/json",
        "Authorization": "Token " + token,},
    );

    print("topic=   "+ const Utf8Decoder().convert(response.bodyBytes));
    final Map<String, dynamic> data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
    if(response.statusCode==200){
      return SubjectsItemModel.fromJson(Map<String,dynamic>.from(data));
    }
    return false;
  }

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
   if(exercise != null&& sharedPreferences.getType()!='t'){

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
