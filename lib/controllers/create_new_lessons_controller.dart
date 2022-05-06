

import 'package:flutter/cupertino.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

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
    Jalali? picked = await showPersianDatePicker(
      context: context,
      initialDate: Jalali.now(),
      firstDate: Jalali(1401, 1),
      lastDate: Jalali(1450, 9),
    );
    final date =picked!.formatCompactDate();
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
}