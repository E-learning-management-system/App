

import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:jalali_table_calendar/jalali_table_calendar.dart';
import 'package:project/helpers/sharedPreferences.dart';

class RecordHomeWorkController extends ChangeNotifier
{
  final controllerResponse =  TextEditingController();
  GlobalKey<FlutterSummernoteState> keyEditor = GlobalKey();
  late TextEditingController titleController;
  late TextEditingController desController;
  setTitle(title){
    titleController=TextEditingController(text: title);
  }
  setDes(des){
    desController=TextEditingController(text: des);
  }
  File? file;
  String? date;
  void uploadFile() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = File(result.files.single.path!);
      notifyListeners();
    } else {
    }
  }
  void deleteFile()async{
    if(file!=null)
    {
      file!.delete();
      file=null;
    }
    notifyListeners();
  }
  String calPercentage(int first , int two)
  {
    final per = (first / two ) * 100;
    final result = per.toString() +'%';
    return result + '\n'+ 'تخویل داده اند';
  }

  Future newExercise(id)async{
    String url='https://api.piazza.markop.ir/soren/courses/$id/newexercise/';
   var  _token = await sharedPreferences.getToken('token');
    var des=await keyEditor.currentState?.getText();

    var response= await http.post(Uri.parse(url),
        headers: { "content-type": "application/json",
          "Authorization": "Token " + _token,},body:
        jsonEncode
          ({
          "title": titleController.text,
          "description": des,
          "deadline": date! ,
          "file": file,

        })
    );

    print("jsonDecode(new exercise)=   "+const Utf8Decoder().convert(response.bodyBytes));
    if(response.statusCode==201){
      notifyListeners();
      return true;
    }

    notifyListeners();
    return false;

  }
  Future deleteExercise(id)async{
    String url='https://api.piazza.markop.ir/soren/exercise-rd/$id/';
    var  _token = await sharedPreferences.getToken('token');

    var response= await http.delete(Uri.parse(url),
      headers: { "content-type": "application/json",
        "Authorization": "Token " + _token,},
    );

    print("jsonDecode(delete exercise)=   "+const Utf8Decoder().convert(response.bodyBytes));
    if(response.statusCode==204){
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;

  }
  Future newAnswer(id)async{
    String url='https://api.piazza.markop.ir/soren/exercises/$id/newanswer/';
    var  _token = await sharedPreferences.getToken('token');
    var des=await keyEditor.currentState?.getText();
    var response= await http.post(Uri.parse(url),
        headers: { "content-type": "application/json",
          "Authorization": "Token " + _token,},body:
        jsonEncode
          ({
          "description": des,
          "file": file

        })
    );

    print("jsonDecode(new answer)=   "+const Utf8Decoder().convert(response.bodyBytes));
    if(response.statusCode==201){
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;

  }

  void showDate(BuildContext context)async{
     date =  await jalaliCalendarPicker(context: context, showTimePicker: true,
         selectedFormat: 'yyyy-mm-ddThh:m' );
     notifyListeners();
  }
}