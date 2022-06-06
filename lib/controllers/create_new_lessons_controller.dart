
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/helpers/sharedPreferences.dart';
import 'package:jalali_table_calendar/jalali_table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateNewLessonsController extends ChangeNotifier
{

  final cnNameLessons = TextEditingController();
  final cnDesc = TextEditingController();
  String? startDate;
  String? endDate;
  String? dateExam;
  final String _url='https://api.piazza.markop.ir/soren/newcourse/';
  late SharedPreferences preferences;

  final form = GlobalKey<FormState>();

  Future showMyDatePicker(BuildContext context,bool? isStartDate)async
  {
    String? examDate;
    String? date;
    if(isStartDate==null)
      {
         examDate = await jalaliCalendarPicker(context: context, showTimePicker: true,
            selectedFormat: 'yyyy-mm-ddThh:m' );
      }
   else {
     date = await jalaliCalendarPicker(context: context,
          selectedFormat:'yyyy-mm-dd' );
    }


    print(date);
    if(isStartDate==true){
      startDate =date;
    }else if (isStartDate ==false) {
      endDate = date;
    }else {
      print(dateExam);
      dateExam = examDate;
    }
    notifyListeners();

  }


  Future createNewLessonsRequest()
  async{
    print(cnNameLessons.text);
    final _token= await sharedPreferences.getToken('token');
    var response= await http.post(Uri.parse(_url),
      headers: { "content-type": "application/json",
        "Authorization": "Token " + _token,},
      body: jsonEncode({
        "title":cnNameLessons.text,
        "description":cnDesc.text,
        "start_date":startDate,
        "end_date":endDate,
        "exam_date":dateExam,
      }),
    );

    notifyListeners();
    print("jsonDecode(new lesson)=   "+Utf8Decoder().convert(response.bodyBytes));
    final Map<String, dynamic> data = jsonDecode(Utf8Decoder().convert(response.bodyBytes));
    if(data.containsKey("id")){
      await sharedPreferences.setLessonTitle(cnNameLessons.text);
      await sharedPreferences.addLessons(cnNameLessons.text,  data['id']);
      cnNameLessons.clear();
      cnDesc.clear();

      return true;
    }
    return false;
  }

}