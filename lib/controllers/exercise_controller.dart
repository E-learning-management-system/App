


import 'package:flutter/material.dart';
import 'package:project/models/exercise_item_model.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:project/helpers/sharedPreferences.dart';

class ExercisesController extends ChangeNotifier
{
  late Map <int , List<String>> answerStudent;
  late Map <int , List<String>> notAnswerStudent;
  final _token=sharedPreferences.getToken('token');

  ExercisesController(){
    getExercisesRequest().then((value) => {print("exercises load")} );
  }

  Future getExercisesRequest()
  async{

    // var response= await http.get(Uri.parse(_url),
    //   headers: { "content-type": "application/json",
    //     "Authorization": "Token " + _token,},
    // );
    //
    // print("jsonDecode(list of subjects)=   "+jsonDecode(response.body));
    // final Map<String, dynamic> data = json.decode(response.body);
    // if(data.containsKey("results")){
    //   final Map<String, dynamic> list = json.decode(data["results"]);
    //   for(var v in list.values) {
    //     v.asMap().forEach((i, value) {
    //       _listOfSubjects.add(SubjectsItemModel.fromJson(value));
    //     });
    //     print(_listOfSubjects);
    List<ExerciseItemModel> list =[ExerciseItemModel(id: 1, title:" تمرین 1", description: "description", teacher: "teacher", date: "30/4/1380", deadline: "1/5/1390", courseName: "courseName", courseId: 5, file: "file"),];
        sharedPreferences.setExercise(list);
    //   }
    // }
    notifyListeners();
    return true;
    // return false;
  }

 // Future changeExercise()async{}




  Future deleteAnswer(id)async{
    String url='https://api.piazza.markop.ir/soren/answer/$id/';
    var  _token = await sharedPreferences.getToken('token');

    var response= await http.delete(Uri.parse(url),
      headers: { "content-type": "application/json",
        "Authorization": "Token " + _token,},
    );

    print("jsonDecode(delete answer)=   "+const Utf8Decoder().convert(response.bodyBytes));
    if(response.statusCode==204){
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;

  }



}
