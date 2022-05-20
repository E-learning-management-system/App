

import 'package:flutter/cupertino.dart';
import 'package:jalali_table_calendar/jalali_table_calendar.dart';

class CreateNewLessonsController extends ChangeNotifier
{

  final cnNameLessons = TextEditingController();
  final cnDesc = TextEditingController();
  String? startDate;
  String? endDate;
  String? dateExam;
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
      dateExam = date;
    }
    notifyListeners();

  }
}