


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
    final _token=await sharedPreferences.getToken('token');
var _url='https://api.piazza.markop.ir/soren/studentexercises/';
    var response= await http.get(Uri.parse(_url),
      headers: { "content-type": "application/json",
        "Authorization": "Token " + _token,},
    );
List<ExerciseItemModel>listOfExercise=[];
    print("jsonDecode(list of exercises)=   "+ Utf8Decoder().convert(response.bodyBytes));
    final Map<String, dynamic> data = json.decode( Utf8Decoder().convert(response.bodyBytes));
    if(data.containsKey("results")){
      final List< dynamic> list = data["results"];
      for(var v in list) {
           listOfExercise.add(ExerciseItemModel.fromJson(v));
        }
    sharedPreferences.setExercise(listOfExercise);
      notifyListeners();
      return true;
      }
    notifyListeners();
    return false;
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
