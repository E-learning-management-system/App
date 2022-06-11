

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project/helpers/sharedPreferences.dart';

class FinalLessonsController extends ChangeNotifier
{
  final textEditController2 = TextEditingController();
  final ScrollController scrollController = ScrollController();
  List<String> listItems = [];
  bool isLoading=false;
  late String _token;
  final formEmail = GlobalKey<FormState>();


  void removeItem(int index)
  {
    listItems.removeAt(index);
    notifyListeners();
  }
  void addItemToList()
  {
    if(textEditController2.text.isNotEmpty && formEmail.currentState!.validate())
      {
        listItems.add(textEditController2.text);
        notifyListeners();
        FocusManager.instance.primaryFocus?.unfocus();
        textEditController2.clear();
      }
    return;
  }
Future<bool> addStudentRequest()async{
  isLoading=true;
  notifyListeners();
    var id=sharedPreferences.getLessonId(sharedPreferences.getTitle());
  _token=await sharedPreferences.getToken('token');
  for(var email in listItems){
    email= email.replaceAll('@', '%40');
    String _url='https://api.piazza.markop.ir/soren/courses/$id/newstudent/$email/';
    try {
      var response = await http.post(Uri.parse(_url),
        headers: { "content-type": "application/json",
          "Authorization": "Token " + _token,}, body: jsonEncode({
          "email": email,
          "id": id,
        }),
      );
      print(response.body);
      final Map<String, dynamic> data = jsonDecode(response.body);

      if(!data.containsKey("id")){
        isLoading=false;
        return false;}
    }catch(e){
      print('error:'+e.toString());
  isLoading=false;
  return false;
  }
  }
  isLoading=false;
    return true;

}
}