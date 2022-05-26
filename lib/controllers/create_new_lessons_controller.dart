
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:project/helpers/sharedPreferences.dart';
import 'package:jalali_table_calendar/jalali_table_calendar.dart';

class CreateNewLessonsController extends ChangeNotifier
{

  final cnNameLessons = TextEditingController();
  final cnDesc = TextEditingController();
  String? startDate;
  String? endDate;
  String? dateExam;
  final String _url='https://api.piazza.markop.ir/soren/newcourse/';
  final _token=sharedPreferences.getToken('token');
  final form = GlobalKey<FormState>();

  Future showMyDatePicker(BuildContext context,bool? isStartDate)async
  {
    String? date = await jalaliCalendarPicker(context: context,
        selectedFormat:'yyyy/m/d' );
    print(date);
    if(isStartDate==true){
      startDate =date;
    }else if (isStartDate ==false) {
      endDate = date;
    }else {
      print('asdsa');
      dateExam = date;
    }
    notifyListeners();

  }

  Future createNewLessonsRequest()
  async{

    var response= await http.post(Uri.parse(_url),
      headers: { "content-type": "application/json",
        "Authorization": "Token " + _token,},
      body: jsonEncode({
        "title":cnNameLessons,
        "description":cnDesc,
        "start_date":startDate,
        "end_date":endDate,
        "exam_date":dateExam,
      }),
    );

    notifyListeners();
    print("jsonDecode(new lesson)=   "+jsonDecode(response.body));
    final Map<String, dynamic> data = json.decode(response.body);
    if(data.containsKey("id")){
      return true;
    }
    return false;
  }
}