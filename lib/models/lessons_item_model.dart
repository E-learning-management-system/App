


import 'package:flutter/material.dart';
import 'package:project/helpers/colors.dart';

class LessonsItemModel {

  int id=0;
  String  title="";
  String  description="";
  String  teacher="";
  String  startDate="";
  String  endDate="";
  String  examDate="";
  Color? bgColor;
  int? countCm;
  String? name;
  LessonsItemModel({
    required this.id,
    required this.title,
    required this.description,
    required this.teacher,
    required this.startDate,
    required this.endDate,
    required this.examDate,
     this.countCm,
     this.name
  }){
    int num= id %(listOfColors.length);
    bgColor=listOfColors[num];
  }

  LessonsItemModel.fromJson(Map<String,dynamic> item){
       id=item["id"];
       title=item["title"];
       description=item["description"];
       teacher=item["teacher"].runtimeType==String?item["teacher"]:'';
       startDate=item["start_date"];
       endDate=item["end_date"];
       examDate=item["exam_date"];}
}