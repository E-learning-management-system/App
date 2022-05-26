

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:project/models/exercise_item_model.dart';
import 'package:project/models/subject_item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project/models/lessons_item_model.dart';

class SharedPreferencesTable{
  SharedPreferencesTable(){
    setInitial();
  }
  SharedPreferences? pref;
  EncryptedSharedPreferences token = EncryptedSharedPreferences();
  setToken(key,value){
    token.setString(key, value);
  }
  getToken(key){
    return token.getString(key);
  }

  setInitial()async{
    pref= (await SharedPreferences.getInstance());
  }

  setLessons(List<LessonsItemModel> listOfLessons){
    List<String> myList=[];
    for(var v in listOfLessons){
     myList.add(v.title);
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
    }

    pref?.setStringList('Subjects', myList);
  }

  getLessons(){
    return pref?.getStringList('Lessons');
  }
  getSubjects(){
    return pref?.getStringList('Subjects');
  }
  getExercises(){
    return pref?.getStringList('Exercises');
  }



}
final sharedPreferences= SharedPreferencesTable();

