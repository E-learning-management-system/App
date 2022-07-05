

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:project/models/exercise_item_model.dart';
import 'package:project/models/subject_item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project/models/lessons_item_model.dart';

class SharedPreferencesTable{
  bool isLogin=false;
  late Map<String,int> lessons;
  late Map<String,int> topics;
  late Map<String,int> exercise;
  late List<ExerciseItemModel> e=[];
  SharedPreferencesTable(){
    setInitial();
    exercise={'test':0};
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
    e=[];
    List<String> myList=[];
    for(var v in listOfExercise){
      myList.add(v.title);
      e.add(v);
      exercise[v.title]=v.id;
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

  getLessonByTitle(String title){
  var  id= getLessonId(title);
  return id;
  }

  getExerciseByTitle(String title){
    return exercise[title];
  }
  getE(){
    return e;
  }


}
final sharedPreferences= SharedPreferencesTable();

