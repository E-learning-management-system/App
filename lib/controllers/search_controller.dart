

import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project/models/item_category_model.dart';
import 'package:project/helpers/sharedPreferences.dart';
import 'package:http/http.dart' as http;
import '../models/exercise_item_model.dart';
import '../models/lessons_item_model.dart';
import '../models/subject_item_model.dart';
import '../helpers/sharedPreferences.dart';
class SearchController extends ChangeNotifier{

  List<ItemCategoryModel> list1=[];
  List<ItemCategoryModel> myList=[];
 TextEditingController searchBox=TextEditingController();


 onChanged(String value){
   myList=list1.where((element) => element.title.contains(value)).toList();
   if(searchBox.value.text==''){
     myList=list1;
   }
   notifyListeners();
 }
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

}