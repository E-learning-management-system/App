


import 'package:flutter/material.dart';
import 'package:project/models/lessons_item_model.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:project/helpers/sharedPreferences.dart';

class LessonsController extends ChangeNotifier
{
  final String _url='https://api.piazza.markop.ir/soren/courses/';
  final List<LessonsItemModel> _listOfLessons = [];
  get listOfLessons=>_listOfLessons;
  final _token=sharedPreferences.getToken('token');
  LessonsController(){
    getLessonsRequest().then((value) => {print("lessons load")} );
  }

  Future getLessonsRequest()
  async{

    var response= await http.get(Uri.parse(_url),
      headers: { "content-type": "application/json",
        "Authorization": "Token " + _token,},
    );

    print("jsonDecode(list of lesson)=   "+jsonDecode(response.body));
    final Map<String, dynamic> data = json.decode(response.body);
    if(data.containsKey("results")){
      final Map<String, dynamic> list = json.decode(data["results"]);
      for(var v in list.values) {
        v.asMap().forEach((i, value) {
          _listOfLessons.add(LessonsItemModel.fromJson(value));
        });
        print(_listOfLessons);
        sharedPreferences.setLessons(_listOfLessons);
            }
    }
    notifyListeners();
    return false;
  }


}
