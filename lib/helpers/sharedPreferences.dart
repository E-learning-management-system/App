

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:project/models/exercise_item_model.dart';
import 'package:project/models/subject_item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project/models/lessons_item_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SharedPreferencesTable{
  bool isLogin=false;
  late Map<String,int> lessons;
  late Map<String,int> topics;
  late Map<String,int> exercise;
  SharedPreferencesTable(){
    setInitial();
    lessons={'test':0};
    topics={'test':0};
  }
  SharedPreferences? pref;
  EncryptedSharedPreferences token = EncryptedSharedPreferences();
  setToken(key,value){
    token.setString(key, value);
  }
  getToken(key){
    return token.getString(key);
  }
  setLogin(){
    isLogin=true;
  }
  setInitial()async{
    pref= (await SharedPreferences.getInstance());
  }
  setLessonTitle(String value){
    pref?.setString('lessonTitle', value);
 }
  getTitle(){
    return pref?.getString('lessonTitle');
  }
  setLessons(List<LessonsItemModel> listOfLessons){
    List<String> myList=[];
    for(var v in listOfLessons){
     myList.add(v.title);
     lessons[v.title]=v.id;
    }

    pref?.setStringList('Lessons', myList);
  }
  setExercise(List<ExerciseItemModel> listOfExercise){
    List<String> myList=[];
    for(var v in listOfExercise){
      myList.add(v.title);
    }

    pref?.setStringList('Exercises', myList);
  }
  setSubjects(List<SubjectsItemModel> listOfSubject){
    List<String> myList=[];
    for(var v in listOfSubject){
      myList.add(v.title);
      topics[v.title]=v.id;
    }

    pref?.setStringList('Subjects', myList);
  }
  addLessons(String title,int id){
    lessons[title]=id;
  }
  getLessons(){
    return pref?.getStringList('Lessons');
  }
  getLessonId(String title){
    return lessons[title];
  }
  getTopicId(String title){
    return topics[title];
  }
  getSubjects(){
    return pref?.getStringList('Subjects');
  }
  getExercises(){
    return pref?.getStringList('Exercises');
  }
  setType(String type){
    pref?.setString('type', type);
  }
  getType(){
   return pref?.getString('type');
  }

  getLessonByTitle(String title)async{
  var  id= getLessonId(title);
  var data= await getLessonById(id);
  return data;
  }
  Future getLessonById(int id)async{
     var token=await getToken('token');
    var url= 'https://api.piazza.markop.ir/soren/course-rud/$id/';
    var response= await http.get(Uri.parse(url),
      headers: { "content-type": "application/json",
        "Authorization": "Token " + token,},
    );

    print("lesson=   "+ const Utf8Decoder().convert(response.bodyBytes));
    final Map<String, dynamic> data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
    if(response.statusCode==200){
      return LessonsItemModel.fromJson(Map<String,dynamic>.from(data));
    }
    return false;
  }


}
final sharedPreferences= SharedPreferencesTable();

