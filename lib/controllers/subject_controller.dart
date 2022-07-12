


import 'package:flutter/material.dart';
import 'package:project/models/subject_item_model.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:project/helpers/sharedPreferences.dart';

class SubjectsController extends ChangeNotifier
{
  final String _url='https://api.piazza.markop.ir/soren/allsubjects/';
  final List<SubjectsItemModel> _listOfSubjects = [];
  late Map<int,List<SubjectsItemModel>> _listOfSubjectOfCourse;
  get listOfSubjects=>_listOfSubjects;
  get listOfSubjectOfCourse=>_listOfSubjectOfCourse;
  late String _token;
  SubjectsController(){
    sharedPreferences.getToken('token').then((value)=>{_token=value});
    getSubjectsRequest().then((value) => {print("subjects load")} );

  }

  Future getSubjectsRequest()
  async{
    _listOfSubjects.clear();
    _token=await sharedPreferences.getToken('token');
    var response= await http.get(Uri.parse(_url),
      headers: { "content-type": "application/json",
        "Authorization": "Token " + _token,},
    );

    final Map<String, dynamic> data = jsonDecode(Utf8Decoder().convert(response.bodyBytes));
    if(data.containsKey("results")){
      final List< dynamic> list = data["results"];
      for(var v in list) {

          _listOfSubjects.add(SubjectsItemModel.fromJson(Map<String,dynamic>.from(v)));

      }
      print(_listOfSubjects.toList());
      sharedPreferences.setSubjects(_listOfSubjects);
      return true;
    }
    // notifyListeners();
    return false;
  }

  Future getSubjectsOfCourse(id)
  async{

    String url='https://api.piazza.markop.ir/soren/courses/'+id+'/subjects/';

    var response= await http.get(Uri.parse(url),
      headers: { "content-type": "application/json",
        "Authorization": "Token " + _token,},
    );
    final Map<String, dynamic> data = json.decode(response.body);
    if(data.containsKey("results")){
      List<SubjectsItemModel> list1=[];
      final Map<String, dynamic> list = json.decode(data["results"]);
      for(var v in list.values) {
        v.asMap().forEach((i, value) {
          list1.add(SubjectsItemModel.fromJson(value));
        });
        listOfSubjectOfCourse[id]=list1;
        // sharedPreferences.setSubjects(_listOfSubjects);
      }
    }
    notifyListeners();
    return false;
  }


}
