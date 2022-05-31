


import 'package:flutter/material.dart';
import 'package:project/helpers/colors.dart';

class ExerciseItemModel {

  int id=0;
  String  title="";
  String  description="";
  String  teacher="";
  String  date="";
  String  deadline="";
  String  courseName="";
  int  courseId=0;
  String file='';
  Color? bgColor;
  ExerciseItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.teacher,
    required this.date,
    required this.deadline,
    required this.courseName,
    required this.courseId,
    required this.file,
  }){
    int num= id %(listOfColors.length);
    bgColor=listOfColors[num];
  }

  ExerciseItemModel.fromJson(Map<String,dynamic> item){
    id=item["id"];
    title=item["title"];
    description=item["description"];
    courseName=item["course_title"];
    teacher=item["teacher"];
    courseId=item["course_id"];
    date=item["date"];
    deadline=item["deadline"];
    file=item['file'];

  }
}