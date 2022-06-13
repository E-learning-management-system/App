

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:jalali_table_calendar/jalali_table_calendar.dart';

class RecordHomeWorkController extends ChangeNotifier
{
  final controllerResponse =  TextEditingController();
  GlobalKey<FlutterSummernoteState> keyEditor = GlobalKey();
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

  void showDate(BuildContext context)async{
     date = await jalaliCalendarPicker(context: context,
        selectedFormat:'yyyy-mm-dd' );
     notifyListeners();
  }
}