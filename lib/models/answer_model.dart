


import 'package:flutter/material.dart';
import 'package:project/helpers/colors.dart';

class AnswerItemModel {

  int id=0;
  String  exercise_title="";
  String  description="";
  int  exercise_id=0;
  String  date="";
  String  name="";
  String  user_email='';
  String file='';
  AnswerItemModel({
    required this.id,
    required this.exercise_title,
    required this.description,
    required this.exercise_id,
    required this.date,
    required this.name,
    required this.user_email,
    required this.file,
  });

  AnswerItemModel.fromJson(Map<String,dynamic> item){
    print('id');
    id=item["id"];
    exercise_title=item["exercise_title"];
    description=item["description"];
    name=item["name"]??'';
    exercise_id=item["exercise_id"];
    user_email=item["user_email"];
    date=item["date"];
    file=item['file']?? '';
    print('end');
  }
}