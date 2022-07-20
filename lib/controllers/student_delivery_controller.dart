

import 'dart:math';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:project/helpers/sharedPreferences.dart';

import 'package:flutter/material.dart';
import 'package:jalali_table_calendar/jalali_table_calendar.dart';
import 'package:project/models/answer_model.dart';
import 'package:project/models/item_calendar_model.dart';
import 'package:project/models/item_category_model.dart';
import 'package:project/models/lessons_item_model.dart';

class StudentDeliveryController extends ChangeNotifier
{
  late Map <int , List<String>> answerStudent={};
  late Map <int , List<String>> notAnswerStudent={};
  late List<AnswerItemModel> answers=[];

  Future getAnswerStudent(id)async{
    answerStudent[id]=[];
    String url='https://api.piazza.markop.ir/soren/answerstudents/$id/';
    final _token=await sharedPreferences.getToken('token');
    var response= await http.get(Uri.parse(url),
    headers: { "content-type": "application/json",
    "Authorization": "Token " + _token,},
    );

    // print("jsonDecode(list of answer student)=   "+const Utf8Decoder().convert(response.bodyBytes));

    if(response.statusCode==200){
      final Map<String, dynamic> data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
    if (data["results"].length>0) {
    final List< dynamic> list = data["results"];
    for(var v in list) {
    answerStudent[id]?.add(v['email']);
    }

    }
    await getAnswers(id);
    notifyListeners();
    return true;
    }
    notifyListeners();
    return false;
  }
  Future getNotAnswerStudent(id)async {
    notAnswerStudent[id]=[];
    String url='https://api.piazza.markop.ir/soren/notAnswerStudents/$id/';

    final _token=await sharedPreferences.getToken('token');

    var response= await http.get(Uri.parse(url),
      headers: { "content-type": "application/json",
        "Authorization": "Token " + _token,},
    );

    // print("jsonDecode(list of not answer student)=   "+const Utf8Decoder().convert(response.bodyBytes));

    if(response.statusCode==200){
      final Map<String, dynamic> data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
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
  Future getAnswers(id)async{
    String url='https://api.piazza.markop.ir/soren/exercises/$id/answers/';
    final _token=await sharedPreferences.getToken('token');
    var response= await http.get(Uri.parse(url),
      headers: { "content-type": "application/json",
        "Authorization": "Token " + _token,},
    );
    if(response.statusCode==200){
      final Map<String, dynamic> data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
      if (data["results"].length>0) {
        final List<  dynamic> list = data["results"];
        for(var v in list) {
          print(v['user_email']);
          answers.add(
              AnswerItemModel.fromJson(Map<String,dynamic>.from(v))
          );
          print(v['user_email']);
        }

      }
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }


}
