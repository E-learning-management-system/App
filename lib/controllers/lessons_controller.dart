


import 'package:flutter/material.dart';
import 'package:project/helpers/utility.dart';
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
  late String _token;

  deleteLesson(int id)async {
    String url='https://api.piazza.markop.ir/soren/course-rud/$id/';
    var  _token = await sharedPreferences.getToken('token');

    var response= await http.delete(Uri.parse(url),
      headers: { "content-type": "application/json",
        "Authorization": "Token " + _token,},
    );

    if(response.statusCode==204){

      await getLessonsRequest();
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }
  Future getLessonsRequest()
  async{
    _listOfLessons.clear();
    _token=await sharedPreferences.getToken('token');
    var response= await http.get(Uri.parse(_url),
      headers: { "content-type": "application/json",
        "Authorization": "Token " + _token,},
    );
    final Map<String, dynamic> data = jsonDecode(Utf8Decoder().convert(response.bodyBytes));
    if(data.containsKey("results")){
      final List< dynamic> list = data["results"];
      for(var v in list) {
        // print(v.runtimeType);

          _listOfLessons.add(LessonsItemModel.fromJson(Map<String,dynamic>.from(v)));

            }
      sharedPreferences.setLessons(_listOfLessons);
      // notifyListeners();
      return true;

    }

    return false;
  }




}
