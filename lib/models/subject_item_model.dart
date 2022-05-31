


import 'package:flutter/material.dart';
import 'package:project/helpers/colors.dart';

class SubjectsItemModel {

  int id=0;
  String  title="";
  String  teacher="";
  String  courseName="";
  int  courseId=0;
  Color? bgColor;
  SubjectsItemModel({

    required this.id,
    required this.title,
    required this.courseName,
    required this.courseId,
    required this.teacher,

  }){
    int num= id %(listOfColors.length);
    bgColor=listOfColors[num];
  }

  SubjectsItemModel.fromJson(Map<String,dynamic> item){
    id=item["id"];
    title=item["title"];
    courseName=item["course_name"];
    teacher=item["teacher"];
    courseId=item["course_id"];
}
}