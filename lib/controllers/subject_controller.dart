


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

    var response= await http.get(Uri.parse(_url),
      headers: { "content-type": "application/json",
        "Authorization": "Token " + _token,},
    );

    print("jsonDecode(list of subjects)=   "+jsonDecode(response.body));
    final Map<String, dynamic> data = json.decode(response.body);
    if(data.containsKey("results")){
      final Map<String, dynamic> list = json.decode(data["results"]);
      for(var v in list.values) {
        v.asMap().forEach((i, value) {
          _listOfSubjects.add(SubjectsItemModel.fromJson(value));
        });
        print(_listOfSubjects);
        sharedPreferences.setSubjects(_listOfSubjects);
      }
    }
    notifyListeners();
    return false;
  }

  Future getSubjectsOfCourse(id)
  async{

    String url='https://api.piazza.markop.ir/soren/courses/'+id+'/subjects/';

    var response= await http.get(Uri.parse(url),
      headers: { "content-type": "application/json",
        "Authorization": "Token " + _token,},
    );

    print("jsonDecode(list of subjects)=   "+jsonDecode(response.body));
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