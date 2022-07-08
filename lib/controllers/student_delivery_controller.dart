

import 'dart:math';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:project/helpers/sharedPreferences.dart';

import 'package:flutter/material.dart';
import 'package:jalali_table_calendar/jalali_table_calendar.dart';
import 'package:project/models/item_calendar_model.dart';
import 'package:project/models/item_category_model.dart';
import 'package:project/models/lessons_item_model.dart';

class StudentDeliveryController extends ChangeNotifier
{
  late Map <int , List<String>> answerStudent;
  late Map <int , List<String>> notAnswerStudent;

  Future getAnswerStudent(id)async{
    String url='https://api.piazza.markop.ir/soren/answerstudents/$id/';
    final _token=await sharedPreferences.getToken('token');

    List<LessonsItemModel> listModel = [
    for (int i = 0; i < 3; i++) ...[
    LessonsItemModel(
    description: 'انتگرال یگانه',
    title: 'دانیال صابر',
    endDate: '1400/11/25',
    examDate: '',
    id: 4,
    startDate: '',
    teacher: ''
    ),

    ]
    ];
    var response= await http.get(Uri.parse(url),
    headers: { "content-type": "application/json",
    "Authorization": "Token " + _token,},
    );

    print("jsonDecode(list of answer student)=   "+const Utf8Decoder().convert(response.bodyBytes));
    final Map<String, dynamic> data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
    if(data.containsKey("results")){
    answerStudent[id]=[];
    if (data["results"].length>0) {
    final List< dynamic> list = data["results"];
    for(var v in list) {
    answerStudent[id]?.add(v['email']);
    }
    }
    notifyListeners();
    return true;
    }
    notifyListeners();
    return false;
  }
  Future getNotAnswerStudent(id)async {
    String url='https://api.piazza.markop.ir/soren/notAnswerStudents/$id/';

    final _token=await sharedPreferences.getToken('token');

    var response= await http.get(Uri.parse(url),
      headers: { "content-type": "application/json",
        "Authorization": "Token " + _token,},
    );

    print("jsonDecode(list of not answer student)=   "+const Utf8Decoder().convert(response.bodyBytes));
    final Map<String, dynamic> data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
    if(data.containsKey("results")){
      notAnswerStudent[id]=[];
      if (data["results"].length>0) {
        final List< dynamic> list = data["results"];
        for(var v in list) {
          notAnswerStudent[id]?.add(v['email']);
        }
      }
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }


}
